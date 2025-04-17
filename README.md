# fooconf

Videoconference web-app written with Go and _???_.

Goal is to make it look like 'production-grade project'

## MVP

- default user management with auth. \*2fa
- two types of meetings: 1v1 and conference
- conference must support up to 10 participants with decent audio/video quality

## TODO

### Design

- [ ] Define application components
- [ ] Design a Database(models, relations)
- [ ] Design an API
- [ ] Frontend: vue/htmx+alpine???
- [ ] WebRTC server???

### PROJECT SETUP

- [ ] a template makefile
- [x] golang linter config
- [x] hot-reload config
- [x] editorconfig
- [ ] dockerfile for API service
- [ ] docker compose for API service and postgres
- [~] pre-commit hooks
  - [x] commit naming
  - [x] linter checks
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
