# Finance Dashboard - Changelog

## v2.0 - Pro Version (2026-10-03)

### New Features
- **Multi-Wallet Support**: Tambah dan kelola multiple wallets/dompet
- **Edit & Delete Transactions**: Hapus atau edit transaksi yang salah input
- **Filter & Sort**: Filter berdasarkan tipe (income/expense), sort by date/amount
- **Dark/Light Theme Toggle**: Tombol toggle yang berfungsi dengan penyimpanan preferensi
- **Budget Tracking**: Pantau pengeluaran per kategori dengan progress bar
- **Recurring Transactions**: Transaksi berulang otomatis setiap bulan
- **PDF Export**: Export laporan keuangan ke format PDF menggunakan jsPDF
- **CSV Export**: Download data transaksi ke CSV
- **Form Validation**: Validasi input dengan error message
- **Responsive Design**: Optimasi untuk mobile, tablet, dan desktop

### Bug Fixes
- Fixed syntax error di addEventListener untuk bill-modal
- Fixed theme toggle functionality
- Fixed localStorage clearing issue

### UI Improvements
- Tambah wallet selector di dashboard
- Tambah filter buttons di transaction list
- Tambah action buttons (edit/delete) di setiap row transaksi
- Tambah budget progress bars
- Improved responsive breakpoints
- Better error handling dan notifications

## v1.0 - Initial Release (2026-10-03)

### Features
- Dashboard overview dengan 2 top cards (balance & expense)
- Transaction trend chart (line chart)
- Financial target donut chart
- Expense breakdown widget
- Bills & reminders widget
- Calendar view
- Activity log
- Profile view
- Settings page
- Dark mode UI
- LocalStorage persistence