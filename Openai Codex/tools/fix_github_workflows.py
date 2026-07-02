#!/usr/bin/env python3
"""
Fix GitHub Actions workflow YAMLs in-place:
- ensure a minimal `permissions` block allowing writes for common automation tasks
- ensure `actions/checkout` steps have `persist-credentials: true`

Usage:
  python tools/fix_github_workflows.py [path]
If `path` is omitted the current directory is scanned.
"""
import sys
import os
import glob
import shutil
from typing import Any

try:
    import yaml
except Exception:
    print("PyYAML is required. Install with: pip install pyyaml", file=sys.stderr)
    sys.exit(2)


DEFAULT_PERMISSIONS = {
    "contents": "write",
    "pull-requests": "write",
    "issues": "write",
    "workflows": "write",
}


def merge_permissions(existing: Any) -> Any:
    if not isinstance(existing, dict):
        return DEFAULT_PERMISSIONS.copy()
    merged = existing.copy()
    for k, v in DEFAULT_PERMISSIONS.items():
        # if existing has a broader permission like 'write'/'read', keep it
        if k not in merged:
            merged[k] = v
    return merged


def ensure_checkout_step(step: dict) -> bool:
    uses = step.get("uses")
    if not uses:
        return False
    if not str(uses).startswith("actions/checkout"):
        return False
    with_block = step.get("with") or {}
    changed = False
    if with_block.get("persist-credentials") is not True:
        with_block["persist-credentials"] = True
        changed = True
    step["with"] = with_block
    return changed


def process_file(path: str) -> None:
    print(f"Processing {path}")
    with open(path, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f)

    if data is None:
        print("  empty or invalid YAML, skipping")
        return

    orig = yaml.safe_dump(data)
    changed = False

    # ensure permissions
    perms = data.get("permissions")
    new_perms = merge_permissions(perms)
    if new_perms != perms:
        data["permissions"] = new_perms
        changed = True

    # ensure checkout steps
    # workflows may be a top-level mapping with 'jobs'
    jobs = data.get("jobs") or {}
    for job_name, job in jobs.items():
        if not isinstance(job, dict):
            continue
        steps = job.get("steps") or []
        for step in steps:
            try:
                if ensure_checkout_step(step):
                    changed = True
            except Exception:
                pass

    if changed:
        # backup
        bak = path + ".bak"
        shutil.copy2(path, bak)
        with open(path, "w", encoding="utf-8") as f:
            yaml.safe_dump(data, f, sort_keys=False)
        print(f"  updated (backup at {bak})")
    else:
        print("  no changes needed")


def main():
    base = sys.argv[1] if len(sys.argv) > 1 else os.getcwd()
    pattern = os.path.join(base, ".github", "workflows", "*.yml")
    files = glob.glob(pattern)
    if not files:
        print("No workflow YAMLs found at:", pattern)
        sys.exit(0)
    for p in files:
        try:
            process_file(p)
        except Exception as e:
            print(f"Error processing {p}: {e}", file=sys.stderr)


if __name__ == "__main__":
    main()
