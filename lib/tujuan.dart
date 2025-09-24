import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // background sesuai contoh
      appBar: AppBar(
        title: const Text('Ini Halaman Tujuan'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Untuk berpindah ke halaman baru, gunakan metode Navigator.push(). "
              "Metode push() akan menambahkan Route ke dalam tumpukan Route yang dikelola oleh Navigator. "
              "Route ini dapat dibuat secara kustom atau menggunakan MaterialPageRoute, "
              "yang memiliki animasi transisi sesuai dengan platform yang digunakan.",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
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
                  'assets/icon/island.png', // <-- path aset yang benar
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Untuk menutup halaman kedua dan kembali ke halaman pertama, gunakan metode Navigator.pop(). "
              "Metode pop() akan menghapus Route saat ini dari tumpukan Route yang dikelola oleh Navigator.",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke home'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}















// import 'package:flutter/material.dart';

// class TujuanPage extends StatelessWidget {
//   const TujuanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Halaman Tujuan"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Ini Halaman Tujuan",
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Kembali ke Home"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















// import 'package:flutter/material.dart';

// class Tujuan extends StatelessWidget {
//   const Tujuan({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Halaman Tujuan")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Ini adalah halaman Tujuan",
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 15),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 side: const BorderSide(width: 1.0, color: Colors.blue),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 "Kembali ke Home",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
