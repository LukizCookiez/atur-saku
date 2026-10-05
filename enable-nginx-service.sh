#!/bin/sh
# enable-nginx-service.sh — enable nginx sebagai service runit Void
# Jalankan: sudo sh /home/lucky/workspace/atur-saku/enable-nginx-service.sh

set -eu

log(){ echo "[enable] $*"; }

# 1) Cek apakah /service/ ada (Void: /service berisi symlink ke /etc/sv/*)
log "cek /service/"
if [ ! -d /service ]; then
  log "mkdir /service (jika belum ada)"
  mkdir -p /service
fi

# 2) Buat symlink /service/nginx -> /etc/sv/nginx (enable service)
log "symlink /service/nginx -> /etc/sv/nginx"
ln -sfn /etc/sv/nginx /service/nginx

# 3) Buat symlink log juga (agar runit bisa log)
log "symlink /service/nginx-log -> /etc/sv/nginx/log"
ln -sfn /etc/sv/nginx/log /service/nginx-log

# 4) Enable + start via runit
log "sv enable + sv up nginx"
sv up nginx
sleep 1

# 5) Verifikasi
log "verifikasi status"
sv status nginx
echo

log "cek port 8890"
ss -tlnp | grep 8890 || echo "port 8890 belum listen"

log "tes akses lokal"
curl -s -o /dev/null -w "HTTP %{http_code}\n" http://127.0.0.1:8890

log "SELESAI — nginx sekarang service runit (auto-start saat boot)"
