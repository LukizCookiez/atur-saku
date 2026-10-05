#!/bin/sh
# setup.sh — sekali jalan (butuh root).
# Jalankan:  sudo sh /home/lucky/workspace/atur-saku/setup.sh
#
# Isi: bikin webroot -> deploy file -> pasang conf nginx -> service runit -> validasi.

set -eu

log(){ echo "[setup] $*"; }

# 1) webroot
log "mkdir /var/www/atur-saku"
mkdir -p /var/www/atur-saku

# 2) deploy file
log "sh deploy.sh"
sh /home/lucky/workspace/atur-saku/deploy.sh

# 3) conf nginx
log "cp conf nginx"
cp /home/lucky/workspace/atur-saku/nginx-atur-saku.conf /etc/nginx/conf.d/atur-saku.conf

# 4) service runit
log "mkdir /etc/sv/atur-saku"
mkdir -p /etc/sv/atur-saku
cp /home/lucky/workspace/atur-saku/nginx-svc-run /etc/sv/atur-saku/run
chmod 755 /etc/sv/atur-saku/run

# 5) validasi & start
log "nginx -t"
nginx -t 2>&1
log "sv up atur-saku"
sv up atur-saku 2>/dev/null || sv status atur-saku 2>/dev/null || echo "(sv belum tersedia — jalankan nginx langsung)"

# 6) test
sleep 1
log "cek port 8890"
curl -s -o /dev/null -w "HTTP %{http_code}\n" http://127.0.0.1:8890
log "SELESAI"
