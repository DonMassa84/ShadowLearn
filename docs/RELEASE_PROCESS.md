# Release-Prozess

## Versionierung

Empfohlen: SemVer.

- v0.x.y für Portfolio-/Prototypenstände
- v1.0.0 erst bei stabiler Bedienung, dokumentierter Installation und grünem Release-Check

## Release Check

~~~bash
make release-check
~~~

## Commit-Konvention

~~~text
feat: add reproducible setup
fix: sanitize public output
docs: add runbook
chore: standardize repository baseline
~~~

## Tagging

~~~bash
git tag -a v0.1.0 -m "v0.1.0 reproducible baseline"
git push origin main --tags
~~~

## Release Notes

Jedes Release dokumentiert:

- Zweck
- Änderungen
- Teststatus
- Security-Hinweise
- bekannte Grenzen
