#!/bin/sh
# setup.sh — sekali jalan (butuh root).
# Jalankan:  sudo sh /home/lucky/workspace/atur-saku/setup.sh
#
# Alur: bersihkan injeksi lama (kalau ada) -> webroot -> deploy file -> pasang conf.d/atur-saku.conf
#       -> tambahkan "include conf.d/*.conf;" ke nginx.conf -> validasi -> enable service -> test.

set -eu

log(){ echo "[setup] $*"; }

# 0) Bersihkan injeksi lama (blok atur-saku yang dulu disisipkan langsung ke nginx.conf)
log "bersihkan blok atur-saku lama di nginx.conf (jika ada)"
sed -i '/# >>> AturSaku begin/,/# <<< AturSaku end/d' /etc/nginx/nginx.conf

# 1) webroot
log "mkdir /var/www/atur-saku"
mkdir -p /var/www/atur-saku

# 2) deploy file
log "sh deploy.sh"
sh /home/lucky/workspace/atur-saku/deploy.sh

# 3) Pasang conf.d/atur-saku.conf
log "mkdir -p /etc/nginx/conf.d + cp atur-saku.conf"
mkdir -p /etc/nginx/conf.d
cp /home/lucky/workspace/atur-saku/atur-saku.conf /etc/nginx/conf.d/atur-saku.conf

# Tambahkan include conf.d/*.conf ke dalam block http{} (idempotent)
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

# 5) validasi
log "nginx -t"
nginx -t 2>&1

# 6) Enable service nginx: /etc/sv/nginx -> /service/nginx
log "enable service nginx (symlink /service/nginx)"
ln -sf /etc/sv/nginx /service/nginx 2>/dev/null || true
ln -sf /etc/sv/nginx/log /service/nginx-log 2>/dev/null || true

log "sv up nginx"
sv up nginx 2>&1 || sv status nginx 2>&1 || echo "GAGAL: service belum bisa di-start"
sleep 1

# 7) test
log "cek port 8890"
curl -s -o /dev/null -w "HTTP %{http_code}\n" http://127.0.0.1:8890
log "SELESAI"
