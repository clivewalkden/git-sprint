#!/usr/bin/env bats

setup() {
  PROJECT_ROOT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"
}

@test "version prints git-sprint version" {
  run "$PROJECT_ROOT/git-sprint" --version
  [ "$status" -eq 0 ]
  [[ "$output" == *"0.0.1-dev"* ]]
}
