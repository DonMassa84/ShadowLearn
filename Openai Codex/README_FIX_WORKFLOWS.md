Fix GitHub Actions workflows helper

This small helper scans `.github/workflows/*.yml` files and applies two safe fixes:

- Adds a default `permissions` block with write permissions for `contents`, `pull-requests`, `issues`, and `workflows` if not present.
- Ensures `actions/checkout` steps include `persist-credentials: true`.

Usage

1. Install dependencies:

```bash
python3 -m pip install pyyaml
```

2. Run the tool from your repository root (or pass a path):

```bash
python3 tools/fix_github_workflows.py .
```

Notes
- The tool creates a `.bak` backup for every file it modifies.
- Review diffs before committing; these changes are conservative but repository-specific needs may vary.
