# Agent Containers

Run your agent in a container, not loose on your host.

This project is a small home for containerized agent runners. The idea is simple: give your agent a workspace it can use freely, but keep that workspace inside Docker where the blast radius is much smaller.

It is safer, cleaner, and a lot more fun to experiment with.

## Why This Exists

Agents are powerful. They also love having tools, shells, runtimes, formatters, debuggers, and whatever else helps them get work done.

Installing all of that directly on your host is convenient right up until it is not.

With this project:

- The agent runs inside a container instead of directly on your machine.
- Security improves because the agent gets a stronger isolation boundary.
- You can try extra tools and CLIs for the agent without cluttering your host.
- You can offer agent-specific environments tailored to the work, not your laptop.
- Your host stays cleaner while the agent still gets a capable toolbox.

## What It Supports

Right now, this repo supports:

- **Codex**
- **Claude Code**

## What You Need

You need **Docker**.

On macOS, that usually means **Docker Desktop**.

That is the whole trick. No NodeJS needed, just Docker...

## How To Use Codex

1. Clone this repository.
2. Change into the `codex` directory.
3. Build the image:

```bash
make build
```

4. Before logging in, enable `Device code authorization for Codex` in ChatGPT Security settings:

`https://chatgpt.com/#settings/Security`

5. Authenticate once:

```bash
make login
```

6. Install the wrapper (you can pass an optional name for the executable to replace `codex`):

```bash
make install
```

7. Go to the project folder where you want to use Codex and run:

```bash
codex
```

Run `codex` from inside the project directory you want mounted into the container. That project becomes the agent workspace.

### Codex X11 Clipboard

The Codex wrapper passes host `DISPLAY`, mounts Xauthority, and uses `--network host` on Linux. This lets Codex inside the container reach SSH-forwarded X11 displays and use clipboard tools for screenshot paste workflows.

After updating the wrapper:

1. Run `make build` from the `codex` directory.
2. Run `make install` from the `codex` directory.
3. Start `codex` again from a shell where `echo "$DISPLAY"` works.

Check from inside the Codex shell if needed:

```bash
echo "$DISPLAY"
xauth list
xclip -selection clipboard -o >/dev/null
```

## How To Use Claude Code

1. Clone this repository.
2. Change into the `claude` directory.
3. Build the image:

```bash
make build
```

4. Install the wrapper:

```bash
make install
```

5. Go to the project folder where you want to use Claude Code and run:

```bash
claude
```

On first run, Claude Code will prompt you to authenticate.

Run `claude` from inside the project directory you want mounted into the container. That project becomes the agent workspace.

The Claude wrapper mounts projects under a deterministic subfolder of `/agent-workspace`, based on the host folder name and path. This gives each project a distinct path inside the container so Claude Code does not reuse memories or indexes from a different project that happened to mount at the same location.

## Timezone

Both wrappers pass the host timezone into the container. They read `$TZ` first, then `/etc/timezone`, then `/etc/localtime` symlink paths when available. If `/etc/localtime` exists, they also mount it read-only.

After updating a wrapper:

1. Run `make install` from the relevant `codex` or `claude` directory.
2. Start `codex` or `claude` again.
3. Check with `date` inside the agent shell.

## The Pitch

Think of this repo as a safer workshop for coding agents:

- Your host machine keeps its dignity.
- Your agent gets its own toolbox.
- You get a better security boundary.
- You can experiment freely without turning your laptop into an agent habitat.

Container first. Host second. Fewer regrets.
