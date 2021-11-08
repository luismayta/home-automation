<!-- Space: HomeAutomation -->
<!-- Parent: Project -->
<!-- Title: Composes Restic -->

<!-- Label: HomeAutomation -->
<!-- Label: Project -->
<!-- Label: Compose -->
<!-- Label: Restic -->
<!-- Include: docs/disclaimer.md -->
<!-- Include: ac:toc -->

## Commands

### Run

```bash
pipenv run docker-compose -f docker-compose.yml -f provision/compose/restic.yml up -d
```

## Manage users

### Add user

```bash
pipenv run docker-compose -f docker-compose.yml -f provision/compose/restic.yml exec -it restic create_user myuser mypassword
```

### Delete user

```bash
pipenv run docker-compose -f docker-compose.yml -f provision/compose/restic.yml exec -it restic delete_user myuser
```
