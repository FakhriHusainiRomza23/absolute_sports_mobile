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

	---

	### Tutorial 8: Step-by-step (ringkas)
	- Tambah dependency: `provider`, `pbp_django_auth`, `http` lalu `flutter pub get`.
	- Bungkus `MaterialApp` dengan `Provider<CookieRequest>` di `main.dart`, set `home: LoginPage()`.
	- Login (`lib/screens/login.dart`):
		- Input username/password, tentukan `base` platform-aware (Web: `http://localhost:8000`, Android: `http://10.0.2.2:8000`).
		- Panggil `request.login("$base/auth/login/", {...})`. Jika sukses, `Navigator.pushReplacement` ke Home + tampilkan Snackbar.
	- Register (`lib/screens/register.dart`):
		- Input username/password1/password2, POST JSON ke `"$base/auth/register/"` via `request.postJson`.
		- Tampilkan Snackbar hasil dan arahkan ke Login.
	- Drawer (`lib/widgets/app_drawer.dart`):
		- Navigasi ke Home, Tambah Item, Daftar Item. Tambahkan tombol Logout: `request.logout("$base/auth/logout/")` lalu kembali ke Login.
	- Model Dart (`lib/models/product_entry.dart`):
		- Definisikan field dan `fromJson/toJson` sesuai response backend.
	- Daftar item (`lib/screens/product_entry_list.dart`):
		- Ambil data via `request.get("$base/json/")`, map ke `ProductEntry`, render dengan `ListView.builder` + card.
	- Kartu item (`lib/widgets/product_entry_card.dart`):
		- Tampilkan `thumbnail` (opsional), `name`, `price`, `category`, preview `description`.
	- Detail item (`lib/screens/product_detail.dart`):
		- Tampilkan detail lengkap, tombol kembali, dan gambar via proxy bila dipakai.
	- Form tambah item (`lib/screens/product_form_page.dart`):
		- Validasi input, lalu `request.postJson("$base/create-flutter/", payload)`.
		- Tampilkan Snackbar hasil; sukses → arahkan ke Home/List.

	## Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter

	### Checklist yang Diimplementasikan
	- Deploy backend Django (lokal dan siap untuk deployment); endpoint `auth/`, `json/`, `create-flutter/`, dan `proxy-image/` tersedia.
	- Registrasi & login di Flutter menggunakan `pbp_django_auth` (`CookieRequest`) dengan Provider sebagai state global.
	- Model Dart kustom: `ProductEntry` (id, name, price, description, category, thumbnail, product_views, is_featured, is_hot, user_id).
	- Halaman daftar item (`ProductEntryListPage`) menampilkan: thumbnail, name, price, description (preview), category, dan indikator featured.
	- Halaman detail item (`ProductDetailPage`) menampilkan seluruh atribut model dan tombol kembali.
	- Filter daftar item agar hanya menampilkan item milik user yang login (berdasarkan `user_id` jika tersedia dari sesi login).

	### Jawaban Pertanyaan
	1) Mengapa perlu membuat model Dart saat mengambil/mengirim data JSON? Konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model?
		- Model Dart memberi kontrak tipe yang eksplisit (strongly-typed) sehingga validasi tipe, null-safety, dan evolusi skema data lebih terkontrol. Tanpa model, raw map rentan salah ketik key, cast runtime error, dan sulit dirawat ketika API berubah (kurang maintainable dan rawan bug).

	2) Fungsi package `http` dan `CookieRequest` dalam tugas ini? Bedanya?
		- `http`: Klien HTTP generik (GET/POST, tanpa state sesi). Cocok untuk akses publik atau satu-kali request.
		- `CookieRequest` (pbp_django_auth): Klien HTTP yang mengelola sesi/cookie Django otomatis (CSRF, sessionid). Cocok untuk autentikasi, request berkelanjutan yang membutuhkan kredensial.

	3) Mengapa instance `CookieRequest` perlu dibagikan ke seluruh komponen?
		- Agar seluruh layar memakai sesi/kuki yang sama (single source of truth). Menghindari re-login atau kehilangan status saat berpindah halaman. Dengan Provider, perubahan status login dapat memicu UI update konsisten.

	4) Konfigurasi konektivitas agar Flutter dapat berkomunikasi dengan Django dan dampak bila salah konfigurasi:
		- Tambahkan `10.0.2.2` pada `ALLOWED_HOSTS` (Android emulator mengakses host mesin via 10.0.2.2). Tanpa ini, request ditolak oleh Django (Bad Request/DisallowedHost).
		- Aktifkan CORS dan setelan cookie (SameSite=None; Secure untuk web bila pakai HTTPS) agar browser boleh mengirim/terima kredensial lintas-origin. Tanpa CORS benar, request akan diblokir browser.
		- Tambahkan izin internet di Android (`android:usesCleartextTraffic` jika HTTP) agar aplikasi boleh mengakses jaringan. Tanpa izin, request gagal (network error).

	5) Mekanisme pengiriman data dari input hingga tampil di Flutter:
		- Input di form Flutter -> validasi -> serialize (JSON) -> kirim via `CookieRequest.postJson` -> Django view memproses & menyimpan -> balas JSON -> Flutter decode ke model (`ProductEntry.fromJson`) -> render UI (list/detail).

	6) Mekanisme autentikasi (login, register, logout):
		- Register: Flutter kirim data ke endpoint Django, backend membuat user dan membalas status.
		- Login: Flutter kirim kredensial ke `/auth/login/` via `CookieRequest.login`, Django memverifikasi dan mengembalikan cookie sesi. `CookieRequest` menyimpan cookie untuk request berikutnya.
		- Akses terotentikasi: Request berikutnya otomatis menyertakan cookie (session/CSRF) sehingga backend mengenali user.
		- Logout: Flutter memanggil endpoint logout, backend menghapus sesi; `CookieRequest` mengosongkan cookie; UI kembali ke layar login.

	7) Implementasi step-by-step (singkat):
		- Tambah Provider `CookieRequest` di `main.dart` dan jadikan halaman login sebagai entry point.
		- Implement register & login memakai endpoint Django (platform-aware base URL: Web `localhost:8000`, Android `10.0.2.2:8000`).
		- Buat model Dart (`ProductEntry`) beserta `fromJson/toJson`.
		- Bangun halaman daftar item: fetch `${base}/json/` via `CookieRequest.get`, mapping ke `ProductEntry`, tampilkan name, price, description, thumbnail, category, `is_featured`.
		- Tambah halaman detail: tampilkan seluruh atribut model + tombol kembali.
		- Form tambah item: kirim data ke `${base}/create-flutter/` via `postJson`, tangani error (misal HTML response) dan tampilkan Snackbar.
		- Filter daftar item berdasarkan `user_id` yang login (jika tersedia pada sesi/response login).
		- Uji pada Web dan Android emulator; pastikan konfigurasi CORS/ALLOWED_HOSTS/cookie sesuai.

	### Implementasi step-by-step (detail)
	1) Siapkan backend Django (endpoint & konfigurasi)
		- Endpoint wajib tersedia dan mengembalikan JSON:
		  - `/auth/login/`, `/auth/logout/`, `/auth/register/` (gunakan view auth yang mengembalikan JSON)
		  - `/json/` untuk daftar item (sertakan field: `id, name, price, description, category, thumbnail, product_views, is_featured, is_hot, user_id`)
		  - `/create-flutter/` untuk menerima POST JSON dan membuat item baru (status 201 + JsonResponse)
		  - Opsional: `/proxy-image/` untuk memuat gambar eksternal dan menghindari CORS (balikkan bytes + header `Content-Type`)
		- `ALLOWED_HOSTS` di `settings.py` mencakup: `"localhost"`, `"127.0.0.1"`, `"10.0.2.2"`, serta domain deployment.
		- Aktifkan CORS & CSRF sesuai target:
		  - Pasang `django-cors-headers`, tambahkan ke `INSTALLED_APPS` dan `MIDDLEWARE`.
		  - Set minimal untuk pengujian lokal (sesuaikan dengan kebijakan tim/prod):
			 - `CORS_ALLOW_CREDENTIALS = True`
			 - `CORS_ALLOWED_ORIGINS = ["http://localhost:xxxxx", ...]` (isi port asal Flutter web jika perlu)
			 - `CSRF_TRUSTED_ORIGINS = ["http://localhost:xxxxx", ...]`
		  - Untuk web via HTTPS: cookie perlu `SameSite=None; Secure`.
		- Android: izinkan cleartext (untuk HTTP lokal) dan internet permission.
		  - Tambahkan `<uses-permission android:name="android.permission.INTERNET" />` di `android/app/src/main/AndroidManifest.xml`.
		  - Untuk debug HTTP, atur `android:usesCleartextTraffic="true"` di `application` (opsional/dev only).

	2) Pastikan dependency Flutter
		- `pubspec.yaml` memuat: `pbp_django_auth`, `provider`, `http`.
		- Jalankan:
	```powershell
	flutter pub get
	```

	3) Konfigurasi Provider `CookieRequest` di Flutter
		- Di `main.dart`, buat instance `CookieRequest` dan bagikan via `Provider` di atas `MaterialApp`.
		- Set entry ke halaman Login.

	4) Implementasi LoginPage (`lib/screens/login.dart`)
		- Buat controller untuk username & password.
		- Tentukan `base` platform-aware:
		  - Web/desktop: `http://localhost:8000`
		  - Android emulator: `http://10.0.2.2:8000`
		- Panggil `request.login("$base/auth/login/", { username, password })`.
		- Jika sukses: `Navigator.pushReplacement` ke `MyHomePage` + tampilkan Snackbar.
		- Jika gagal: tampilkan `AlertDialog` dengan pesan dari server.

	5) Implementasi RegisterPage (`lib/screens/register.dart`)
		- Struktur mirip login, kirim ke endpoint register (POST) menggunakan `CookieRequest`.
		- Validasi sederhana: password match, tidak kosong; tampilkan feedback via Snackbar.
		- Navigasi ke Login setelah berhasil.

	6) Drawer dan menu
		- `lib/widgets/app_drawer.dart` berisi navigasi ke: `MyHomePage`, `ProductFormPage`, `ProductEntryListPage`.
		- Tombol Logout: `request.logout("$base/auth/logout/")` lalu arahkan ke Login.

	7) Model Dart
		- `lib/models/product_entry.dart` mendefinisikan `ProductEntry` dan mapping `fromJson/toJson` sesuai nama field backend.

	8) Halaman daftar item (`lib/screens/product_entry_list.dart`)
		- `Future<List<ProductEntry>> fetchProduct(CookieRequest request)` memanggil `${base}/json/` via `request.get`.
		- Mapping ke list `ProductEntry` menggunakan `fromJson`.
		- Filter berdasarkan user yang login bila `request.jsonData['id']` tersedia: tampilkan hanya item dengan `user_id` sesuai.
		- Gunakan `ListView.builder` + `ProductEntryCard` untuk render.

	9) Kartu item (`lib/widgets/product_entry_card.dart`)
		- Tampilkan `thumbnail` via `${base}/proxy-image/?url=...` (dengan `errorBuilder` fallback).
		- Tampilkan `name`, `price`, `category`, preview `description`, dan label `Featured` bila `is_featured == true`.

	10) Halaman detail (`lib/screens/product_detail.dart`)
		- Tampilkan seluruh atribut: `id, name, price, description, category, thumbnail (opsional), product_views, is_featured, is_hot, user_id`.
		- Tambahkan tombol "Back to list" (`Navigator.pop`).
		- Pastikan URL proxy image platform-aware seperti pada kartu.

	11) Halaman form tambah item (`lib/screens/product_form_page.dart`)
		- Validasi input: `name` minimal 3, `price` > 0, `description` minimal 10, URL `thumbnail` jika diisi, `category` dipilih.
		- POST JSON ke `${base}/create-flutter/` memakai `request.postJson` dengan payload:
		  - `name`, `price`, `description`, `thumbnail`, `category`, `is_featured`.
		- Tangani `FormatException` untuk kasus backend mengirim HTML (mis. redirect atau error template) dan tampilkan Snackbar yang menjelaskan.
		- Pada sukses: tampilkan Snackbar "Product successfully saved!" dan `pushReplacement` ke Home atau List.

	