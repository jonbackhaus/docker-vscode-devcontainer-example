# docker-vscode-devcontainer-example

Example repository demonstrating how to configure a VS Code compatible development container with both profile persistence and an ephemeral volume for VS Code extensions, while running as a non-root user.

## Methodology

### [`.devcontainer.json`](.devcontainer.json)

The `.devcontainer.json` specification uses the `build` directive to automatically (re)build the development container on-the-fly.

The `.devcontainer.json` specification also configures the `remoteUser` to a non-root account (`vscode`, by default) and configures a named Docker volume (`profile`) to persist the `vscode` user's home folder across container (re)builds.

### [Dockerfile](Dockerfile)

The `Dockerfile` accepts three build arguments:

- `BASE_IMAGE`: the base image name
- `BASE_TAG`: the base image tag
- `USERNAME`: the (non-root) container user (`vscode` by default)

Together, the `BASE_IMAGE:BASE_TAG` replace the `image` directive which would otherwise be specified in the `.devcontainer.json` file.

The `Dockerfile` also provisions an anonymous volume for the `~/.vscode-server` directory, such that VS Code will correctly install extensions on container (re)build.

## Caveats

### Home Folder Volume Mount

The `.devcontainer.json` file configures a named Docker volume (`profile`) to persist the `vscode` user's home folder across container (re)builds. This volume, named `profile`, would be shared by any dev container on the user's machine (assuming a similar mount configuration).

To make the volume unique to the current (named) development container, modify the volume `source` parameter to include the `-${devcontainerId}` suffix; see [Variables in devcontainer.json](https://containers.dev/implementors/json_reference/#variables-in-devcontainerjson) for details.
