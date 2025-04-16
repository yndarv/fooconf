# fooconf

Videoconference web-app written with Go and *???*.

Goal is to make it look like 'production-grade project'

## MVP

- default user management with auth. *2fa
- two types of meetings: 1v1 and conference
- conference must support up to 10 participants with decent audio/video quality

![[./docs/mvp.svg]]

## TODO

### Design

- [ ] Define application components
- [ ] Design a Database(models, relations)
- [ ] Design an API
- [ ] Frontend: vuejs/htmx+alpine???
- [ ] WebRTC server???

### PROJECT SETUP

- [ ] a template makefile
- [ ] golang linter config
- [ ] hot-reload config
- [ ] editorconfig
- [ ] pre-commit hooks
  - [ ] commit naming
  - [ ] linter checks
  - [ ] running tests
- [ ] github actions
  - [ ] tests
  - [ ] linting

## Going further

- Microservice architecture with gRPC for services and GraphQL for client
- Queues
- Caching
- Metrics
- Deployment with k8s

## Used as a reference

- https://github.com/ardanlabs/service
- https://github.com/rasadov/EcommerceAPI
