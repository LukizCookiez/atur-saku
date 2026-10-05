#!/bin/sh
# deploy.sh — tarik kode terbaru dari GitHub lalu siap di-serve nginx.
# Bisa dijalankan oleh root (setup) atau lucky (GitHub Actions).
# Idempotent & aman: kalau gagal, webroot lama tidak disentuh.

set -eu

REPO="/home/lucky/workspace/atur-saku"
WEBROOT="/var/www/atur-saku"
BRANCH="main"

log(){ echo "[$(date '+%H:%M:%S')] $*"; }

cd "$REPO"
log "git fetch origin $BRANCH"
git fetch origin "$BRANCH" 2>&1 | head -5

LOCAL=$(git rev-parse "$BRANCH" 2>/dev/null || echo "none")
REMOTE=$(git rev-parse "origin/$BRANCH")

if [ "$LOCAL" = "$REMOTE" ] || [ "$LOCAL" = "none" ]; then
  log "sudah up-to-date — tidak ada yang perlu di-deploy"
else
  log "update $LOCAL -> $REMOTE"
  git checkout "$BRANCH"
  git reset --hard "origin/$BRANCH"
fi

# Salin hasil build ke webroot (staging dulu)
STAGE="${WEBROOT}.staging-$$"
OLD="${WEBROOT}.old-$$"
rm -rf "$STAGE" "$OLD"
mkdir -p "$STAGE"
cp -a "$REPO/frontend/." "$STAGE/"

if [ -f "$STAGE/index.html" ]; then
  if [ -d "$WEBROOT" ]; then mv "$WEBROOT" "$OLD"; fi
  mv "$STAGE" "$WEBROOT"
  rm -rf "$OLD"
  log "webroot diperbarui ke $WEBROOT"
else
  log "GAGAL: index.html tidak ada di staging — webroot lama tidak disentuh"
  rm -rf "$STAGE"
  exit 1
fi

log "deploy selesai"
