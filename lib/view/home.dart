import 'package:flutter/material.dart';
import 'package:myapp/model/game.dart'; // [cite: 93]
import 'package:myapp/viewmodel/fetchgame.dart'; // [cite: 95]

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Game>> gameList; // [cite: 98]

  @override
  void initState() {
    super.initState(); // [cite: 97]
    loadGames(); // [cite: 97]
  }

  Future<void> loadGames() async {
    setState(() {
      gameList = fetchGames(); // [cite: 97]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400, // [cite: 126]
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // [cite: 129]
          child: Column(
            children: [
              _searchBar(), // [cite: 195]
              const SizedBox(height: 10), // [cite: 197, 199]
              Expanded(
                child: FutureBuilder<List<Game>>(
                  future: gameList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) { // [cite: 344]
                      return const Center(child: CircularProgressIndicator()); // [cite: 345]
                    } else if (snapshot.hasError) { // [cite: 346]
                      return Text('Error: ${snapshot.error}'); // [cite: 347]
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) { // [cite: 348]
                      return const Text('Tidak ada data game.'); // [cite: 349]
                    } else {
                      final games = snapshot.data!.take(25).toList();
                      return ListView.builder( // [cite: 350]
                        itemCount: games.length, // [cite: 304]
                        itemBuilder: (context, index) {
                          final game = games[index]; // [cite: 313]
                          return GestureDetector( // [cite: 352]
                            onTap: () {
                              Navigator.pushNamed( // [cite: 316, 354]
                                context,
                                '/detail', // [cite: 318]
                                arguments: game.id, // [cite: 327]
                              );
                            },
                            child: _listItem(
                              game.thumbnail, // [cite: 330]
                              game.title, // [cite: 331]
                              game.genre, // [cite: 332]
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextField _searchBar() {
  return TextField(
    cursorColor: Colors.blue, // [cite: 140]
    decoration: InputDecoration(
      fillColor: Colors.blue.shade50, // [cite: 142]
      filled: true, // [cite: 143]
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // [cite: 145]
        borderSide: const BorderSide(
          width: 0, // [cite: 157]
          style: BorderStyle.none, // [cite: 159]
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20), // [cite: 163]
      prefixIcon: const Icon(
        Icons.search_outlined, // [cite: 173]
        color: Colors.blue, // [cite: 175]
        size: 30, // [cite: 177]
      ),
      hintText: 'Cari game', // [cite: 181]
      hintStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.7)), // [cite: 183]
    ),
  );
}

Card _listItem(String urlCover, String judul, String genre) {
  return Card(
    clipBehavior: Clip.antiAlias, // [cite: 220]
    elevation: 3, // [cite: 221]
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // [cite: 224]
    child: ListTile(
      tileColor: Colors.blue.shade50, // [cite: 228]
      leading: SizedBox(
        width: 75, // [cite: 232]
        height: 75, // [cite: 234]
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8), // [cite: 238]
          child: Image.network(
            urlCover, // [cite: 242]
            fit: BoxFit.cover, // [cite: 246]
          ),
        ),
      ),
      title: Text(judul), // [cite: 254]
      subtitle: Text(genre), // [cite: 256]
      trailing: const Icon(Icons.more_vert), // [cite: 258]
      titleAlignment: ListTileTitleAlignment.center, // [cite: 262]
    ),
  );
}