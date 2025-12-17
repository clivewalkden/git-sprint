#!/usr/bin/env bats

setup() {
  PROJECT_ROOT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"
}

@test "top-level help prints usage" {
  run "$PROJECT_ROOT/git-sprint" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"Available subcommands are:"* ]]
}
