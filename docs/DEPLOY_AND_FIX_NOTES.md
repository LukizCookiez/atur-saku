# AturSaku (Finance Tracker) — Panduan Deploy & Catatan Perbaikan

Diperbarui: 2026-10-05

## 1. Arsitektur Aplikasi

```
finance-tracker/
├── frontend/index.html   ← SATU-satunya aplikasi (HTML + CSS + JS inline)
├── backend/             ← KOSONG (tidak dipakai)
├── database/            ← KOSONG (tidak dipakai)
└── docs/
```

**Penting — cara data disimpan:**

- Aplikasi ini **100% client-side**. Tidak ada backend, tidak ada database server.
- Semua data (transaksi, tagihan, wallet, jadwal kuliah, aktivitas, tema, target)
  disimpan di **`localStorage` browser** dengan key-key:
  - `transactions`, `bills`, `activityLog`, `wallets`, `categoryBudgets`
  - `targetAmount`, `studentSchedule`, `darkMode`
- Konsekuensi:
  - Data **tidak sinkron** antar browser/perangkat/tab (incognito).
  - Restart server **tidak** menghapus data (data hidup di browser).
  - `Clear site data` di browser = data hilang.
  - Jika `localStorage` kosong/korup, aplikasi otomatis pakai data default
    (fallback sudah dipastikan aman).

## 2. Cara Deploy / Jalankan

### Prasyarat
- Python 3 (hanya dipakai sebagai static file server)
- Tidak ada build step, tidak ada dependency npm

### Langkah
```bash
cd /home/lucky/workspace/finance-tracker/frontend

# Jalankan server static (bind ke 0.0.0.0 agar bisa diakses dari device lain)
python3 -m http.server 8890 --bind 0.0.0.0
```

Untuk menjalankan permanen di background (tahan saat terminal ditutup),
pakai `nohup`:

```bash
cd /home/lucky/workspace/finance-tracker/frontend
nohup python3 -m http.server 8890 --bind 0.0.0.0 > /tmp/finance-tracker.log 2>&1 &
```

### Akses
- Lokal: `http://localhost:8890`
- Dari jaringan (mis. Windows via MobaXterm): `http://192.168.100.27:8890`

### Verifikasi
```bash
# Cek port terpakai
lsof -i :8890

# Cek HTTP status (harus 200)
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8890

# Cek proses
ps aux | grep "http.server 8890" | grep -v grep

# Hentikan
kill $(lsof -ti :8890)
```

> Catatan: `favicon.ico` akan selalu 404 — normal, tidak ada file favicon.

## 3. Inspeksi Cepat (tanpa browser)

Seluruh JS aplikasi ada di dalam file `index.html`. Validasi sintaks:

```bash
cd /home/lucky/workspace/finance-tracker/frontend
# Ekstrak blok <script> inline lalu cek syntax
python3 - <<'PY'
import re, subprocess
t = open("index.html").read()
s = re.findall(r"<script>([\s\S]*?)</script>", t)[0]
open("/tmp/inline.js","w").write(s)
print("div seimbang:", t.count("<div")==t.count("</div>"))
r = subprocess.run(["node","--check","/tmp/inline.js"], capture_output=True, text=True)
print("JS syntax:", "OK" if r.returncode==0 else "FAIL\n"+r.stderr[:800])
PY
```

## 4. Kronologi & Perbaikan yang Dilakukan (Session 2026-10-05)

### Gejala awal
1. Data "hilang" — saldo kembali ke Rp 0, tabel & jadwal kosong.
2. Hampir semua tombol mati (unresponsive/freeze).
3. Grafik tren transaksi blank tanpa sumbu.

### Akar masalah
- **Bukan data yang dihapus** — data memang hidup di `localStorage` browser;
  server restart tidak menyentuhnya. Data "hilang" terjadi karena akses dari
  browser/tab yang `localStorage`-nya berbeda.
- **Bug mematikan: syntax error JS.** Ada double `});` yang tertinggal di
  `updateTrendChart()` (sekitar baris 3615-3616). Satu `});` berlebih membuat
  **seluruh blok `<script>` gagal di-parse browser** → semua fungsi jadi
  `undefined` → semua `onclick` mati total → UI freeze & grafik blank.
- **Bug handler hilang:** `onclick="addWallet()"` di halaman Settings
  memanggil fungsi yang tidak didefinisikan.

### Perbaikan yang diterapkan
| # | Perbaikan | Lokasi |
|---|-----------|--------|
| 1 | Hapus double `});` di `updateTrendChart()` | `frontend/index.html` (~baris 3615) |
| 2 | Tambahkan `addWallet()` (alias `openWalletModal()`) | di atas `saveWallet()` |
| 3 | Struktur sidebar di-rapikan (div seimbang 225/225) | `<aside class="sidebar">` |
| 4 | Branding: "Finance" → **"AturSaku"**, ikon `F` → `A` | `sidebar-header` |
| 5 | Judul chart "Transaction Trend" → **"Tren Transaksi"** | `chart-title` |
| 6 | `initTrendChart()` dipanggil saat `DOMContentLoaded` supaya grafik bulan default langsung ter-render (bukan blank 0–1) | `INIT` block |
| 7 | Separasi `setPeriod()`: toggle Week/Month **hanya** re-render grafik, tidak menyentuh `renderTransactions()` (perbaikan bug tabel kosong) | `setPeriod()` |
| 8 | Fallback data default dieksplisitkan (`DEFAULT_TRANSACTIONS`, dll.) | `DATA` block |

### Validasi akhir
- `node --check` pada JS inline: **OK** (syntax valid, braces seimbang 345/345).
- Div seimbang 225/225.
- Smoke test (mock DOM) menjalankan seluruh pipeline init tanpa crash.
- Server baru PID 22796, `bind 0.0.0.0:8890`, **HTTP 200** via localhost & IP.

## 5. Saran Ke Depannya
- Data `localStorage` rentan hilang (clear data / ganti perangkat / incognito).
  Disarankan menambah fitur **Export/Import JSON backup** di halaman Settings
  agar progres (saldo, jadwal, dll.) bisa disimpan ke file & dipulihkan.
