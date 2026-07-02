<!-- Auto-generated guidance for AI coding agents. Update after repository inspection. -->
# Copilot instructions for this repository

Purpose
- Help AI agents quickly become productive by describing where to look, which commands to run, and how to merge any discovered guidance into this file.

Quick discovery steps (run immediately)
- List top-level files and folders: `ls -la` and `find . -maxdepth 2 -type d -print`.
- Search for common manifests: look for `package.json`, `pyproject.toml`, `requirements.txt`, `go.mod`, `Cargo.toml`, `Dockerfile`, `Makefile`, and files under `.github/workflows`.
- Search for agent docs to merge: `**/.github/copilot-instructions.md`, `AGENT.md`, `AGENTS.md`, `CLAUDE.md`, `.cursorrules`, `.windsurfrules`, `.clinerules`, `README.md`.

How to update this file
- If this file exists already, preserve any human-written sections and append a short "AI-updated" section explaining what was discovered and why changes were introduced.
- Prefer concise, concrete examples (file paths, commands, config keys). Keep total file length ~20–50 lines.

What to look for (architecture & key components)
- Locate runtime/service directories (common names: `src/`, `cmd/`, `services/`, `apps/`, `packages/`). Note which language each uses from manifests.
- Find infra and deployment: `Dockerfile`, `k8s/`, `charts/`, `terraform/` — record any image names, ports, and env var keys.
- Identify data flows: search for HTTP clients, message brokers, DB clients (look for libs like `axios`, `requests`, `pg`, `sqlalchemy`, `gorm`, `redis`).

Build / test / debug commands (how to discover)
- If `package.json` exists, prefer `npm ci`/`yarn install` and use the `scripts` section (e.g., `npm run build`, `npm test`).
- If Python: look for `pyproject.toml` / `requirements.txt` and common tools: `pytest`, `tox`, `poetry`.
- If there is a `Makefile` or `.github/workflows`, extract canonical commands from there and add concrete examples in this file.

Repository conventions to capture
- Formatting / linting: check for `prettier`, `eslint`, `black`, `ruff`, or `gofmt` configs and record the exact commands.
- Branch/commit/PR patterns: look for `CONTRIBUTING.md` or `.github/ISSUE_TEMPLATE` and summarize rules to follow.

Integration & secrets
- Check for `.env`, `.env.example`, or `config/` files to list required env vars. Do not commit secrets — if you find secrets, report them and stop.
- Note external services (e.g., AWS, GCP, Sentry, Stripe) by scanning for provider SDKs or hostnames in config.

Examples to include when discovered
- File-based example: "`src/api/server.ts` is the HTTP entrypoint; run `npm run dev` to start locally." Replace with repository-specific paths and commands.
- CI example: "Workflow `.github/workflows/ci.yml` runs `make test` — use this as canonical test command."

Merge rules for existing AI-written content
- Keep original content; add a short `<!-- AI-updated: YYYY-MM-DD -->` block with new discoveries.
- If conflicts exist between discovered commands and this file, prefer concrete CI / Makefile commands found in the repo.

If you (the agent) cannot find any of the above
- Add a short diagnostic block listing which files were and were not found, and ask the human maintainer for the next steps.

Finally
- After updating, post a concise summary comment in the PR describing what you changed and list any action items for humans (missing README sections, unclear build steps).
- Ask the maintainer one question if anything essential is missing (for example: "Which command starts the app locally?").

-- End of guidance
<!-- AI-updated: 2026-01-14 -->
Current scan results
- Found: the repository contains a single `.github/` directory and this `copilot-instructions.md` file.
- Not found: no `package.json`, `pyproject.toml`, `requirements.txt`, `Makefile`, `Dockerfile`, `README.md`, or CI workflow files were detected in the top 3 levels.

Next steps for maintainers
- If this is a code repository, please provide the project entrypoint(s) (e.g., `package.json`, `pyproject.toml`, `README.md`) or tell me which folder contains the source. I will re-scan and populate concrete build/test commands and examples.
- If this repository is intentionally empty or contains only infra/docs, indicate the canonical dev workflow so I can record it here.
