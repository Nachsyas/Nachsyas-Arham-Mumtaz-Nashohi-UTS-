# UTS-Mobile-Programming

PENDAHULUAN
Deskripsi Umum Tema Aplikasi
Tema yang dikembangkan untuk proyek aplikasi mobile ini adalah "Platform Streaming Film Islami" (Islamic Movie Platform), dengan nama aplikasi "iNox". Di tengah maraknya platform streaming digital general-purpose seperti Netflix atau Disney+, terdapat sebuah ceruk pasar yang kebutuhannya belum terpenuhi secara spesifik, yaitu audiens Muslim yang mencari konten film, serial, atau dokumenter yang tidak hanya menghibur tetapi juga sejalan dengan nilai-nilai Islam, edukatif, dan aman ditonton oleh keluarga.
Aplikasi "iNox" (terlihat dari main.dart dan login_screen.dart) dirancang sebagai platform terkurasi yang didedikasikan untuk menyajikan katalog film-film tersebut. Aplikasi ini berfungsi sebagai agregator dan penyaji konten, memudahkan pengguna untuk menemukan, menjelajahi, dan menonton film-film Islami pilihan.
Alasan Pemilihan Tema
Pemilihan tema "Platform Streaming Film Islami" didasarkan pada observasi atas masalah nyata (konteks), motivasi untuk menyediakan solusi yang terfokus, dan urgensi kebutuhan akan platform alternatif.
Konteks (Masalah yang Ada): Pengguna yang ingin mencari tontonan Islami di platform mainstream seringkali menghadapi kesulitan. Konten tersebut "tenggelam" di antara ribuan konten umum, pencarian seringkali tidak relevan, dan tidak ada jaminan bahwa konten yang berdekatan (rekomendasi) aman dari segi nilai.
Motivasi (Solusi yang Ditawarkan): Motivasi utama adalah menciptakan sebuah "safe space" digital. iNox menawarkan perpustakaan yang 100% terkurasi. Ini memberikan ketenangan pikiran (peace of mind) bagi orang tua dan individu yang ingin menikmati hiburan tanpa khawatir akan paparan konten yang tidak pantas.
Urgensi (Kebutuhan Pasar): Kebutuhan akan media yang sejalan dengan nilai-nilai agama semakin meningkat. Dengan menyediakan platform khusus, iNox tidak hanya memenuhi kebutuhan hiburan tetapi juga membantu mempromosikan karya-karya sinematografer Muslim.
Relevansi terhadap Pengembangan Aplikasi Mobile
Implementasi tema ini dalam bentuk aplikasi mobile sangat relevan dan ideal, didorong oleh perilaku konsumsi media modern:
Aksesibilitas (On-the-Go): Konsumsi video saat ini didominasi oleh perangkat seluler. Aplikasi mobile memungkinkan pengguna untuk menonton film kapan saja dan di mana saja.
Pengalaman Pengguna yang Imersif: Aplikasi mobile memungkinkan perancangan antarmuka (UI) yang imersif dan terfokus (seperti dark mode yang sinematik) yang dirancang khusus untuk kenyamanan menonton di layar yang lebih kecil.Personalisasi: Platform mobile ideal untuk fitur personalisasi. Dalam proyek ini, fungsionalitas "Lanjutkan Menonton" (RecentlyViewedService) adalah contoh awal dari personalisasi yang melacak aktivitas pengguna secara individual di perangkat mereka.
Integrasi Ekosistem: Aplikasi ini terintegrasi langsung dengan layanan backend seperti Firebase (untuk autentikasi), yang merupakan fondasi standar dalam pengembangan aplikasi mobile untuk mengelola akun pengguna secara aman.
Tujuan dan Ruang Lingkup Proyek
Berdasarkan latar belakang tersebut, proyek ini memiliki tujuan dan batasan sebagai berikut:
Tujuan Proyek:
Merancang dan mengimplementasikan antarmuka pengguna (UI) yang fungsional, modern, dan imersif untuk aplikasi streaming film menggunakan Flutter.
Menerapkan alur pengguna yang lengkap, mulai dari autentikasi pengguna (Login/Registrasi) hingga penjelajahan konten (Home, Search, Detail).
Mengimplementasikan fitur administrasi (CRUD - Create, Read, Update, Delete) untuk manajemen data film.
Menerapkan manajemen state reaktif sederhana menggunakan ValueNotifier untuk menyinkronkan data antara fitur admin dan tampilan pengguna secara real-time.
Ruang Lingkup Proyek (Batasan):
Proyek ini berfokus penuh pada pengembangan frontend (sisi klien) aplikasi.
Autentikasi pengguna (Login/Register) terhubung ke Firebase Authentication sungguhan, seperti yang terlihat di auth_service.dart dan firebase_options.dart. Penyimpanan data profil pengguna juga menggunakan Firebase Firestore (firestore_service.dart).
Namun, data film (katalog film, poster, sinopsis) bersifat statis (data dummy) yang dimuat dari file dummy_data.dart dan dikelola oleh MovieDataService.
Proyek tidak mencakup fungsionalitas video player (pemutaran film) atau integrasi payment gateway untuk langganan.



PERANCANGAN ANTARMUKA (UI DESIGN)
Bagian ini memaparkan konsep desain antarmuka pengguna (UI) yang diterapkan dalam pengembangan aplikasi "iNox", yang bertujuan menciptakan pengalaman sinematik, modern, dan fokus pada konten.

Konsep Desain Utama
Konsep utama desain aplikasi ini adalah "Immersive & Content-First" (Imersif & Mengutamakan Konten).
Immersive (Imersif): Antarmuka menggunakan tema gelap (dark mode) secara penuh, seperti yang didefinisikan di main.dart. Ini adalah praktik standar industri untuk aplikasi streaming karena mengurangi ketegangan mata dan membuat poster film (visual) lebih "menonjol".
Content-First (Mengutamakan Konten): Desain tata letak berfokus pada penyajian poster film. Elemen UI seperti teks dan tombol dirancang agar jelas namun tidak mengambil alih fokus utama dari konten visual (film). Navigasi dibuat sederhana (3 tab utama di home_screen.dart) agar pengguna dapat langsung menjelajahi konten.
Skema Warna (Color Palette)
Palet warna didefinisikan secara terpusat dalam file main.dart untuk memastikan konsistensi global di seluruh aplikasi.
Latar Belakang Utama (kDarkBlue - 0xFF1B1D2A): Warna biru sangat gelap (mendekati hitam) dipilih sebagai scaffoldBackgroundColor. Ini memberikan nuansa premium dan sinematik.
Warna Primer (kAccentBlue - 0xFF6A53F0): Warna biru/ungu yang cerah (kAccentBlue) digunakan sebagai warna aksen utama. Warna ini digunakan pada elemen interaktif kunci seperti ElevatedButton, BottomNavigationBarItem yang aktif, dan indikator loading.
Warna Teks & Input:
Teks Utama: Putih standar (dari Brightness.dark).
Input Fields: Menggunakan fillColor: Colors.black.withOpacity(0.3) (inputDecorationTheme di main.dart) untuk formulir (Login, Register, Admin) agar terlihat menyatu dengan tema gelap.
Tipografi (Typography)
Aplikasi ini menggunakan font family "Poppins" dari paket google_fonts, yang diterapkan secara global melalui ThemeData di main.dart (textTheme: GoogleFonts.poppinsTextTheme(...)).
Alasan Pemilihan "Poppins": Font ini memiliki karakter geometris yang modern, bersih, dan sangat mudah dibaca. Huruf-hurufnya yang sedikit membulat memberikan kesan ramah namun tetap profesional.
Hierarki Tipografi:
Judul Aplikasi (di Home): Theme.of(context).textTheme.headlineMedium (home_screen.dart).
Judul Bagian (di Home): Theme.of(context).textTheme.titleLarge.
Judul Film (di Card): Theme.of(context).textTheme.bodyMedium dengan fontWeight.w600 (movie_card.dart).
Teks Isi (Sinopsis): Theme.of(context).textTheme.bodyMedium dengan color: Colors.white70 (movie_detail_screen.dart).
Ikonografi (Iconography)
Aplikasi ini sebagian besar menggunakan ikon standar yang disediakan oleh Flutter, yaitu Material Icons.
Navigasi Utama: Ikon Icons.home, Icons.search, dan Icons.person digunakan di BottomNavigationBar (home_screen.dart).
Aksi (CRUD): Ikon Icons.add (untuk Tambah Film), Icons.edit, dan Icons.delete (di movie_management_screen.dart).
Lainnya: Icons.star (untuk rating), Icons.clear (di search_screen.dart).
Tata Letak (Layout)
Struktur tata letak aplikasi dirancang untuk menyajikan banyak konten visual secara efisien.
Navigasi Utama: Struktur utama aplikasi menggunakan Scaffold dengan BottomNavigationBar (home_screen.dart) yang menampung tiga halaman utama: HomeScreenContent, SearchScreen, dan ProfileScreen.
Halaman Home (HomeScreenContent): Menggunakan SingleChildScrollView yang membungkus Column. Tata letaknya vertikal, terdiri dari:
Hero Carousel: Menggunakan PageView.builder (_buildHeroCarousel).
Carousels Horizontal: Menggunakan ListView.builder horizontal (_buildHorizontalList) atau widget kustom ForYouCarousel.
Halaman Pencarian & "Lihat Semua": Menggunakan GridView.builder (search_screen.dart, see_all_screen.dart) untuk menampilkan poster film dalam format grid yang padat.
Komponen UI Utama (Key UI Components)
Untuk menjaga konsistensi, beberapa komponen UI dibuat kustom dan dapat digunakan kembali:
MovieCard (movie_card.dart): Ini adalah widget kustom terpenting, menampilkan poster film dengan borderRadius dan judul film di bawahnya. Widget ini juga membungkus logika GestureDetector onTap untuk bernavigasi ke MovieDetailScreen.
ForYouCarousel (for_you_carousel.dart): Widget kustom yang membungkus PageView horizontal dengan viewportFraction tertentu, memberikan efek carousel di mana film di sebelahnya terlihat sebagian.
AuthBackground & ScrollingBackground: Widget kustom yang memberikan latar belakang visual dinamis (wallpaper berganti atau scrolling posters) untuk halaman Login dan Search, menciptakan nuansa yang lebih hidup.

TANGKAPAN LAYAR DAN HASIL IMPLEMENTASI
Perancangan antarmuka dikembangkan secara mandiri berdasarkan alur pengguna yang telah didefinisikan dan best practice UI/UX modern untuk aplikasi streaming. Tidak ada file Figma yang digunakan; referensi utama adalah aplikasi streaming populer. Berikut adalah tangkapan layar (screenshot) dari beberapa halaman utama aplikasi "iNox" yang telah dikembangkan menggunakan Flutter.
Halaman Autentikasi (Login) dan Halaman Utama (Home): [Tangkapan Layar: Halaman Login (login_screen.dart) dan Halaman Home (home_screen.dart)] Gambar di atas menunjukkan Halaman Login dengan AuthBackground dan Halaman Home dengan BottomNavigationBar, Hero Carousel, dan daftar film.


Halaman Pencarian (Search) dan Halaman Detail Film: [Tangkapan Layar: Halaman Pencarian (search_screen.dart) dan Halaman Detail (movie_detail_screen.dart)] Gambar di atas menunjukkan Halaman Pencarian dengan GridView hasil dan Halaman Detail Film yang menampilkan poster besar dan sinopsis. 
Halaman Profil dan Halaman Kelola Film (Admin CRUD): [Tangkapan Layar: Halaman Profil (profile_screen.dart) dan Halaman Kelola Film (movie_management_screen.dart)] Gambar di atas menunjukkan Halaman Profil yang berisi menu navigasi (termasuk "Kelola Film") dan Halaman Manajemen Film yang menampilkan daftar film dengan tombol Edit dan Hapus.
IMPLEMENTASI PROGRAM
Bagian ini menjelaskan implementasi teknis dari perancangan yang telah dibahas. Penjelasan akan berfokus pada cuplikan kode (code snippet) paling penting yang mendefinisikan tampilan, logika, dan fitur-fitur inti dalam aplikasi "iNox".

Tampilan Aplikasi: Mendefinisikan Tema Visual Global
Untuk memastikan aplikasi memiliki tampilan yang konsisten, profesional, dan sinematik (sesuai konsep dark mode), semua aturan visual seperti warna, font, dan bentuk tombol didefinisikan di satu tempat, yaitu file main.dart.

Main.dart
// ... (import)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color kDarkBlue = Color(0xFF1B1D2A);
    const Color kAccentBlue = Color(0xFF6A53F0);

    return MaterialApp(
      title: 'Islamic Movie Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kAccentBlue,
        scaffoldBackgroundColor: kDarkBlue,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),

       
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kAccentBlue, 
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
         inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        
        // ... (tema lainnya)
    ),
      home: const LoginScreen(),
    );
  }
}
Kode di atas menggunakan ThemeData untuk menetapkan aturan desain global. scaffoldBackgroundColor: kDarkBlue (langkah 1) adalah instruksi paling penting, yang memberi tahu setiap layar di aplikasi untuk menggunakan warna biru-gelap sebagai latar belakang. textTheme (langkah 2) menerapkan font "Poppins" ke semua teks. elevatedButtonTheme (langkah 3) dan inputDecorationTheme (langkah 4) adalah "cetak biru" (blueprint) untuk semua tombol dan field input, sehingga kita tidak perlu menata gaya (styling) satu per satu di setiap halaman. ThemeData ini seperti Panduan Gaya Merek (Brand Style Guide) untuk sebuah perusahaan. Daripada desainer harus memilih warna dan font setiap kali membuat brosur baru, panduan ini sudah menetapkan "Warna resmi kita biru, font resmi kita Poppins." Kode ini melakukan hal yang sama untuk aplikasi. Sekali diatur di sini, setiap tombol dan layar baru yang dibuat akan otomatis mengikuti aturan ini, membuat tampilan aplikasi terlihat rapi dan konsisten.
Logika Aplikasi: Autentikasi dan Manajemen Data
Logika adalah "otak" aplikasi. Ini mencakup cara aplikasi mengelola siapa yang boleh masuk (Autentikasi) dan bagaimana data (daftar film) dikelola dan disinkronkan antar halaman (Manajemen State).

Logika 1: Menjadi Penjaga Gerbang (Autentikasi Firebase)

Auth_service.dart
// ... (import)

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<User?> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await _firestoreService.createUserDocument(
          user: user,
          email: email,
        );
      }
      return user;

    } on FirebaseAuthException catch (e) {
      rethrow; 
    }
  }
  Future<User?> signInWithEmailPassword({
    required String email, 
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;

    } on FirebaseAuthException catch (e) {
      rethrow; 
    }
  }
}
Kelas AuthService adalah wrapper (pembungkus) untuk FirebaseAuth. Fungsi registerWithEmailPassword (langkah 1) tidak hanya membuat akun di layanan Autentikasi Firebase, tapi juga memanggil FirestoreService (langkah 2) untuk membuat dokumen profil pengguna di database Firestore. Fungsi signInWithEmailPassword (langkah 3) memvalidasi kredensial pengguna ke server Firebase. 
Saat Anda mendaftar (register...), Anda memberi petugas KTP (email & password). Petugas (langkah 1) mendaftarkan Anda di buku tamu utama, lalu (langkah 2) membuatkan kartu akses khusus (profil di database) untuk Anda.
Saat Anda login (signIn...), Anda menunjukkan kartu akses Anda. Petugas (langkah 3) memindai kartu itu di sistem pusat untuk memastikan kartu itu valid sebelum mengizinkan Anda masuk ke HomeScreen.

Logika 2: Menjadi Otak Penyimpanan Data Film (State Management)
Movie_data_service.dart
// ... (import)

class MovieDataService {
  static final ValueNotifier<List<Movie>> allMoviesNotifier =
      ValueNotifier<List<Movie>>([...allForYouMovies]); 
  static void deleteMovie(String movieId) {
    final currentList = allMoviesNotifier.value;
    currentList.removeWhere((movie) => movie.id == movieId);
    allMoviesNotifier.value = [...currentList];
       _updateForYouNotifier();
  }
}
MovieDataService bertindak sebagai Single Source of Truth (Sumber Kebenaran Tunggal) untuk data film. Ia menggunakan ValueNotifier (langkah 1), sebuah kelas bawaan Flutter yang menyimpan data (dalam hal ini, List<Movie>) dan bisa "memberi tahu" widget lain ketika datanya berubah. Fungsi deleteMovie (langkah 2) adalah "mutator"; ia memodifikasi daftar tersebut. Baris kunci allMoviesNotifier.value = [...currentList] (langkah 3) adalah yang memicu pembaruan ke seluruh UI. MovieDataService sebagai Papan Pengumuman Pusat di lobi kantor. allMoviesNotifier (langkah 1) adalah kertas pengumuman yang tertempel di papan itu, berisi daftar semua film. Ketika seorang Admin menghapus film (langkah 2), dia tidak hanya mencoret nama film itu. Dia mengambil kertas lama, membuangnya, dan menempelkan kertas pengumuman baru (langkah 3) dengan daftar yang sudah diperbarui.

Logika 3: Mendengarkan Perubahan Data
Home_screen.dart
// ... (import)

// ... (di dalam Widget build)
ValueListenableBuilder<List<Movie>>(
  valueListenable: MovieDataService.allMoviesNotifier, 
  builder: (context, allMovies, child) {
     
     final heroMovies = allMovies.take(3).toList();
     
     // ... (logika update timer)
     
     return _buildHeroCarousel(context, heroMovies);
  },
),
// ...
Widget ValueListenableBuilder (langkah 1) "berlangganan" ke allMoviesNotifier. Fungsi builder (langkah 2) akan dieksekusi secara otomatis setiap kali nilai di notifier berubah (misalnya, setelah deleteMovie dipanggil). Ia menerima nilai baru sebagai allMovies (langkah 3), dan kemudian membangun ulang hanya widget yang ada di dalamnya (_buildHeroCarousel) (langkah 4). ValueListenableBuilder adalah seperti seorang Manajer yang menyuruh Asistennya (langkah 1) untuk terus-menerus memantau Papan Pengumuman di lobi. Saat si Asisten melihat ada kertas pengumuman baru (langkah 2), ia segera lari kembali ke Manajer. Manajer itu (langkah 3) membaca daftar baru, dan (langkah 4) segera mengatur ulang tampilan film di carousel Halaman Home. Ini sangat efisien karena manajer tidak perlu membangun ulang seluruh Halaman Home; dia hanya mengatur ulang bagian carousel saja.
Fitur-Fitur Aplikasi
Fitur adalah gabungan dari Tampilan (UI) dan Logika (Logic) untuk mencapai satu tujuan spesifik, seperti navigasi, pencarian, atau manajemen riwayat.

Fitur 1: Kartu Film yang Dapat Digunakan Ulang (Navigasi)
Aplikasi ini menampilkan poster film di banyak tempat (Home, Search, Profile). Daripada membuat ulang tampilannya, kita membuat satu "cetak biru" (blueprint) bernama MovieCard.

Movie_card.dart
// ... (import)

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              // ... (dekorasi untuk poster gambar)
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title, 
            // ... (style teks)
          ),
        ],
      ),
    );
  }
}
MovieCard adalah widget kustom yang menerima satu objek Movie sebagai parameter. Tampilannya (Column di langkah 4) menunjukkan poster dan judul. Bagian terpenting adalah GestureDetector (langkah 1), yang membungkus tampilan dan mendeteksi ketukan (onTap). Saat diketuk, ia memanggil Navigator.push (langkah 2) untuk membuka MovieDetailScreen, sambil meneruskan objek movie (langkah 3) ke layar baru tersebut. MovieCard adalah sebuah Tombol Mewah yang berbentuk poster film. GestureDetector (langkah 1) adalah sensor sentuh pada tombol itu. Saat Anda menyentuhnya (onTap), sensor itu memicu perintah (langkah 2) yang mirip dengan "Buka pintu MovieDetailScreen!" (langkah 3). Agar penjaga di pintu baru tahu siapa Anda, Anda juga menyerahkan "tiket" (data movie) yang Anda pegang.

Fitur 2: Pencarian Film (Filtering)

Search_screen.dart
// ... (import)

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Movie> _filteredMovies = [];
  List<Movie> _allMovies = MovieDataService.allMoviesNotifier.value; 

  @override
  void initState() {
    super.initState();
    _filteredMovies = _allMovies;
    _searchController.addListener(_onSearchChanged);
    // ...
  }
  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMovies = _allMovies;
      } else {
        _filteredMovies = _allMovies
            .where((movie) => movie.title.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  // ... (Widget build akan menggunakan '_filteredMovies' untuk ditampilkan)
}
Saat layar ini dibuka (initState), kita menambahkan "pendengar" (addListener) ke _searchController (langkah 1). Pendengar ini akan memanggil fungsi _onSearchChanged (langkah 2) setiap kali teks di dalamnya berubah (misalnya, setiap ketikan). Fungsi ini mengambil teks pencarian (query), lalu memfilter daftar film utama (_allMovies) menggunakan fungsi .where untuk menemukan film yang judulnya mengandung query (langkah 3). Hasilnya disimpan di _filteredMovies, dan setState memberi tahu widget untuk menggambar ulang (rebuild) tampilannya dengan daftar yang sudah difilter. ni seperti memiliki seorang Asisten yang sangat cepat. Anda (langkah 1) menyuruh Asisten untuk mengawasi apa yang Anda ketik di kotak pencarian. Setiap kali Anda mengetik satu huruf (langkah 2), Asisten itu (langkah 3) langsung berlari ke lemari arsip besar (daftar _allMovies), memeriksa setiap map (film) satu per satu, mengambil semua map yang judulnya cocok dengan ketikan Anda, dan langsung meletakkan hasil filter itu di meja Anda (_filteredMovies).

Fitur 3: Lanjutkan Menonton (Riwayat Tontonan)
movie_detail_screen.dart
// ... (import)

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  @override
  void initState() { 
    super.initState();
    
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      RecentlyViewedService.addMovie(widget.movie);
    });
  }

  // ... (Widget build untuk menampilkan detail film)
}
initState adalah fungsi lifecycle yang berjalan otomatis saat sebuah widget pertama kali dibuat. Di dalamnya, kita menggunakan addPostFrameCallback (langkah 1) untuk memastikan widget sudah selesai dibangun sebelum kita menjalankan logika. Logika utamanya sederhana: kita memanggil RecentlyViewedService.addMovie (langkah 2), sambil mengirimkan data film (widget.movie) yang sedang dilihat. RecentlyViewedService (yang juga menggunakan ValueNotifier, mirip MovieDataService) kemudian akan menyimpan film ini ke dalam daftar riwayat tontonan. initState adalah seperti lampu sensor gerak di pintu masuk ruangan. Saat Anda (pengguna) membuka Halaman Detail film, Anda memicu sensor itu. Sensor (langkah 1) menunggu sepersekian detik hingga Anda benar-benar masuk, lalu (langkah 2) ia secara otomatis mengirim pesan ke buku catatan satpam (RecentlyViewedService) yang bertuliskan, "Catat, pengguna baru saja melihat film 'Interstellar'." Nanti, Halaman Home akan memeriksa buku catatan satpam itu untuk menampilkan daftar "Lanjutkan Menonton".


HASIL DAN PEMBAHASAN
Bagian ini menganalisis hasil implementasi aplikasi "iNox", berfokus pada kesesuaian antara desain dan implementasi , serta fungsionalitas alur pengguna yang telah berhasil dibuat.
Analisis Kesesuaian Desain dan Implementasi
Implementasi aplikasi menggunakan Flutter berhasil mewujudkan konsep desain "Immersive & Content-First".
Palet Warna dan Tipografi: Implementasi 100% sesuai dengan perancangan di main.dart. Seluruh aplikasi secara konsisten menggunakan latar belakang kDarkBlue, aksen kAccentBlue (terlihat pada tombol dan ikon tab aktif), dan font Poppins di semua layar. Tema gelap dan skema warna ini berhasil menciptakan nuansa sinematik yang diinginkan.
Tata Letak (Layout): Konsep tata letak berbasis carousel dan grid berhasil diimplementasikan. HomeScreenContent secara efektif menggunakan PageView dan ListView horizontal. SearchScreen dan SeeAllScreen juga berhasil menggunakan GridView untuk menampilkan banyak poster.
Komponen Kustom: Widget MovieCard berhasil menjadi komponen reusable yang konsisten di seluruh aplikasi (Home, Search, See All, Recently Viewed).
Perbedaan dari Desain Awal (Gap Analysis): Karena tidak ada file desain Figma, perbandingan dilakukan terhadap best practice aplikasi serupa. Implementasinya sudah sangat baik, namun gap fungsional utama adalah data film yang masih dummy. Desain UI untuk error handling (misalnya jika poster film gagal dimuat di MovieCard) juga telah ditangani dengan baik (onError builder yang menampilkan ikon).
Fungsionalitas Halaman dan Interaksi Pengguna
Berikut adalah penjelasan rinci alur interaksi pengguna yang telah diimplementasikan:
Alur Autentikasi (Login, Register, Logout):
Fungsi: Menyediakan gerbang masuk dan keluar aplikasi yang terhubung ke Firebase.
Interaksi:
Pengguna membuka LoginScreen, memasukkan email/password. Fungsi _tryLogin memvalidasi ini ke AuthService. Jika berhasil, pengguna diarahkan ke HomeScreen (Navigator.pushReplacement).
Jika pengguna belum punya akun, ia menekan link ke RegisterScreen. Setelah mendaftar, AuthService membuat akun di Firebase Auth dan dokumen di Firestore. Pengguna lalu dikembalikan ke LoginScreen untuk masuk.
Di ProfileScreen, pengguna menekan "Logout". Ini memanggil Navigator.pushAndRemoveUntil, membersihkan stack navigasi dan mengembalikan pengguna ke LoginScreen.
Hasil: Alur autentikasi ini berfungsi penuh (fully functional) dan aman, terhubung langsung ke backend Firebase.
Alur Navigasi Utama (Home, Search, Profile):
Fungsi: Menyediakan navigasi inti aplikasi.
Interaksi: Pengguna menekan ikon di BottomNavigationBar (HomeScreen). State _selectedIndex berubah, yang menyebabkan body dari Scaffold berganti antara HomeScreenContent, SearchScreen, dan ProfileScreen.
Hasil: Navigasi tab utama berfungsi lancar dan stateful.
Alur Penjelajahan Konten (Home & Detail):
Fungsi: Alur utama pengguna untuk menemukan dan melihat detail film.
Interaksi:
Di HomeScreenContent, pengguna melihat Hero Carousel, daftar "Untuk Anda" (dari MovieDataService), dan "Lanjutkan Menonton" (dari RecentlyViewedService).
Pengguna menekan sebuah MovieCard.
Aplikasi bernavigasi ke MovieDetailScreen sambil membawa objek Movie yang dipilih.
Saat MovieDetailScreen di-initState, WidgetsBinding.instance.addPostFrameCallback dipanggil, yang kemudian memanggil RecentlyViewedService.addMovie(widget.movie).
Hasil: Alur ini berhasil. Saat pengguna kembali ke HomeScreen, film yang baru saja ia lihat langsung muncul di daftar "Lanjutkan Menonton" berkat ValueListenableBuilder yang mendengarkan RecentlyViewedService.
Alur Pencarian:
Fungsi: Memfilter katalog film berdasarkan input pengguna.
Interaksi: Pengguna masuk ke SearchScreen. Ia mengetik di TextField. _searchController.addListener memanggil _onSearchChanged. Fungsi ini memfilter daftar global dari MovieDataService.allMoviesNotifier berdasarkan judul.
Hasil: Pencarian bersifat real-time dan sangat cepat karena hanya memfilter data dummy yang sudah ada di memori.
Alur Admin (CRUD Film):
Fungsi: Mengelola katalog film (Tambah, Edit, Hapus). Ini adalah alur backend-simulation yang paling penting.
Interaksi:
Pengguna (Admin) masuk ke ProfileScreen -> MovieManagementScreen.
Create: Menekan FAB (+), membuka AddEditMovieScreen (mode Tambah). Setelah mengisi form dan menyimpan, Navigator.pop(context, newMovieData) dipanggil. MovieManagementScreen menangkap hasil ini dan memanggil MovieDataService.addMovie(result).
Update: Menekan ikon Edit, membuka AddEditMovieScreen (mode Edit, dengan movieToEdit terisi). Setelah menyimpan, MovieDataService.updateMovie(result) dipanggil.
Delete: Menekan ikon Hapus, memunculkan AlertDialog, lalu memanggil MovieDataService.deleteMovie(movie.id).
Hasil: Ini adalah implementasi paling sukses dari arsitektur aplikasi. Seketika seorang admin menghapus film di MovieManagementScreen, MovieDataService.allMoviesNotifier.value diperbarui. Jika pengguna langsung kembali ke HomeScreen atau SearchScreen, film tersebut sudah hilang dari daftar, karena ValueListenableBuilder di layar tersebut bereaksi terhadap perubahan state global.
Evaluasi Pencapaian Tujuan Proyek
Berdasarkan analisis fungsionalitas, aplikasi ini telah berhasil memenuhi seluruh tujuan yang ditetapkan:
Tujuan Tercapai:
GUI yang fungsional, modern, dan imersif (Tema Gelap, Poppins) berhasil diimplementasikan (main.dart).
Alur pengguna (Autentikasi, Penjelajahan) berhasil diimplementasikan.
Fitur administrasi (CRUD) berhasil diimplementasikan (movie_management_screen.dart).
Manajemen state reaktif menggunakan ValueNotifier berhasil diimplementasikan, terbukti dengan sinkronisasi instan antara alur Admin (CRUD) dan alur Pengguna (Home).
Integrasi backend untuk Autentikasi (Firebase Auth) dan penyimpanan profil (Firestore) berhasil diimplementasikan.
Keterbatasan dan Pengembangan Lanjutan:
Keterbatasan terbesar adalah data film yang masih statis (dummy_data.dart). Meskipun state management-nya reaktif, sumber datanya belum terhubung ke database sungguhan.
FirestoreService sudah ada namun baru digunakan untuk koleksi users.
Langkah pengembangan selanjutnya yang paling logis adalah memigrasi MovieDataService. Alih-alih mengisi allMoviesNotifier dari dummy_data.dart, ia harus diubah untuk mengambil (dan memanipulasi) data dari koleksi movies di Firebase Firestore.


KESIMPULAN
Pengembangan aplikasi "iNox (Islamic Movie Platform)" telah berhasil melalui seluruh tahapan proses, mulai dari perancangan arsitektur dan tema visual hingga implementasi fungsional pada frontend. Proses dimulai dengan pendefinisian tema visual (dark mode, font Poppins, warna aksen) secara terpusat di main.dart. Tahap implementasi dieksekusi menggunakan Flutter dengan memanfaatkan layanan Firebase Authentication dan Firestore untuk manajemen pengguna, serta arsitektur state management reaktif bawaan Flutter (ValueNotifier) untuk data aplikasi. Pencapaian utama dari proyek ini adalah terwujudnya sebuah prototipe aplikasi frontend yang fungsional dan memiliki arsitektur yang solid. Aplikasi ini berhasil mengimplementasikan dua alur utama yang saling terhubung:
Alur Pengguna: Autentikasi (Login/Register/Logout), penjelajahan konten (Home, Search), melihat detail, dan pelacakan riwayat tontonan (RecentlyViewedService).
Alur Admin: Fitur CRUD (Create, Read, Update, Delete) film yang terisolasi di dalam halaman profil (MovieManagementScreen).
Keberhasilan terbesar dari arsitektur yang dipilih adalah implementasi MovieDataService yang menggunakan ValueNotifier sebagai single source of truth. Ini memungkinkan perubahan yang dilakukan oleh Admin (misalnya, menghapus film) untuk secara instan dan otomatis diperbarui di Halaman Home dan Halaman Pencarian yang didengarkan oleh ValueListenableBuilder. Ini membuktikan bahwa aplikasi siap untuk dihubungkan ke backend sungguhan tanpa perlu mengubah logika UI. Refleksi terhadap hasil menunjukkan bahwa seluruh tujuan frontend dan arsitektur telah tercapai. Keterbatasan utama saat ini adalah sumber data film yang masih statis. Oleh karena itu, potensi pengembangan lanjutan sangat jelas: memodifikasi MovieDataService dan FirestoreService agar dapat melakukan operasi CRUD pada koleksi movies di Firebase Firestore, menggantikan dummy_data.dart sebagai sumber data utama.

REFERENSI

 


