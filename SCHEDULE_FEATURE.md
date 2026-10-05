# 📅 Fitur Jadwal Kuliah - Student Dashboard

## ✨ Fitur yang Sudah Ditambahkan (2026-10-05)

### 1. **Tabel Jadwal Rapi dengan Fixed Columns** ✅
- Layout 6 kolom dengan proporsi tetap:
  - **WAKTU** (15%): Icon jam + waktu kuliah
  - **MATA KULIAH** (30%): Nama mata kuliah (bold, kontras)
  - **TIPE** (15%): Badge status Luring/Daring
  - **RUANGAN** (15%): Ruangan kelas atau link online
  - **DOSEN** (10%): Inisial dosen dalam badge
  - **AKSI** (15%): Tombol Edit & Hapus

- Semua kolom lurus sejajar vertikal
- Tidak ada teks terpotong atau melayang

### 2. **Badge Status Metode Pembelajaran** ✅
- **Luring / Tatap Muka**: Badge hijau dengan icon pintu
- **Daring / Online**: Badge ungu dengan icon video
- Auto-detect icon di widget "Kelas Hari Ini"

### 3. **Fitur CRUD (Create, Read, Update, Delete)** ✅

#### **Tambah Jadwal**
- Tombol "+ Tambah Jadwal" di header halaman
- Modal popup dengan form lengkap:
  - Pilih Hari (Senin - Minggu)
  - Waktu Mulai & Selesai (time picker)
  - Nama Mata Kuliah
  - Metode Pembelajaran (Radio: Luring/Daring)
  - Ruangan / Link Kelas
  - Inisial Dosen (auto uppercase, max 5 karakter)

#### **Edit Jadwal**
- Tombol pensil (icon) di setiap baris mata kuliah
- Modal edit dengan data pre-filled
- Bisa pindahkan kelas ke hari lain
- Auto-sort berdasarkan waktu setelah edit

#### **Hapus Jadwal**
- Tombol tempat sampah (icon) di setiap baris
- Konfirmasi sebelum menghapus
- Update real-time setelah dihapus

### 4. **Data Persistence (localStorage)** ✅
- Semua perubahan disimpan ke `localStorage`
- Key: `studentSchedule`
- Data tidak hilang setelah refresh halaman
- Fallback ke data default jika localStorage kosong

### 5. **Layout Full-Width Stack** ✅
- Max-width 1200px, centered
- Setiap hari = 1 card vertikal
- Card hari ini di-highlight dengan border ungu + badge "HARI INI"
- Card libur compact (minimal vertical space)

---

## 🎨 Tema & Style

- Dark mode purple theme konsisten
- Background card: `#16161a`
- Border: `#27272a` (zinc-800)
- Purple accent: `#a855f7`
- Badge luring: Hijau (`#22c55e`)
- Badge daring: Ungu (`#a855f7`)
- Hover effect pada setiap row
- Smooth transitions

---

## 📱 Fitur Tambahan

### Widget "Kelas Hari Ini" (Dashboard)
- Auto-detect hari ini
- Tampilkan semua mata kuliah hari ini
- Highlight kelas yang sedang berlangsung (real-time)
- Icon berbeda untuk Luring/Daring
- Tampilkan "Tidak ada perkuliahan hari ini" jika libur

### Halaman Jadwal Penuh
- Akses via sidebar menu "Jadwal Kuliah"
- View mingguan lengkap (Senin - Minggu)
- Badge jumlah mata kuliah per hari
- Status Libur untuk hari tanpa kelas

---

## 🔧 Struktur Data

```javascript
SCHEDULE = {
    1: { // Senin
        day: 'Senin',
        icon: 'fa-mug-hot',
        classes: [
            {
                id: 's1',
                time_start: '06:30',
                time_end: '08:30',
                mk: 'Pancasila',
                room: 'RKB.KJ.203',
                dosen: 'JOM',
                type: 'luring' // atau 'daring'
            }
        ]
    },
    // ... hari lainnya
}
```

---

## 🚀 Cara Menggunakan

### Akses Dashboard
```bash
# Server sudah running di:
http://192.168.100.27:8890
```

### Tambah Mata Kuliah Baru
1. Klik tombol **"+ Tambah Jadwal"**
2. Isi form:
   - Pilih hari
   - Set waktu mulai & selesai
   - Masukkan nama mata kuliah
   - Pilih metode (Luring/Daring)
   - Isi ruangan atau link Zoom/GMeet
   - Masukkan inisial dosen
3. Klik **"Simpan"**

### Edit Mata Kuliah
1. Klik icon **pensil** di baris mata kuliah yang ingin diedit
2. Modal akan terbuka dengan data pre-filled
3. Ubah data yang diperlukan
4. Klik **"Simpan"**

### Hapus Mata Kuliah
1. Klik icon **tempat sampah** di baris mata kuliah
2. Konfirmasi penghapusan
3. Mata kuliah langsung dihapus

### Reset ke Data Default
```javascript
// Di console browser:
localStorage.removeItem('studentSchedule');
location.reload();
```

---

## 📊 Data Default (Hardcoded)

- **Senin**: 3 Mata Kuliah
  - 06:30-08:30 | Pancasila | RKB.KJ.203 | JOM | Luring
  - 08:30-10:30 | Bahasa Indonesia | RKB.KJ.301 | MOO | Luring
  - 10:30-13:30 | Berpikir Komputasional | RKB.KJ.403 | ZID | Luring

- **Selasa**: Libur / Belajar Mandiri
- **Rabu**: Libur / Belajar Mandiri

- **Kamis**: 1 Mata Kuliah
  - 11:30-14:30 | Kalkulus | RKB.KJ.203 | DIV | Luring

- **Jumat**: 2 Mata Kuliah
  - 06:30-09:30 | Pengantar TI | RKB.KJ.203 | WHI | Luring
  - 09:30-11:30 | Pendidikan Karakter | RKB.KJ.203 | YUI | Luring

- **Sabtu**: Libur Akhir Pekan
- **Minggu**: Libur Akhir Pekan

---

## ✅ Status Implementasi

- ✅ Tabel 6 kolom dengan fixed width proporsional
- ✅ Badge Luring/Daring dengan warna berbeda
- ✅ Icon berbeda untuk Luring (door) dan Daring (video)
- ✅ Modal form Tambah/Edit jadwal
- ✅ Fungsi CRUD lengkap (Create, Read, Update, Delete)
- ✅ Data persistence dengan localStorage
- ✅ Auto-sort berdasarkan waktu
- ✅ Konfirmasi hapus
- ✅ Widget "Kelas Hari Ini" di dashboard
- ✅ Highlight kelas yang sedang berlangsung
- ✅ Layout full-width vertical stack
- ✅ Responsive dan dark mode purple theme

---

## 🎯 Fitur Selanjutnya (Opsional)

- [ ] Export jadwal ke PDF/Image
- [ ] Notifikasi/reminder sebelum kelas dimulai
- [ ] Import jadwal dari file CSV/JSON
- [ ] Filter jadwal berdasarkan dosen/ruangan
- [ ] Statistik kehadiran per mata kuliah
- [ ] Integrasi dengan Google Calendar
- [ ] Recurring schedule (jadwal berulang per semester)

---

**Dibuat**: 2026-10-05  
**Path**: `/home/lucky/workspace/finance-tracker/frontend/index.html`  
**Server**: `http://192.168.100.27:8890`  
**Status**: ✅ Production Ready
