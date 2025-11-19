# Absolute Sports
Nama: Fakhri Husaini Romza  
NPM: 2406436972  
Kelas: B

## Tugas 7

### 1) Widget tree dan relasi parent–child
- Widget tree: struktur hierarki UI di Flutter (root → cabang → daun).
- Parent mengatur layout/kontraint anak (contoh: Column vertikal, Row horizontal, Scaffold kerangka halaman).
- Child mewarisi informasi via context (tema, ukuran layar, media query).
- Perubahan parent memengaruhi render child (ukuran, posisi, tema).

### 2) Widget yang digunakan dan fungsinya
- MaterialApp: root aplikasi Material (tema, navigator, lokal).
- ThemeData, ColorScheme: konfigurasi warna/tema.
- Scaffold: kerangka halaman (app bar, body, drawer, snackbar, fab).
- AppBar: bilah atas dengan judul.
- Text: teks statis.
- Row/Column: layout horizontal/vertikal.
- SizedBox: jarak/ruang kosong.
- Center: memusatkan child.
- Padding: ruang di sekeliling child.
- GridView.count: grid dengan jumlah kolom tetap.
- Card: kartu material dengan bayangan.
- Container: pembungkus serbaguna (padding, ukuran, dekorasi).
- Material: basis efek ink/ripple.
- InkWell: efek sentuh dan onTap.
- Icon: ikon material.
- SnackBar: pesan singkat di bawah.
- ScaffoldMessenger: penampil SnackBar pada Scaffold aktif.
- Custom:
	- MyApp (StatelessWidget): root aplikasi.
	- MyHomePage (StatelessWidget): halaman utama (info + grid).
	- InfoCard (StatelessWidget): kartu info profil.
	- ItemCard (StatelessWidget): tile grid dengan ikon/teks.
- Catatan: ItemHomepage adalah model data (bukan widget).

### 3) Fungsi MaterialApp dan alasan sebagai root
- Menyediakan tema, navigasi/route, lokal, arah teks, dan integrasi platform.
- Memudahkan akses global descendant (Theme.of, Navigator.of) untuk konsistensi lintas halaman.

### 4) StatelessWidget vs StatefulWidget
- StatelessWidget: tanpa state yang berubah; UI bergantung pada input/context. Pilih untuk UI statis.
- StatefulWidget: memiliki State yang dapat berubah (setState); pilih untuk interaksi/data dinamis (form, animasi, async).

### 5) BuildContext: definisi dan penggunaan
- BuildContext: referensi posisi widget di tree.
- Digunakan untuk: akses inherited data (Theme, MediaQuery), mencari ancestor (ScaffoldMessenger), navigasi (Navigator).
- Di build, context membantu merakit UI sesuai lingkungan (tema, ukuran, lokal).

### 6) Hot reload vs hot restart
- Hot reload: menyuntikkan perubahan, rebuild dari state saat ini; state dipertahankan.
- Hot restart: menjalankan ulang main(), menghapus seluruh state; untuk perubahan inisialisasi/global.

---

## Tugas 8: Navigation, Layouts, Forms, and Input Elements

### Jawaban pertanyaan
1) Navigator.push vs pushReplacement  
- push: menambah halaman di atas stack; bisa kembali. Cocok dari Home ke Form.  
- pushReplacement: mengganti halaman saat ini; tidak bisa kembali. Cocok setelah submit sukses menuju Home.

2) Hierarki Scaffold, AppBar, Drawer  
- Scaffold: kerangka konsisten (appBar, body, drawer).  
- AppBar: identitas halaman.  
- Drawer: navigasi global antar halaman utama.

3) Padding, SingleChildScrollView, ListView pada form  
- Padding: ruang tepi, lebih nyaman dibaca.  
- SingleChildScrollView: cegah overflow, bisa scroll saat keyboard muncul.  
- ListView/Column dalam scroll: susun elemen vertikal fleksibel.  
- Implementasi: ProductFormPage memakai kombinasi tersebut + Form dan validator.

4) Tema konsisten brand  
- Atur ThemeData/ColorScheme pada MaterialApp untuk warna utama/sekunder.



## Tugas 9

### Mengapa perlu model Dart untuk JSON?
- Validasi tipe: field bertipe kuat (int/String/bool) → error terdeteksi lebih awal.
- Null-safety: nullable/non-nullable memaksa penanganan eksplisit.
- Maintainability: parsing terpusat (fromJson/toJson), refactor aman, autocompletion IDE.
- Risiko Map<String, dynamic> mentah: raw key rentan typo, parsing berulang, bug runtime.

### Peran package http vs CookieRequest
- http: klien low-level (GET/POST) tanpa sesi/cookie; cocok endpoint publik.
- CookieRequest (pbp_django_auth): kelola session cookie, CSRF, helper login/logout/postJson, menyimpan jsonData user; untuk endpoint terotentikasi Django.
- Di proyek: login/register/CRUD → CookieRequest; akses publik sederhana → http.

### Mengapa CookieRequest dibagikan ke seluruh komponen?
- Satu sumber kebenaran sesi: cookie/CSRF konsisten di semua request.
- Akses via Provider, tanpa prop drilling.
- Hindari multi-sesi/ketidaksinkronan (logout di satu tempat tercermin di seluruh aplikasi).

### Konfigurasi konektivitas Flutter ↔ Django
- ALLOWED_HOSTS: tambahkan 10.0.2.2 (Android emulator → host). Tanpa ini, Django menolak Host header.
- CORS + CSRF/SameSite: izinkan origin Flutter (web/dev server), set CSRF Trusted Origins; salah konfigurasi → 403 CSRF/cookie diblokir.
- Android permission internet: tambahkan android.permission.INTERNET; tanpa izin, request gagal (network error).

### Alur data: input → tampil di Flutter
- Flutter Form → validasi → request.postJson ke Django.
- Django view validasi & simpan model → balikan JSON.
- Flutter menerima JSON → parse ProductEntry.fromJson.
- UI pakai FutureBuilder/ListView.builder untuk render daftar → tap ke ProductDetailPage.

### Mekanisme autentikasi (login, register, logout)
- Register: kirim username/password1/password2 → Django buat user → Snackbar → kembali ke Login.
- Login: request.login → Django set session cookie/CSRF → CookieRequest simpan cookie + jsonData → navigasi ke Home.
- Authenticated requests: CookieRequest lampirkan cookie & CSRF otomatis.
- Logout: request.logout → session invalid → kembali ke LoginPage.

### Implementasi checklist (step-by-step)
- Setup Provider di main.dart untuk CookieRequest global.
- Bangun LoginPage & RegisterPage (form + validator + panggil endpoint).
- Definisikan model ProductEntry (+ owner info) untuk parsing.
- Buat ProductEntryListPage (fetch via CookieRequest.get, render dengan ListView.builder).
- ProductEntryCard: tampilkan informasi utama + badge.
- ProductDetailPage: tampilkan detail lengkap.
- Tambah menu Logout (request.logout → kembali ke Login).
- Tambah “My Products” (filter berdasarkan user_username/user_id).
- Atur ThemeData/ColorScheme konsisten dengan brand.
- Konfigurasi Django (ALLOWED_HOSTS 10.0.2.2, CORS/CSRF) dan izin internet Android.

