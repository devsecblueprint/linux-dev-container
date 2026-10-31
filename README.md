# Linux Development Container

An Ubuntu 24.04 development environment configured to run as `root`. It includes
common build, Git, editing, and network diagnostic tools. The project is set up
to work as a [VS Code Dev Container](https://code.visualstudio.com/docs/devcontainers/containers).

## Requirements

- Docker Desktop or another running Docker Engine
- For the VS Code workflow: Visual Studio Code and the **Dev Containers**
  extension (`ms-vscode-remote.remote-containers`)

## Use with VS Code

1. Open this project folder in Visual Studio Code.
2. Run **Dev Containers: Reopen in Container** from the Command Palette
   (`Cmd+Shift+P` on macOS, `Ctrl+Shift+P` on Linux/Windows).
3. VS Code builds the image from the root `Dockerfile` and opens the project
   inside the container. The project is available at `/workspace`.
4. Open a VS Code terminal to work in the container. It uses Bash and runs as
   `root`.

The first build downloads Ubuntu and installs the packages listed in the
`Dockerfile`. If you change the `Dockerfile` or `.devcontainer/devcontainer.json`,
run **Dev Containers: Rebuild Container** from the Command Palette.

## Use with Docker directly

Run these commands from the project directory to build the image, start a
container with the project mounted at `/workspace`, and open a root shell:

```sh
docker build -t linux-dev-container .
docker run -d --name linux-dev-container \
  -v "$PWD:/workspace" \
  -w /workspace \
  linux-dev-container
docker exec -it linux-dev-container bash
```

When finished, exit the shell and stop the container:

```sh
exit
docker stop linux-dev-container
```

Start the stopped container again with `docker start linux-dev-container`, then
connect with `docker exec -it linux-dev-container bash`. To remove it when you
no longer need it, run `docker rm linux-dev-container`.

## Included tools

The base image is Ubuntu 24.04. The Dockerfile installs Bash, Git, a C/C++
build toolchain, `curl`, OpenSSH client tools, and common network and process
diagnostics, along with `nano`, `vim`, and `less`. Add other project-specific
tools to the `Dockerfile` and rebuild the container.

## Important notes

- This environment intentionally runs as `root`. Commands inside it have
  elevated privileges within the container; use care with scripts and mounted
  files.
- In the VS Code workflow, the project files live on the host and are mounted
  into the container. In the direct Docker workflow above, the explicit volume
  mount does the same. Changes to those files persist on the host.
- Changes made only to the running container (for example, installing a
  package interactively) are not part of the image and may be lost when the
  container is removed. Add required tools to the Dockerfile and rebuild to
  make them repeatable.
