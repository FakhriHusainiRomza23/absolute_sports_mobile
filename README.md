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
	- Tambah dependency: `provider`, `pbp_django_auth`, `http` lalu jalankan `flutter pub get`.
	- Bungkus `MaterialApp` dengan `Provider<CookieRequest>` di `main.dart`, set `home: LoginPage()` supaya sesi login terbagi.
	- Login (`lib/screens/login.dart`):
		- Input username/password, panggil `request.login(buildEndpoint('/auth/login/'), {...})` yang otomatis memilih host (web vs Android emulator).
		- Jika sukses, arahkan ke halaman utama memakai `Navigator.pushReplacement` dan tampilkan Snackbar sapaan.
	- Register (`lib/screens/register.dart`):
		- Input username/password1/password2, kirim ke `buildEndpoint('/auth/register/')` lewat `request.postJson`.
		- Tampilkan Snackbar status dan arahkan kembali ke Login saat sukses.
	- Drawer (`lib/widgets/left_drawer.dart`):
		- Menyediakan akses cepat ke Home, daftar produk umum, serta form tambah produk.
	- Model Dart (`lib/models/product_entry.dart`):
		- Memetakan field JSON backend ke tipe Dart lengkap dengan `fromJson/toJson`.
	- Daftar item (`lib/screens/product_entry_list.dart`):
		- Mengambil data via `request.get(buildEndpoint('/json/'))`, mengubahnya ke `ProductEntry`, lalu menampilkan dengan `ListView.builder`.
	- Kartu item (`lib/widgets/product_entry_card.dart`):
		- Menampilkan thumbnail (melalui proxy), nama, harga, kategori, cuplikan deskripsi, dan badge featured/hot.
	- Detail item (`lib/screens/product_detail.dart`):
		- Menunjukkan foto, kategori, harga, views, flag featured/hot, owner id, serta deskripsi penuh.
	- Form tambah item (`lib/screens/product_form_page.dart`):
		- Validasi input, tampilkan dialog preview, kemudian kirim data ke `buildEndpoint('/create-flutter/')` memakai `request.postJson`.
		- Beri Snackbar hasil dan kembali ke halaman utama setelah submit.

	## Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter

	Tugas 9: Integrasi Layanan Web Django dengan Aplikasi FlutterDokumen ini menjelaskan mekanisme integrasi antara backend Django dan frontend Flutter pada aplikasi Football Shop, mencakup alasan penggunaan model data, manajemen state sesi, konfigurasi jaringan, serta alur autentikasi.📚 Analisis Teknis & Konsep1. Pentingnya Model Dart vs Map<String, dynamic>Mengapa kita perlu membuat model khusus saat mengolah data JSON dibandingkan menggunakan Map mentah?AspekMenggunakan Model DartMenggunakan Map<String, dynamic>Validasi TipeKuat (Strong Typing). Kesalahan tipe (misal: int diisi String) terdeteksi saat compile-time.Lemah. Kesalahan tipe baru diketahui saat aplikasi berjalan (runtime error).Null SafetyEksplisit. Field dapat ditandai nullable (?) atau wajib diisi, memaksa kita menangani nilai null.Implisit. Risiko tinggi terkena null pointer exception jika data API tidak lengkap.MaintainabilityTinggi. Parsing terpusat di fromJson/toJson. Refactoring nama variabel mudah & aman.Rendah. Rawan typo pada key string (misal: 'price' vs 'prce'). Logika parsing berulang di banyak tempat.IDE SupportAutocompletion aktif. Memudahkan coding.Tidak ada saran properti otomatis.2. Mekanisme Pengiriman Data (Http vs CookieRequest)Dalam tugas ini, kita menggunakan package pbp_django_auth yang menyediakan CookieRequest.http (Standard Package):Client low-level untuk request GET/POST.Tidak menyimpan sesi/cookie secara otomatis antar request.Penggunaan: Cocok untuk API publik yang tidak butuh login/CSRF token.CookieRequest (pbp_django_auth):Wrapper di atas http yang dirancang khusus untuk integrasi Django.Fitur Utama: Mengelola session cookies, menyertakan CSRF token otomatis, dan menyimpan data user lokal.Penggunaan: Wajib untuk endpoint terproteksi (Login, Logout, CRUD data user).Mengapa CookieRequest perlu dibagikan ke semua komponen?Instance ini harus menjadi Single Source of Truth. Dengan membagikannya melalui Provider di root aplikasi, kita memastikan:Semua widget menggunakan sesi/cookie yang sama (konsistensi login).Menghindari masalah multi-session (misal: sudah logout di satu halaman, tapi halaman lain masih menganggap login).Kemudahan akses tanpa perlu mengoper variabel manual ke setiap widget.3. Konfigurasi Konektivitas (Flutter ↔ Django)Agar Android Emulator dapat berkomunikasi dengan server Django lokal, konfigurasi berikut sangat krusial:ALLOWED_HOSTS = ['10.0.2.2', ...]Alasan: 10.0.2.2 adalah alias khusus pada emulator Android yang mengarah ke localhost komputer host. Tanpa ini, Django akan menolak header Host yang dikirim emulator.CORS & CSRF/SameSiteAlasan: Browser/Client mobile dianggap sebagai origin berbeda. Kita harus mengizinkan origin Flutter dan mengatur kebijakan cookie agar sesi bisa disimpan.Resiko: Jika salah, akan muncul error 403 Forbidden (CSRF Failed) atau cookie sesi tidak tersimpan.android.permission.INTERNETAlasan: Android secara default memblokir akses internet aplikasi demi keamanan.Resiko: Jika lupa, aplikasi akan langsung crash atau melempar SocketException saat mencoba request.🔄 Alur Data & Autentikasi1. Alur Autentikasi (Login, Register, Logout)Register:User input data → Kirim POST ke /auth/register/.Django membuat User baru (validasi password).Flutter menerima respon sukses → Navigasi ke Login Page.Login:User input kredensial → request.login().Django memvalidasi & membuat sesi (mengirim cookie sessionid & csrftoken).CookieRequest menyimpan cookie tersebut + data user (username).Navigasi ke MyHomePage.Authenticated Request:Setiap kali request.postJson atau get dipanggil, CookieRequest otomatis menyisipkan cookie sesi di header.Logout:Panggil request.logout().Django menghapus sesi di server.Flutter menghapus data lokal → Kembali ke Login Page.2. Alur Pengiriman Data ProdukInput: User mengisi form di Flutter.Validasi: Flutter memvalidasi input (misal: tidak boleh kosong).Kirim: Data dikirim via request.postJson ke Django.Simpan: Django View memvalidasi data → Simpan ke Database → Return JSON response.Tampil:Flutter menerima JSON.Parsing JSON ke objek ProductEntry menggunakan ProductEntry.fromJson.FutureBuilder me-render data ke dalam ListView.User melakukan tap pada item → Masuk ke ProductDetailPage.🛠️ Langkah Implementasi Step-by-StepBerikut adalah tahapan yang dilakukan untuk menyelesaikan integrasi ini:Setup State Management:Menambahkan Provider di main.dart untuk menyediakan instance CookieRequest ke seluruh pohon widget.Fitur Autentikasi:Membuat LoginPage dan RegisterPage lengkap dengan form validasi.Mengintegrasikan fungsi login/register dari pbp_django_auth.Pembuatan Model Data:Mendefinisikan class ProductEntry yang mencakup field (name, price, description, dll) serta method fromJson/toJson untuk parsing data.Halaman Daftar Produk (ProductEntryListPage):Menggunakan FutureBuilder untuk memanggil endpoint JSON Django.Menggunakan ListView.builder untuk merender ProductEntryCard.Detail & Filter:Membuat ProductDetailPage untuk menampilkan info lengkap saat kartu ditekan.Menambahkan logika filter di backend/frontend untuk fitur "My Products" (hanya menampilkan produk milik user yang sedang login).Integrasi Logout:Menambahkan tombol Logout di menu utama yang memanggil fungsi logout dan membersihkan state aplikasi.