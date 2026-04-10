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
- **Claude Code** (currently untested)

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

6. Install the wrapper (you can pass an optional name for the executable to replace madcodex):

```bash
make install
```

7. Go to the project folder where you want to use Codex and run:

```bash
madcodex
```

Run `madcodex` from inside the project directory you want mounted into the container. That project becomes the agent workspace.

## How To Use Claude Code

1. Clone this repository.
2. Change into the `claude` directory.
3. Build the image:

```bash
make build
```

4. Authenticate once:

```bash
make login
```

If Claude Code does not immediately prompt for authentication, run `/login`.

5. Install the wrapper:

```bash
make install
```

6. Go to the project folder where you want to use Claude Code and run:

```bash
madclaude
```

Run `madclaude` from inside the project directory you want mounted into the container. That project becomes the agent workspace.

Claude Code support is included, but it is currently **untested**. The setup mirrors the Codex runner, but it has not been verified end-to-end yet.

## The Pitch

Think of this repo as a safer workshop for coding agents:

- Your host machine keeps its dignity.
- Your agent gets its own toolbox.
- You get a better security boundary.
- You can experiment freely without turning your laptop into an agent habitat.

Container first. Host second. Fewer regrets.
