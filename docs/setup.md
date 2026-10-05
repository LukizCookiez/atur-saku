# Finance Tracker - Setup Guide

## Prerequisites
- Modern web browser (Chrome, Firefox, Safari, Edge)
- No server required - works as static HTML file

## Installation

### Option 1: Direct Usage (Recommended)
1. Clone atau download repository
2. Buka `frontend/index.html` di browser
3. Selesai!

### Option 2: Local Server
```bash
# Using Python
cd frontend
python3 -m http.server 8080

# Using Node.js
npx serve frontend
```
Lalu buka http://localhost:8080

## Data Management

### Export Data
- Dashboard → Click menu Document
- Pilih CSV atau PDF export
- File akan diunduh otomatis

### Import Data
- Manual: Tambah transaksi satu per satu
- Bulk import coming soon

### Backup
Data tersimpan di browser localStorage. Untuk backup:
1. Export data secara berkala (CSV)
2. Simpan file backup di cloud storage

## Troubleshooting

### Data hilang setelah clear cache
- Restore dari file CSV backup
- Atau tambahkan transaksi baru

### Chart tidak muncul
- Pastikan koneksi internet untuk CDN resources
- Atau download library dan simpan lokal

### Theme tidak berubah
- Clear localStorage browser
- Reload halaman

## Support
- Issues: Create GitHub issue
- Feature requests: Open discussion

## License
MIT