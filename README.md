# fooconf

Videoconference web-app written with Go and _???_.

## MVP

- rooms with up to N participants can speak, share screens and webcam video with
  decent quality
- chat
- user auth with password restore functionality
- most security measures implemented

## TODO

### PROJECT SETUP

- [x] a template makefile
- [x] golang linter config
- [x] air config
- [x] editorconfig
- [x] dockerfile for API service
- [x] docker compose for API service
- [~] pre-commit hooks
  - [x] commit naming
  - [x] linter checks
  - [ ] running tests
- [ ] github actions
  - [ ] tests
  - [ ] linting
- [ ] go project versioning

### Backend

- [ ] API Service for creating rooms
- [ ] AUTH Service for authentication
- [ ] WebRTC Server
