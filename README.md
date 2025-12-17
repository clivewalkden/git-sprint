# git-sprint
Git sprint system to help support sprint branches for deployments

## Installation

On Linux systems you can install with the following:

### Stable Version
`wget -q https://raw.githubusercontent.com/clivewalkden/git-sprint/development/contrib/gitsprint-installer.sh && sudo bash gitsprint-installer.sh  install stable; rm gitsprint-installer.sh`

or with curl
`curl --silent --location https://raw.githubusercontent.com/clivewalkden/git-sprint/development/contrib/gitsprint-installer.sh --output ./gitsprint-installer.sh`

### Development Version
`wget -q https://raw.githubusercontent.com/clivewalkden/git-sprint/development/contrib/gitsprint-installer.sh && sudo bash gitsprint-installer.sh  install development; rm gitsprint-installer.sh`

### Specific Version
`wget -q https://raw.githubusercontent.com/clivewalkden/git-sprint/development/contrib/gitsprint-installer.sh && sudo bash gitsprint-installer.sh  install version v1.0.0; rm gitsprint-installer.sh`

## Usage

After installing, the primary commands available are:

- `git-sprint-init` : initialize sprint metadata in a repository (creates config files or hooks as needed).
- `git-sprint-create <sprint-name>` : create a sprint branch from the current branch (example: `git-sprint-create sprint/2025-12`).
- `git-sprint-end <sprint-name>` : finish a sprint, optionally merging or deleting the sprint branch.
- `git-sprint-version` : show the installed git-sprint version.
- `git-sprint-config` : print or edit configuration used by git-sprint.

Quick examples:

1. Initialize a repo for sprint management

```
git-sprint-init
```

2. Create a new sprint branch from `main`

```
git checkout main
git pull
git-sprint-create sprint/2025-12
```

3. End a sprint (merge back to `main` and delete the sprint branch)

```
git checkout main
git pull
git-sprint-end sprint/2025-12
```

Options and behavior may vary by installed version; use the individual command help where available (for example `git-sprint-create --help`).

Global flags

- `--help` : show top-level usage and available subcommands.
- `--version` : print the installed `git-sprint` version.
- `--dry-run` : print the git commands and other actions instead of executing them (useful for verification).
- `-v`, `--verbose` : enable verbose/debug output.

Examples with global flags:

```
git sprint --version
git sprint --dry-run create sprint/2025-12
git sprint --verbose create sprint/2025-12
```

## Developer setup

To work on `git-sprint` locally:

1. Clone the repository:

```
git clone https://github.com/clivewalkden/git-sprint.git
cd git-sprint
```

2. Make scripts executable and add to your PATH for local testing:

```
chmod +x git-sprint*
export PATH="$PWD:$PATH"
```

3. Run the commands directly from the repo for quick development and manual testing.

Recommended tooling for contributors:

- Use `shellcheck` to lint scripts.
- Add unit tests with `bats-core` or similar shell testing frameworks.
- Use `pre-commit` hooks to run `shellcheck` and basic validations.

## Suggested improvements (to make this usable across your developers)

- Add CLI `--help` documentation for every command and consistent flags.
- Add automated tests (Bats) and a GitHub Actions workflow to run linting and tests on PRs.
- Provide a stable packaging option: Homebrew formula, Debian package, or container image.
- Offer a simple global installer (the existing `contrib/gitsprint-installer.sh` is a good start; consider adding checksum verification and non-root install mode).
- Add a `CONTRIBUTING.md` and a `CODE_OF_CONDUCT.md` to help new contributors onboard quickly.
- Standardize configuration (single config file location: repo `.gitsprint` or `git config` namespace) and document it.
- Add examples and an opinionated recommended workflow for teams (branch naming, release merging, CI steps).
- Provide a lightweight smoke-test command (e.g., `git-sprint self-test`) to verify installation and common integrations.

## Where to look in the source

Key files and commands live at the repository root (scripts and shared libraries):

- `git-sprint-init`, `git-sprint-create`, `git-sprint-end`, `git-sprint-version`, `git-sprint-config`
- `gitsprint-common`, `gitsprint-shFlags` contain shared helpers
- `contrib/gitsprint-installer.sh` provides an install path used by the README examples

If you want, I can:

- Add a `CONTRIBUTING.md` and a basic GitHub Actions CI config.
- Create a `bats` test skeleton and a `shellcheck` GitHub Action.
- Prepare a Homebrew tap formula for easy install.

Also see the pull request template for suggested PR structure: `.github/PULL_REQUEST_TEMPLATE.md`
