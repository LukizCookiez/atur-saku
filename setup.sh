#!/bin/sh
# setup.sh — sekali jalan (butuh root).
# Jalankan:  sudo sh /home/lucky/workspace/atur-saku/setup.sh
#
# Alur: bersihkan injeksi lama -> webroot -> deploy -> conf.d -> include -> validasi -> start -> test.

set -eu

log(){ echo "[setup] $*"; }

# 0) Bersihkan injeksi lama
log "bersihkan blok atur-saku lama di nginx.conf (jika ada)"
sed -i '/# >>> AturSaku begin/,/# <<< AturSaku end/d' /etc/nginx/nginx.conf

# 1) webroot
log "mkdir /var/www/atur-saku"
mkdir -p /var/www/atur-saku

# 2) deploy file
log "sh deploy.sh"
sh /home/lucky/workspace/atur-saku/deploy.sh

# 3) conf.d
log "mkdir -p /etc/nginx/conf.d + cp atur-saku.conf"
mkdir -p /etc/nginx/conf.d
cp /home/lucky/workspace/atur-saku/atur-saku.conf /etc/nginx/conf.d/atur-saku.conf

# Tambahkan include conf.d/*.conf ke http{} (idempotent)
log "pastikan include conf.d/*.conf ada di nginx.conf"
if ! grep -q "include[[:space:]]*conf.d/\*.conf;" /etc/nginx/nginx.conf; then
  python3 - <<'PYEOF'
path = "/etc/nginx/nginx.conf"
with open(path) as f:
    c = f.read()
line = '    include       conf.d/*.conf;\n'
anchor = '    default_type  application/octet-stream;\n'
if line not in c:
    c = c.replace(anchor, anchor + line, 1)
with open(path, "w") as f:
    f.write(c)
print("include conf.d/*.conf ditambahkan")
PYEOF
else
  log "include conf.d sudah ada, lewati"
fi

# 4) Matikan python http.server lama (fallback)
log "hentikan python http.server di port 8890 (jika ada)"
pkill -f "python3.*http.server.*8890" 2>/dev/null || true
sleep 1

# 5) Hentikan nginx lama (jika jalan) lalu start ulang
log "hentikan nginx lama (jika ada) lalu start ulang"
# Cari nginx master & kill
pkill -x nginx 2>/dev/null || true
sleep 1

# Jalankan nginx sebagai daemon (mode Void standard)
log "start nginx"
nginx 2>&1 || {
  log "GAGAL start nginx — cek log: tail /var/log/nginx/error.log"
  exit 1
}
sleep 1

# 6) test
log "cek port 8890"
curl -s -o /dev/null -w "HTTP %{http_code}\n" http://127.0.0.1:8890
log "SELESAI"
