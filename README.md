# Finance Dashboard - Pro Version

Aplikasi pencatatan keuangan pribadi dengan fitur lengkap dan dashboard modern.

## Features

### Core Features
- **Dashboard Overview**: Total balance, expense tracking, financial target
- **Multi-Wallet Support**: Kelola beberapa dompet/wallet secara terpisah
- **Transaction Management**: Tambah, edit, dan hapus transaksi
- **Expense Breakdown**: Visualisasi pengeluaran per kategori
- **Budget Tracking**: Pantau budget per kategori dengan alert
- **Bill Reminders**: Tagihan bulanan dengan status lunas/belum

### Advanced Features
- **Dark/Light Theme**: Toggle tema dengan penyimpanan preferensi
- **Filter & Sort**: Filter berdasarkan tipe (income/expense) dan sort by date/amount
- **Recurring Transactions**: Transaksi berulang otomatis setiap bulan
- **PDF Export**: Export laporan keuangan dalam format PDF
- **CSV Export**: Download data transaksi dalam format CSV
- **Activity Log**: Riwayat semua aktivitas pengguna
- **Calendar View**: Lihat transaksi dalam tampilan kalender

## Files Structure

```
finance-tracker/
├── frontend/
│   └── index.html      # Single-file application (HTML + CSS + JS)
├── README.md           # Dokumentasi project
└── CHANGES.md          # Changelog perubahan
```

## Quick Start

1. Buka `frontend/index.html` di browser modern (Chrome/Firefox/Safari/Edge)
2. Data tersimpan di localStorage browser
3. Tidak memerlukan server/backend

## Tech Stack

- **Frontend**: Vanilla HTML5, CSS3, JavaScript (ES6+)
- **Charts**: Chart.js (Line, Doughnut, Pie)
- **PDF Export**: jsPDF + AutoTable plugin
- **Icons**: Font Awesome 6
- **Font**: Inter (Google Fonts)

## Browser Support

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## Data Storage

Semua data disimpan di browser localStorage:
- `transactions` - Data transaksi
- `bills` - Data tagihan
- `activityLog` - Riwayat aktivitas
- `wallets` - Data wallet
- `categoryBudgets` - Budget per kategori
- `targetAmount` - Target tabungan
- `darkMode` - Preferensi tema

## Customization

### Menambah Kategori Baru
Edit object `categoryBudgets` di dalam script:
```javascript
let categoryBudgets = {
    makanan: 500000,
    transportasi: 300000,
    // ... tambahkan kategori baru
};
```

### Mengubah Warna Tema
Edit CSS variables di `:root`:
```css
:root {
    --purple-start: #7c3aed;
    --purple-end: #c026d3;
    /* dst */
}
```

## Future Enhancements

- [ ] Multi-user support dengan login
- [ ] Import data dari CSV/Excel
- [ ] Real-time sync dengan cloud
- [ ] Notifikasi push untuk tagihan
- [ ] Investment tracking
- [ ] Debt management
- [ ] Financial reports (chart.js variations)
- [ ] Mobile app (PWA)

## License

MIT License - Free to use for personal and commercial projects.

## Author

Created by Lucky - Telkom University Student