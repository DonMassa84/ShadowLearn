# Repo Agent Mapping — Schreibtisch

## Dieses Repo

| Feld | Wert |
|---|---|
| Repository | Schreibtisch |
| Agent-Rolle | Repo-Orchestrator-Compatible Agent Module |
| Wissensmodell | 6-Komponenten-Agent |
| Sicherheitsmodus | Human Review bei Risiko |
| Betriebsziel | reproduzierbar, prüfbar, portfoliofähig |

## Gesamt-Mapping

| Repo / System | Agent-Rolle |
|---|---|
| OpenClaw Edge Memory Search | Sanitizer-Agent / Portfolio-Security-Agent |
| ProofFlow OS | Cleanup-/Workflow-Agent |
| ProofFlow Obsidian Vault | Knowledge-Agent |
| Local Focus OS | Dashboard-Agent |
| OpenClaw AI Governance | Review-Agent / Governance-Agent |
| Shadowmaker Talk Workflows | Auth-/Ops-Agent |
| USB LLM Data Pipeline | Import-/Pipeline-Agent |
| Repo Test Reports | QA-Agent |
| Alle Repos | Repo-Orchestrator |

## Orchestrator-Regel

Der Repo-Orchestrator prüft:

1. Welche Repo-Rolle vorliegt.
2. Welche Tools nötig sind.
3. Welche Memory-Information relevant ist.
4. Welche Guardrails greifen.
5. Welche Schritte ausgeführt werden.
6. Ob das Ergebnis testbar und commit-ready ist.

