# RongsokKu Mobile

Aplikasi mobile berbasis Flutter untuk memudahkan penjemputan barang rongsok (barang bekas) dengan menghubungkan warga, pengepul, dan admin dalam satu platform.

## Cara Menjalankan

### Kebutuhan

- Flutter SDK 3.32 atau lebih baru (Dart 3.8+). Cek dengan `flutter --version`.
- Android Studio (untuk Android SDK dan emulator), atau HP Android dengan USB debugging aktif.
- VS Code dengan ekstensi **Flutter** (ekstensi **Dart** ikut terpasang otomatis).

> **Penting:** simpan proyek di folder **tanpa spasi**, misalnya `D:\Project\RongsokKu_Mobile`,
> bukan `D:\test mobile\...`. Di Windows, path berspasi membuat build gagal dengan pesan
> `'D:\...' is not recognized as an internal or external command`.

### 1. Ambil proyek

```bash
git clone https://github.com/andhikaswitch/RongsokKu_Mobile.git
cd RongsokKu_Mobile
flutter pub get
```

Kalau mengunduh lewat **Code → Download ZIP**, ekstrak dulu ke folder tanpa spasi, lalu jalankan
`flutter pub get` di folder hasil ekstrak.

Error merah di editor sebelum `flutter pub get` itu normal. Folder dependency (`.dart_tool/`)
memang tidak disimpan di Git, jadi harus diunduh di tiap komputer.

### 2. Menjalankan di VS Code (terminal)

Cara paling cepat kalau emulator Android sudah terpasang di Android Studio:

1. Buka folder proyek di VS Code: **File → Open Folder** → pilih `RongsokKu_Mobile`.
2. Buka terminal VS Code: **Terminal → New Terminal** (atau ``Ctrl+` ``).
3. Nyalakan emulator, lalu tunggu sampai layar Android-nya muncul:

   ```bash
   flutter emulators                          # lihat nama emulator yang tersedia
   flutter emulators --launch <nama_emulator> --cold
   ```

4. Jalankan aplikasi langsung ke emulator:

   ```bash
   flutter run -d emulator --no-enable-impeller
   ```

Kalau emulator sudah menyala dari awal, cukup jalankan perintah di langkah 4.

- `-d emulator` memaksa aplikasi berjalan di emulator Android. Tanpa opsi ini, Flutter bisa
  memilih **Windows (desktop)**, yang butuh Visual Studio dan bukan target aplikasi ini.
- `--no-enable-impeller` memakai renderer lama yang lebih stabil di emulator. Tanpa opsi ini,
  layar emulator kadang rusak, berkedip, atau hitam.

Saat aplikasi berjalan, tekan `r` di terminal untuk *hot reload*, `R` untuk *hot restart*,
dan `q` untuk berhenti.

### 3. Menjalankan dengan tombol Run (F5)

1. Klik nama perangkat di **status bar kanan bawah** VS Code, lalu pilih emulator Android
   (bukan **Windows (windows-x64)**).
2. Buka `lib/main.dart`, lalu tekan **F5** (atau **Run → Start Debugging**).
3. Simpan file (`Ctrl+S`) untuk *hot reload*.

### 4. Menjalankan di FlutLab

1. Di [flutlab.io](https://flutlab.io), pilih **Upload as a ZIP file** (ZIP dari GitHub) atau **Import from VCS** (URL repo).
2. FlutLab menjalankan `pub get` otomatis.
3. Klik **Build** lalu jalankan di emulator web FlutLab.

### Akun demo

Di layar **Masuk**, ketuk salah satu akun demo untuk langsung masuk sesuai peran:

| Peran    | Email                  |
|----------|------------------------|
| Warga    | siti@warga.test        |
| Pengepul | hijau@pengepul.test    |
| Admin    | admin@rongsokku.test   |

Aplikasi ini masih berupa prototipe UI/UX, jadi semua data hanya contoh dan tidak tersimpan ke database.

### Masalah umum

| Masalah | Solusi |
|---------|--------|
| Ribuan error merah setelah clone/ekstrak | Jalankan `flutter pub get` |
| `'D:\...' is not recognized as an internal or external command` | Pindahkan proyek ke folder tanpa spasi |
| `No supported devices found with name or id matching 'emulator'` | Emulator belum selesai menyala; tunggu layar Android muncul, lalu ulangi `flutter run` |
| Aplikasi malah terbuka di Windows atau minta Visual Studio | Tambahkan `-d emulator` pada `flutter run` |
| Font aplikasi berbeda dari desain | Font Plus Jakarta Sans diunduh saat aplikasi pertama dibuka, jadi emulator/HP perlu internet |
| Build gagal setelah ganti versi Flutter | `flutter clean` lalu `flutter pub get` |

## Deskripsi

RongsokKu membantu warga menjual barang rongsok tanpa harus mencari pengepul sendiri. Warga cukup mengajukan permintaan penjemputan lewat aplikasi, lalu pengepul terdekat dapat memproses dan menjemput barangnya. Admin mengelola data pengguna dan memantau seluruh aktivitas di aplikasi.

## Peran Pengguna

- **Warga**: mengajukan dan memantau permintaan penjemputan rongsok.
- **Pengepul**: menerima dan memproses permintaan penjemputan dari warga.
- **Admin**: mengelola pengguna dan memantau aktivitas aplikasi.

## Fitur Utama

- Landing page, login, dan registrasi
- Dashboard warga
- Ajukan penjemputan rongsok (3 langkah)
- Daftar permintaan saya, detail, dan edit permintaan
- Cari pengepul
- Profil dan edit profil

## Teknologi

- Flutter
- Dart
