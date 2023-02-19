### docker-anchor-wrapper

An anchor-cli wrapper run on the docker container. The docker can init the Solana project with the following command

```
./anchor_wrapper.sh <new-project> solana-anchor:latest
```

### Usage commands

- New project: Initialize the Anchor project.
  - Run docker container to configure the project with input parameters.
  - Init some CLI scripts to work with the project.
    - make init
    - make run