<!-- Space: ComposeServices -->
<!-- Parent: Project -->
<!-- Title: Composes Portainer -->

<!-- Label: ComposeServices -->
<!-- Label: Project -->
<!-- Label: Compose -->
<!-- Label: Portainer -->
<!-- Include: docs/disclaimer.md -->
<!-- Include: ac:toc -->

## Commands

### Native

#### Run

```bash
pipenv run docker-compose -f docker-compose.yml -f provision/compose/portainer.yml up -d --remove-orphans
```

#### Down

```bash
pipenv run docker-compose -f docker-compose.yml -f provision/compose/portainer.yml down
```

### Task

#### service

```bash
task compose:portainer -- {command example: ps}
```

#### Run

```bash
task compose:portainer:up
```

#### Down

```bash
task compose:portainer:down
```
