import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // background sesuai contoh
      appBar: AppBar(
        title: const Text('Ini Halaman Home'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Banyak aplikasi memiliki beberapa layar untuk menampilkan informasi yang berbeda. "
              "Contohnya, ada layar produk, dan ketika pengguna mengklik produk, akan muncul layar "
              "dengan detail produk tersebut.",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            // kotak putih yang menampung icon, ditempatkan di tengah
            Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icon/home.png', // <-- path aset yang benar
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Pertama, kita perlu membuat dua halaman atau “routes” yang ingin kita tampilkan. "
              "Selanjutnya, kita gunakan perintah Navigator.push() untuk berpindah dari halaman pertama "
              "ke halaman kedua ini seperti kita membuka halaman baru. Terakhir, kita bisa kembali dari halaman kedua "
              "ke halaman pertama menggunakan Navigator.pop().",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/tujuan');
              },
              child: const Text('Ke halaman tujuan >'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
















// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Halaman Home"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Ini Halaman Home",
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/tujuan');
//               },
//               child: const Text("Ke Halaman Tujuan"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


















// import 'package:flutter/material.dart';
// import 'tujuan.dart';                                                                      //B

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Halaman Home")),                                  //A
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Ini adalah halaman Home",
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton(                                                              //G.
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 side: const BorderSide(width: 1.0, color: Colors.blue),
//               ),
//               onPressed: () {                                                           // |
//                 Navigator.push(
//                   context,                                                              // |
//                   MaterialPageRoute(builder: (context) => const Tujuan()),
//                 );
//               },
//               child: const Text(
//                 "Ke Halaman Tujuan",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
