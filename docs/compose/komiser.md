<!-- Space: ComposeServices -->
<!-- Parent: Project -->
<!-- Title: Composes Komiser -->

<!-- Label: ComposeServices -->
<!-- Label: Project -->
<!-- Label: Compose -->
<!-- Label: Komiser -->
<!-- Include: docs/disclaimer.md -->
<!-- Include: ac:toc -->

## Commands

### Native

#### Run

```bash
pipenv run docker-compose -f docker-compose.yml -f provision/compose/komiser.yml up -d --remove-orphans
```

#### Down

```bash
pipenv run docker-compose -f docker-compose.yml -f provision/compose/komiser.yml down
```

### Task

#### service

```bash
task compose:komiser -- {command example: ps}
```

#### Run

```bash
task compose:komiser:up
```

#### Down

```bash
task compose:komiser:down
```
