# Codex Container Helper

Wrapper script and Docker image to run the Codex CLI inside a preconfigured container with a persistent home volume.

## Quick start

- Build the image: `make build`.
- Before logging in, enable `Device code authorization for Codex` in ChatGPT Security settings: `https://chatgpt.com/#settings/Security`.
- Run `make login` once to authenticate Codex in the persistent `codex-home` Docker volume.
- Run `make install` once to copy the `codex` wrapper to `/usr/local/bin/madcodex` (requires `sudo`).
- To install the wrapper under a different executable name, pass that name as a second make goal. For example, `make install codexc` copies the wrapper to `/usr/local/bin/codexc`.
- Run the CLI from any project: `madcodex <args>` by default, or use the custom executable name you installed. The current directory is mounted at `/agent-workspace` and the named volume `codex-home` is mounted as the container home.
