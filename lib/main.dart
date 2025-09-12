import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alignment',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Alignment'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
          children: [
            const Text('Malang', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 10),
            const Text('25\u00B0C', style: TextStyle(fontSize: 80 , color: Colors.black54)
            ),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CuacaHari(
                Hari: 'Minggu',
                icon: Icons.wb_sunny,
                Suhu: '20\u00B0C',
              ),
              const SizedBox(width: 40),
              CuacaHari(
              Hari: 'Senin',
              icon: Icons.cloudy_snowing,
              Suhu: '23\u00B0C',
            ),
            const SizedBox(width: 40),
            CuacaHari(
              Hari: 'Selasa',
              icon: Icons.cloud,
              Suhu: '22\u00B0C',
            )
            ],
            ),
            
          ],














          // crossAxisAlignment: CrossAxisAlignment.center,
          // textBaseline: TextBaseline.alphabetic,
          //     children: [
          //       Text(
          //         'Suhu', style: TextStyle(fontSize: 30)),
          //       Text(
          //         '25\u00B0C', style: TextStyle(fontSize: 75)
          //       ),
          //       Icon(
          //         Icons.sunny, size: 45, color: Colors.amber)
                





              //   child: Row(mainAxisSize: MainAxisSize.min,
              // children: [
              //   KotakBiruJempolKecil(),
              //   SizedBox(height: 20),
              //   KotakBiruJempol(),
              //   SizedBox(height: 20),
              //   KotakBiruJempolKecil(),
                // child: Row(mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 KotakBiruJempolKecil(),
                //                 SizedBox(height: 20),
                //                 KotakBiruJempol(),
                //                 SizedBox(height: 20),
                //                 KotakBiruJempolKecil(),
              //   child: Row(mainAxisSize: MainAxisSize.max,
              // children: [
              //   KotakBiruJempolKecil(),
              //   SizedBox(height: 20),
              //   KotakBiruJempol(),
              //   SizedBox(height: 20),
              //   KotakBiruJempolKecil(),
              // Baris pertama
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     KotakWarna(
              //       color: Colors.blue,
              //       icon:Icons.favorite,
              //       iconName: 'Likes',
              //     ),
              //     const SizedBox(width: 20),
              //     KotakWarna(
              //       color: Colors.green,
              //       icon: Icons.favorite,
              //       iconName: 'Likes',
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              // // Baris kedua
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     KotakWarna(
              //       color: Colors.orange,
              //       icon: Icons.favorite,
              //       iconName: 'Likes',
              //     ),
              //     const SizedBox(width: 20),
              //     KotakWarna(
              //       color: Colors.purple,
              //       icon : Icons.favorite,
              //       iconName: 'Likes',
              //     ),
              //   ],
              // ),
              // ],
          ),
        ),
      ),
    );
  }
          // KotakBiruJempol(),
          // SizedBox(width: 20),
          // KotakBiruJempol(),
          // SizedBox(width: 20),
          // KotakBiruJempol(),
          // SizedBox(height: 20),
          // KotakBiruJempol(),
          // SizedBox(height: 20),




        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: const [
        //   KotakBiruJempol(),
        //   SizedBox(width: 20),
        //   KotakBiruJempol(),
        //   SizedBox(width: 20),
        //   KotakBiruJempol(),  //
        // child: KotakBiruJempol()
      
  
}


class CuacaHari extends StatelessWidget {
  final String Hari;
  final IconData icon;
  final String Suhu;

  const CuacaHari({super.key, required this.icon, this.Hari = '', this.Suhu = ''});

  Widget build( BuildContext context) {
    return Column(
      children: [
        Text(Hari, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Icon(icon, size: 45, color: Colors.amber),
        const SizedBox(height: 10),
        Text(
          Suhu, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
      ],
    );
  }

}

// class KotakBiruJempol extends StatelessWidget {
//   const KotakBiruJempol({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         border: Border.all(color: Colors.black, width: 2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.thumb_up, color: Colors.white, size: 40),
//     );
//   }
// }

// class KotakBiruJempolKecil extends StatelessWidget {
//   const KotakBiruJempolKecil({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 75,
//       height: 75,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         border: Border.all(color: Colors.black, width: 2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.thumb_up, color: Colors.white, size: 40),
//     );
//   }
// }










// class KotakWarna extends StatelessWidget {
//   final Color color;
//   final IconData  icon;
//   final String iconName;

//   const KotakWarna({super.key, required this.color, required this.icon, this.iconName = ''});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             color: color,
//             border: Border.all(color: Colors.black, width: 2),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Icon(Icons.favorite, color: Colors.red, size: 40),
//         ),
//         const SizedBox(height: 8),
//         Text(iconName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         // const SizedBox(height: 8),
//         // Icon(icon, size: 30, color: Colors.black),
//       ],
//     );
//   }
// }


// class KotakBiruJempol extends StatelessWidget {
//   const KotakBiruJempol({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         border: Border.all(color: Colors.black, width: 2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.thumb_up, color: Colors.amber, size: 40),
//     );
//   }
// }
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
