#!/bin/bash

# Check if tailscale is connected
if tailscale status --json | jq '.Self.Online' | grep -q 'true'; then
    echo "󰌆 "
else
    echo ""
fi
