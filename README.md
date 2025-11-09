# Absolute Sports

Nama: Fakhri Husaini Romza
NPM: 2406436972
Kelas: B

## Tugas 7

### 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
- Widget tree adalah struktur hirarki yang menggambarkan bagaimana widget disusun satu sama lain di UI. Setiap widget bisa menjadi parent (induk) yang memiliki satu atau lebih child (anak).
- Parent bertanggung jawab meletakkan dan memberi batas perilaku/layout untuk child-nya (misalnya `Column` mengatur anak-anaknya secara vertikal, `Row` horizontal, `Scaffold` menyediakan kerangka layar).
- Perubahan pada parent bisa memengaruhi bagaimana child dirender (ukuran, posisi, tema). Child dapat mewarisi informasi dari parent melalui context (misalnya tema dari `Theme.of(context)`).

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
Berikut widget (dan komponen) yang muncul di `lib/main.dart` dan `lib/menu.dart`:
- `MaterialApp`: Pembungkus aplikasi Material Design, mengelola tema, navigator, lokal, dsb.
- `ThemeData`, `ColorScheme`: Konfigurasi tema warna untuk aplikasi.
- `Scaffold`: Kerangka halaman (app bar, body, snackbar, fab, dsb.).
- `AppBar`: Bilah atas yang berisi judul aplikasi.
- `Text`: Menampilkan teks statis.
- `Row`: Layout horizontal untuk menyusun beberapa anak secara mendatar.
- `Column`: Layout vertikal untuk menyusun anak ke bawah.
- `SizedBox`: Memberi jarak/ukuran kosong di antara widget.
- `Center`: Memusatkan child di dalam parent.
- `Padding`: Memberi ruang di sekeliling child.
- `GridView.count`: Menampilkan daftar item dalam bentuk grid dengan jumlah kolom tetap.
- `Card`: Kartu material dengan elevation (bayangan) sederhana.
- `Container`: Pembungkus serbaguna (padding, ukuran, dekorasi).
- `Material`: Basis efek ink (ripple) dan pewarnaan latar untuk komponen berbasis Material.
- `InkWell`: Memberi efek sentuh (ripple) dan callback `onTap` pada area tertentu.
- `Icon`: Menampilkan ikon bawaan Material.
- `SnackBar`: Komponen pesan singkat yang muncul di bawah layar.
- `ScaffoldMessenger`: Pengelola untuk menampilkan `SnackBar` pada `Scaffold` aktif.
- Custom widgets:
	- `MyApp` (StatelessWidget): Root widget aplikasi.
	- `MyHomePage` (StatelessWidget): Halaman utama berisi info dan menu/grid.
	- `InfoCard` (StatelessWidget): Kartu info NPM/Name/Class.
	- `ItemCard` (StatelessWidget): Tile grid dengan ikon dan teks.

Catatan: `ItemHomepage` adalah model/data holder (bukan widget) yang menyimpan nama, ikon, warna, dan pesan.

### 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
- `MaterialApp` menyetel fondasi aplikasi Material: tema (`ThemeData`), skema warna, font, pengaturan arah teks, navigator/route, lokalisasi, dan integrasi dengan platform.
- Sebagai root, ia memastikan semua descendant bisa mengakses konfigurasi global (misalnya `Theme.of(context)`, `Navigator.of(context)`), sehingga konsisten di seluruh layar.

### 4. Jelaskan perbedaan antara `StatelessWidget`dan `StatefulWidget`. Kapan kamu memilih salah satunya?
- `StatelessWidget`:
	- Tidak menyimpan state internal yang berubah seiring waktu.
	- UI hanya bergantung pada input (constructor) dan data turunan dari context.
	- Pilih ini untuk UI statis atau yang hanya berubah ketika parent memberikan data baru (misal label, ikon, layout sederhana).
- `StatefulWidget`:
	- Memiliki objek `State` yang dapat berubah (via `setState`) dan memicu rebuild parsial.
	- Pilih ini ketika butuh interaksi atau data dinamis: animasi, form input, memuat data async, toggle/checkbox, counter, dsb.

### 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di metode `build`?
- `BuildContext` adalah pegangan (handle) ke lokasi widget di dalam widget tree.
- Penting karena digunakan untuk:
	- Mengakses inherited data seperti tema (`Theme.of(context)`), media query, lokal, dsb.
	- Menemukan ancestor tertentu (mis. `ScaffoldMessenger.of(context)` untuk menampilkan `SnackBar`).
	- Navigasi (`Navigator.of(context)`).
- Di metode `build`, `context` dipakai untuk merangkai UI yang tepat berdasarkan lingkungan sekitar widget (tema, ukuran layar, dsb.).

### 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
- Hot reload:
	- Menyuntikkan perubahan kode ke VM dan melakukan rebuild widget tree dari state saat ini.
	- State yang ada (mis. nilai counter, konten form) dipertahankan.
	- Cepat untuk iterasi UI dan gaya.
- Hot restart:
	- Merestart aplikasi dari awal (menjalankan ulang `main()`), menghapus seluruh state in-memory.
	- Berguna ketika perubahan menyentuh inisialisasi global, struktur state, atau ketika hot reload tidak mencerminkan perubahan yang diinginkan.

---

## Tugas 8: Navigation, Layouts, Forms, and Input Elements

### Navigasi, Drawer, dan Struktur Halaman
- Aplikasi menggunakan `Scaffold`, `AppBar`, `Drawer` untuk konsistensi struktur di tiap halaman.
- Drawer memiliki dua opsi: "Halaman Utama" dan "Tambah Produk". Keduanya menavigasi menggunakan `Navigator` ke halaman yang sesuai.
- Tile grid "Create Product/Tambah Produk" di halaman utama juga mengarahkan ke halaman form.

### Halaman Form Tambah Produk
- Input minimal yang dibuat:
	- `name` (TextFormField, min 3 karakter)
	- `price` (TextFormField angka, > 0)
	- `description` (TextFormField multi-line, min 10 karakter)
- Input tambahan sesuai model Football Shop:
	- `thumbnail` (TextFormField URL, wajib http/https, valid URL)
	- `category` (DropdownButtonFormField; contoh: Jersey, Sepatu, Bola, Aksesoris)
	- `isFeatured` (Switch)
- Tombol `Save` akan memvalidasi form. Jika valid, akan memunculkan pop-up (AlertDialog) berisi ringkasan data yang diisi.

### Jawaban Pertanyaan
1) Perbedaan `Navigator.push()` vs `Navigator.pushReplacement()` dan kapan digunakan?
	 - `push()`: Menambahkan halaman baru di atas stack. Pengguna bisa kembali ke halaman sebelumnya (back).
		 - Cocok saat membuka halaman Form Tambah Produk dari Halaman Utama, karena pengguna mungkin ingin kembali tanpa menyimpan perubahan.
	 - `pushReplacement()`: Mengganti halaman saat ini dengan halaman baru (halaman lama dihapus dari stack).
		 - Cocok untuk alur yang tidak perlu kembali, misalnya setelah proses selesai (sukses submit) dan ingin langsung ke Halaman Utama tanpa kembali ke form lama.

2) Memanfaatkan hierarchy `Scaffold`, `AppBar`, dan `Drawer` untuk struktur konsisten:
	 - `Scaffold` menjadi kerangka tiap halaman: area `appBar`, `body`, dan `drawer` konsisten.
	 - `AppBar` menyajikan judul/aplikasi dan identitas halaman.
	 - `Drawer` menyediakan navigasi global antar-halaman utama (Home dan Tambah Produk) sehingga pengalaman navigasi konsisten.

3) Kelebihan `Padding`, `SingleChildScrollView`, dan `ListView` pada form dan contoh penggunaannya:
	 - `Padding`: Memberi ruang agar form tidak menempel ke tepi layar, meningkatkan keterbacaan.
	 - `SingleChildScrollView`: Mencegah overflow saat keyboard muncul atau layar kecil; form dapat discroll.
	 - `ListView` (atau `Column` di dalam `SingleChildScrollView`): Menyusun elemen secara vertikal dan fleksibel.
	 - Contoh di aplikasi: Halaman `ProductFormPage` menggunakan `SingleChildScrollView` + `Padding` + `Form` dengan beberapa `TextFormField`, `DropdownButtonFormField`, `SwitchListTile`, dan tombol `Save` agar tetap nyaman digunakan di berbagai ukuran layar.

4) Menyesuaikan warna tema agar konsisten dengan brand Football Shop:
	 - Menggunakan `ThemeData` dan `ColorScheme` pada `MaterialApp` untuk menentukan warna utama/sekunder.
	 - Komponen seperti `AppBar`, `DrawerHeader`, dan tombol dapat menggunakan warna konsisten (misal biru sebagai warna utama brand, aksen sesuai kebutuhan) agar identitas visual menyatu.
