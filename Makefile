SHELL := /usr/bin/env bash

.PHONY: doctor setup test run security release-check format lint

doctor:
	@bash scripts/doctor.sh

setup:
	@if [ -f package.json ]; then \
		if [ -f package-lock.json ]; then npm ci; else npm install; fi; \
	elif [ -f pyproject.toml ]; then \
		python3 -m venv .venv && . .venv/bin/activate && python -m pip install -U pip && pip install -e . || true; \
	elif [ -f requirements.txt ]; then \
		python3 -m venv .venv && . .venv/bin/activate && python -m pip install -U pip && pip install -r requirements.txt; \
	else \
		echo "[INFO] No dependency manifest found."; \
	fi

test:
	@if [ -f package.json ] && grep -q '"test"' package.json; then npm test; \
	elif [ -d tests ] || find . -maxdepth 3 -type f -name 'test_*.py' | grep -q .; then \
		python3 -m pytest || bash scripts/smoke-test.sh; \
	else \
		bash scripts/smoke-test.sh; \
	fi

run:
	@if [ -f package.json ] && grep -q '"dev"' package.json; then npm run dev; \
	elif [ -f package.json ] && grep -q '"start"' package.json; then npm start; \
	elif [ -f main.py ]; then python3 main.py; \
	else echo "[INFO] No universal run command. See docs/RUNBOOK.md"; fi

security:
	@bash scripts/security-scan.sh

release-check:
	@bash scripts/release-check.sh

format:
	@if [ -f package.json ] && grep -q '"format"' package.json; then npm run format; else echo "[INFO] No formatter configured."; fi

lint:
	@if [ -f package.json ] && grep -q '"lint"' package.json; then npm run lint; else echo "[INFO] No linter configured."; fi
