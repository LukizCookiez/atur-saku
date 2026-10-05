# name: atur-saku
# desc: serve website AturSaku via nginx (127.0.0.1:8890) untuk Cloudflare Tunnel
# service file runit: /etc/sv/atur-saku/run (atau /service/atur-saku/run)
#
# Persiapan (sekali, root):
#   xbps-install -S nginx
#   sudo sh -c 'cat > /etc/sv/atur-saku/run <<EOF
# #!/bin/sh
# exec 2>&1
# mkdir -p /var/log/nginx /var/www/atur-saku
# exec nginx -g "daemon off;"
# EOF
# chmod +x /etc/sv/atur-saku/run'
#   sudo cp nginx-atur-saku.conf /etc/nginx/conf.d/atur-saku.conf
#   sudo sh ./deploy.sh      # taruh webroot pertama kali
#   nginx -t
#   sudo sv up atur-saku    # atau: sv enable atur-saku
#
# Catatan: script `sv up` di workflow GitHub Actions hanya jalan jika nginx
# memang sudah jadi service runit (di atas). Jika tidak, cukup `nginx` sudah
# terinstall sebagai daemon sistem — deploy tetap bisa, hanya tanpa auto-restart.
