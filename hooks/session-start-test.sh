#!/bin/bash
# session-start-test.sh — Tests for the session-start hook
#
# Runs the hook the way Claude Code does and checks what it prints.
# Run: bash hooks/session-start-test.sh

set -euo pipefail

PASS=0 FAIL=0
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

HOOK_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(dirname "$HOOK_DIR")"
HOOK="$HOOK_DIR/session-start.sh"
EVENT='{"hook_event_name":"SessionStart","source":"startup"}'

if ! command -v jq >/dev/null 2>&1; then
  printf '%s\n' "error: jq is required to run these tests" >&2
  exit 1
fi

assert_eq() {
  local label="$1" expected="$2" actual="$3"
  if [ "$expected" = "$actual" ]; then
    PASS=$((PASS + 1))
    printf '  PASS: %s\n' "$label"
  else
    FAIL=$((FAIL + 1))
    printf '  FAIL: %s\n    expected: %s\n    actual:   %s\n' "$label" "$expected" "$actual"
  fi
}

assert_contains() {
  local label="$1" needle="$2" haystack="$3"
  case "$haystack" in
    *"$needle"*)
      PASS=$((PASS + 1))
      printf '  PASS: %s\n' "$label" ;;
    *)
      FAIL=$((FAIL + 1))
      printf '  FAIL: %s\n    missing: %s\n' "$label" "$needle" ;;
  esac
}

# run_hook <hook path> — feeds the SessionStart event on stdin like Claude Code does.
run_hook() {
  printf '%s' "$EVENT" | CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$1"
}

echo "--- with jq: one JSON object in the documented SessionStart shape"
OUT=$(run_hook "$HOOK") && RC=0 || RC=$?
assert_eq "exit code" "0" "$RC"
printf '%s' "$OUT" | jq -e . >/dev/null 2>&1 && PARSES=yes || PARSES=no
assert_eq "stdout parses as JSON" "yes" "$PARSES"
assert_eq "hookEventName" "SessionStart" "$(printf '%s' "$OUT" | jq -r '.hookSpecificOutput.hookEventName')"
CONTEXT=$(printf '%s' "$OUT" | jq -r '.hookSpecificOutput.additionalContext')
assert_contains "context opens with the intro" "agent-protocols loaded." "$CONTEXT"
assert_contains "context carries the meta-skill" "# Using Agent Skills" "$CONTEXT"
assert_eq "output is a single line" "1" "$(printf '%s\n' "$OUT" | wc -l | tr -d ' ')"

echo "--- without jq: plain text, never mistaken for JSON"
# A PATH holding only the commands the hook needs, and no jq.
NOJQ_BIN="$TMPDIR/bin"
mkdir -p "$NOJQ_BIN"
for cmd in bash cat dirname; do
  ln -s "$(command -v "$cmd")" "$NOJQ_BIN/$cmd"
done
OUT=$(PATH="$NOJQ_BIN" run_hook "$HOOK") && RC=0 || RC=$?
assert_eq "exit code" "0" "$RC"
assert_eq "first character is not a brace" "a" "$(printf '%s' "$OUT" | head -c1)"
assert_contains "text opens with the intro" "agent-protocols loaded." "$OUT"
assert_contains "text carries the meta-skill" "# Using Agent Skills" "$OUT"

echo "--- meta-skill missing: a one-line notice, exit 0"
FAKE_ROOT="$TMPDIR/plugin"
mkdir -p "$FAKE_ROOT/hooks"
cp "$HOOK" "$FAKE_ROOT/hooks/session-start.sh"
OUT=$(run_hook "$FAKE_ROOT/hooks/session-start.sh") && RC=0 || RC=$?
assert_eq "exit code" "0" "$RC"
assert_contains "notice names the missing meta-skill" "meta-skill not found" "$OUT"
assert_eq "notice is a single line" "1" "$(printf '%s\n' "$OUT" | wc -l | tr -d ' ')"

printf '\n══════════════════════════════════════════\n'
printf 'Results: %d passed, %d failed\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
