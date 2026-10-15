#!/usr/bin/env bash
# SubagentStop (reviewer): the final message must contain a verdict line.
set -uo pipefail

message=$(jq -r '.last_assistant_message // empty')
if [[ "$message" != *"VERDICT:"* ]]; then
  echo 'End the review with "VERDICT: APPROVE" or "VERDICT: CHANGES".' >&2
  exit 2
fi
exit 0
