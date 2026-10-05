# name: atur-saku
# desc: serve website AturSaku via nginx (127.0.0.1:8890) untuk Cloudflare Tunnel
# service file runit: /etc/sv/atur-saku/run (atau /service/atur-saku/run)
#
# Persiapan (sekali, root):
#   1. Install nginx (sudah ada di Void: xbps-install -S nginx)
#   2. Jalankan setup:
#        sudo sh /home/lucky/workspace/atur-saku/setup.sh
#      (ini otomatis: webroot -> deploy -> conf nginx -> runit service -> pkill python -> start)
#
# Manual step-by-step (jika setup.sh gagal):
#   sudo mkdir -p /var/www/atur-saku
#   sudo sh /home/lucky/workspace/atur-saku/deploy.sh
#   sudo cp /home/lucky/workspace/atur-saku/nginx-atur-saku.conf /etc/nginx/conf.d/atur-saku.conf
#   sudo mkdir -p /etc/sv/atur-saku
#   sudo cp /home/lucky/workspace/atur-saku/nginx-svc-run /etc/sv/atur-saku/run
#   sudo chmod 755 /etc/sv/atur-saku/run
#   sudo pkill -f "python3.*http.server.*8890"   # kalau masih ada
#   nginx -t
#   sv up atur-saku
#
# Catatan: script `sv up` di workflow GitHub Actions hanya jalan jika nginx
# memang sudah jadi service runit (di atas). Jika tidak, cukup `nginx` sudah
# terinstall sebagai daemon sistem — deploy tetap bisa, hanya tanpa auto-restart.
