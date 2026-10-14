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

### 2. Menjalankan di VS Code

1. Buka folder proyek: **File → Open Folder** → pilih `RongsokKu_Mobile`.
2. Tunggu VS Code selesai menjalankan `flutter pub get` otomatis (lihat notifikasi kanan bawah).
3. Nyalakan emulator: tekan `Ctrl+Shift+P` → ketik **Flutter: Launch Emulator** → pilih emulator.
   Bisa juga klik nama perangkat di **status bar kanan bawah** lalu pilih emulator.
4. Buka `lib/main.dart`, lalu tekan **F5** (atau **Run → Start Debugging**).
5. Saat aplikasi berjalan, simpan file (`Ctrl+S`) untuk *hot reload*.

### 3. Menjalankan lewat terminal

```bash
flutter emulators                      # lihat daftar emulator
flutter emulators --launch <nama_emulator>
flutter devices                        # pastikan emulator sudah terdeteksi
flutter run
```

Kalau tampilan emulator rusak, berkedip, atau layarnya hitam, jalankan dengan renderer lama:

```bash
flutter run --no-enable-impeller
```

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
| `No supported devices found` | Emulator belum menyala; tunggu sampai muncul di `flutter devices` |
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
