# Contributing to git-sprint

Thanks for helping improve `git-sprint` — this document explains how to get started, run tests, and submit changes.

## Quick start (local development)

1. Clone the repository:

```bash
git clone https://github.com/clivewalkden/git-sprint.git
cd git-sprint
```

2. Make scripts executable and add the repo to your `PATH` for iterative testing:

```bash
chmod +x git-sprint* gitsprint-* || true
export PATH="$PWD:$PATH"
```

3. Run commands directly from the repo while developing (for example `git-sprint-init --help`).

## Coding standards

- Shell scripts should be POSIX-compliant where practical and use `sh` shebangs used by the project.
- Keep functions small and testable in `gitsprint-common` and shared libraries.
- Use clear, descriptive commit messages. Follow an informal convention: `type(scope): short description` (e.g. `feat(init): add config bootstrap`).
- Add or update documentation in `README.md` or `CONTRIBUTING.md` when changing behavior.

## Linting and tests

We recommend the following tools for a consistent contributor experience:

- `shellcheck` for linting shell scripts.
- `bats-core` for shell unit/integration tests.
- `shfmt` (optional) for formatting if desired.

Run linting locally:

```bash
shellcheck $(ls | grep -E "(^git-sprint|gitsprint-).*\$" || true)
```

Run tests (when present):

```bash
# if using bats
bats test/
```

# Quick checks for CLI flags

You should verify the global flags locally as part of development and tests:

```
# Dry-run should print actions without executing them
git sprint --dry-run create test-sprint

# Verbose/debug mode should enable more logging
git sprint --verbose create test-sprint
```

Suggested `bats` test to assert `--dry-run` behavior:

```
@test "dry-run prints git commands" {
	run git-sprint --dry-run create test-sprint
	[ "$status" -eq 0 ]
	[[ "$output" = *"DRY-RUN: git" ]]
}
```

## Branching and workflow

- Create a feature branch from `development` (or `main` if you follow trunk-based flow):

```bash
git checkout development
git pull
git checkout -b feat/your-feature
```

- Make focused commits and push the branch to your fork.
- Open a Pull Request targeting `development` (or `main` per repo policy).

## Pull requests

- Use descriptive PR titles and include a short summary of the change.
- Link any relevant issues.
- Ensure CI passes and linting is clean.
- Add a short testing checklist in the PR description (commands you ran locally).

- Add tests for any new CLI flags and verify `--dry-run` behavior where applicable.

See the project's pull request template for a recommended PR format: `.github/PULL_REQUEST_TEMPLATE.md`

## Code review checklist

- Does the change have tests or a rationale for why tests aren't needed?
- Are scripts still POSIX-compatible where required?
- Are any new user-facing behaviors documented in `README.md`?
- Is installation or upgrade impact documented (the installer script, `contrib/gitsprint-installer.sh`)?

## Release and versioning

- Update the `contrib/gitsprint-installer.sh` and `git-sprint-version` behavior if adding breaking changes.
- Tag releases using semantic or calendar-based versioning (document your preferred strategy in a future `RELEASE.md`).

## Reporting security issues

If you discover a security vulnerability, please open a private issue or reach out to the repository owner instead of creating a public issue.

## Code of conduct

Please follow a respectful and collaborative tone in issues and PRs. Consider adding a `CODE_OF_CONDUCT.md` if you want a formal policy.

---

If you'd like, I can now:

- Add a `CODE_OF_CONDUCT.md` and a `PULL_REQUEST_TEMPLATE.md`.
- Create a basic GitHub Actions workflow that runs `shellcheck` and `bats` on PRs.
- Add a `bats` test skeleton in `test/`.

Tell me which of those to do next and I'll proceed.
