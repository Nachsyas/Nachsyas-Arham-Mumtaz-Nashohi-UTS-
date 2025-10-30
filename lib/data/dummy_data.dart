import 'package:myapp/model/movie_model.dart';

const List<Movie> forYouMovies = [
  Movie(id: 'f1', title: "Interstellar", posterURL: "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg", rating: 8.4, synopsis: "Perjalanan sekelompok penjelajah yang menggunakan lubang cacing untuk melampaui batas perjalanan luar angkasa manusia."),
  Movie(id: 'f4', title: "Oppenheimer", posterURL: "https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", rating: 8.6, synopsis: "Kisah fisikawan Amerika, J. Robert Oppenheimer, dan perannya dalam pengembangan bom atom."),
  Movie(id: 'f5', title: "Dune", posterURL: "https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg", rating: 7.9, synopsis: "Perjalanan Paul Atreides, seorang pemuda brilian yang ditakdirkan untuk hal-hal besar di planet paling berbahaya di alam semesta."),
  Movie(id: 'f6', title: "Joker", posterURL: "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg", rating: 8.2, synopsis: "Di Gotham City, komedian gagal Arthur Fleck mencari koneksi saat ia berjalan di jalanan. Ia memulai spiral kejahatan yang brutal."),
  Movie(id: 'f7', title: "Tenet", posterURL: "https://image.tmdb.org/t/p/w500/k68nPLbIST6NP96JmTxmZijEvCA.jpg", rating: 7.2, synopsis: "Berbekal hanya satu kata—Tenet—dan berjuang untuk kelangsungan hidup seluruh dunia, sang Protagonis melakukan perjalanan melalui dunia spionase internasional."),
  Movie(id: 'f8', title: "Everything Everywhere", posterURL: "https://image.tmdb.org/t/p/w500/w3LxiVYdWWRvEVdn5RYq6jIqkb1.jpg", rating: 8.0, synopsis: "Seorang imigran Tionghoa-Amerika terseret ke dalam petualangan gila, di mana ia sendiri yang bisa menyelamatkan dunia."),
];

const List<Movie> allForYouMovies = [
  ...forYouMovies, // 8 film di atas
  Movie(id: 'f9', title: "The Dark Knight", posterURL: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", rating: 8.5),
  Movie(id: 'f10', title: "Parasite", posterURL: "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg", rating: 8.5),
  Movie(id: 'f11', title: "Lord of the Rings: Fellowship", posterURL: "https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg", rating: 8.4),
  Movie(id: 'f12', title: "The Godfather", posterURL: "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg", rating: 8.7),
  Movie(id: 'f14', title: "Your Name.", posterURL: "https://image.tmdb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg", rating: 8.5),
  Movie(id: 'f15', title: "Pulp Fiction", posterURL: "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg", rating: 8.5),
  Movie(id: 'f16', title: "Forrest Gump", posterURL: "https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg", rating: 8.5),
  Movie(id: 'f17', title: "Fight Club", posterURL: "https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", rating: 8.4),
  Movie(id: 'f18', title: "The Matrix", posterURL: "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg", rating: 8.2),
];

const List<Movie> heroBannerMovies = [
    Movie(id: 'h3', title: "Oppenheimer", posterURL: "https://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", synopsis: "Paling Populer"), // Urutan pertama
    Movie(id: 'h1', title: "Interstellar", posterURL: "https://image.tmdb.org/t/p/w780/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg", synopsis: "Now Streaming Exclusively"), // Urutan kedua
    Movie(id: 'h2', title: "Dune", posterURL: "https://image.tmdb.org/t/p/w780/d5NXSklXo0qyIYkgV94XAgMIckC.jpg", synopsis: "Baru Tersedia"), // Urutan ketiga
];
