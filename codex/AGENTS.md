# Codex agent instructions - General

- I don't have genera instructions yet, only formatting, see below

# Codex agent instructions - Formatting

## General behavior for formatting
- After making any code change, always try to format the affected files before finishing.
- Prefer formatting only the files you changed.
- Do not reformat unrelated files unless the user explicitly asks for a broader formatting pass.
- If a project already has its own formatter configuration, follow it.
- If multiple formatters are available, choose the one that best matches the language and the repository’s existing tooling.
- If formatting cannot be run, briefly explain why.
- If a formatter reports syntax errors or parse errors, report that clearly instead of hiding it.

## Formatters available in this environment

### JavaScript / TypeScript / JSON / YAML / Markdown
- Use `prettier`.
- Prefer the repository's existing Prettier config if present.
- Try formatting changed files with `prettier --write`.

### PHP
- Use `php-cs-fixer`.
- Prefer the repository's existing PHP-CS-Fixer config if present.
- Try formatting changed files with `php-cs-fixer fix`.

### Perl
- Use `perltidy`.
- Prefer the repository's existing perltidy config if present.
- Try formatting changed files with `perltidy -b`.

### Go
- Always run `gofmt` on changed Go files if it is available.
- If `gofmt` is not available but another standard Go formatter is available, use that.
- Keep formatting aligned with standard Go tooling.

## Formatter selection rules

- JavaScript family: `prettier`
- TypeScript family: `prettier`
- JSON: `prettier`
- YAML: `prettier`
- Markdown: `prettier`
- PHP: `php-cs-fixer`
- Perl: `perltidy`
- Go: `gofmt`

## Safety rules for formatting

- Never invent a formatter that is not installed.
- Never add a new formatter dependency unless the user asks.
- Never change formatter configuration unless the user asks.
- Avoid destructive or repo-wide formatting when a targeted formatting pass is enough.

## Completion expectations for formatting

- Before finishing, check whether any changed files should be formatted.
- If formatting was run, mention that it was run.
- If formatting was skipped, say why.

