#!/bin/bash
export $(grep -v '^#' .env | xargs)
rsync -av --delete \
  --exclude='.git/' \
  --exclude='.env' \
  --exclude='.github/' \
  --exclude='.env.example' \
  --exclude='.gitignore' \
  --exclude='pull.sh' \
  "$CONTENT_PATH/" .
