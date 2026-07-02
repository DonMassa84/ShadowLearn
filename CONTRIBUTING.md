# Contributing

## Arbeitsweise

1. Kleine, nachvollziehbare Commits.
2. Vor jedem Push:

~~~bash
make doctor
make test
make security
~~~

3. Keine Secrets, keine privaten Rohdaten, keine lokalen Pfade.
4. Änderungen an Architektur oder Betriebsweise als ADR dokumentieren.

## Commit-Stil

- feat:
- fix:
- docs:
- chore:
- security:
