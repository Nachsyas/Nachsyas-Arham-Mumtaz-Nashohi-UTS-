import 'package:flutter/material.dart';
import 'package:myapp/viewmodel/fetchgame.dart'; // [cite: 474]
import 'package:myapp/model/detailgame.dart'; // [cite: 475]
import 'package:readmore/readmore.dart'; // [cite: 476]

class Detail extends StatelessWidget {
  final int gameTerpilih; // [cite: 395]
  const Detail({super.key, required this.gameTerpilih}); // [cite: 395]

  Future<DetailGame> fetchData() async {
    final jsonData = await fetchDataFromAPI(gameTerpilih); // [cite: 487]
    return DetailGame.fromJson(jsonData); // [cite: 488]
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400, // [cite: 518]
      body: FutureBuilder<DetailGame>(
        future: fetchData(), // [cite: 520]
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { // [cite: 522]
            return const Center(child: CircularProgressIndicator()); // [cite: 523]
          } else if (snapshot.hasError) { // [cite: 524]
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}')); // [cite: 525]
          } else if (!snapshot.hasData) { // [cite: 526]
            return const Center(child: Text('Data tidak tersedia')); // [cite: 527]
          } else {
            final game = snapshot.data!; // [cite: 530]
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)), // [cite: 540]
                        child: Image.network(
                          game.thumbnail, // [cite: 540]
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                      ),
                      Positioned(
                        top: 25, // [cite: 540]
                        left: 10, // [cite: 540]
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context), // [cite: 540]
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.8),
                                shape: BoxShape.circle), // [cite: 540]
                            child: const Icon(Icons.arrow_back_ios_outlined,
                                color: Colors.white), // [cite: 540]
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10), // [cite: 569]
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ), // [cite: 569]
                          child: Column(children: [
                            const Text("Minimum System Requirements",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)), // [cite: 569]
                            _requirementRow("OS", game.minimum_system_requirements.os), // [cite: 569]
                            _requirementRow("Processor",
                                game.minimum_system_requirements.processor), // [cite: 569]
                            _requirementRow("Memory",
                                game.minimum_system_requirements.memory), // [cite: 569]
                            _requirementRow("Graphics",
                                game.minimum_system_requirements.graphics), // [cite: 569]
                            _requirementRow("Storage",
                                game.minimum_system_requirements.storage), // [cite: 569]
                          ]),
                        ),
                        Container(
                          height: 200, // [cite: 600]
                          padding: const EdgeInsets.symmetric(vertical: 20), // [cite: 601]
                          child: ListView(
                            scrollDirection: Axis.horizontal, // [cite: 605]
                            children: [
                              _itemList(game.screenshots[0].image), // [cite: 609]
                              const SizedBox(width: 15), // [cite: 611]
                              _itemList(game.screenshots[1].image), // [cite: 613]
                              const SizedBox(width: 15), // [cite: 615]
                              _itemList(game.screenshots[2].image), // [cite: 617]
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5), // [cite: 625]
                          child: ReadMoreText(
                            game.description, // [cite: 627]
                            trimLines: 2, // [cite: 628]
                            colorClickableText: Colors.blue,
                            trimMode: TrimMode.Line, // [cite: 630]
                            trimCollapsedText: 'more', // [cite: 644]
                            trimExpandedText: 'less', // [cite: 646]
                            style: TextStyle(
                                color: Colors.black54.withOpacity(0.8),
                                height: 1.5), // [cite: 631]
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

SizedBox _itemList(String url) {
  return SizedBox(
    width: 250, // [cite: 548]
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15), // [cite: 552]
      child: Image.network(url, fit: BoxFit.cover), // [cite: 554, 558]
    ),
  );
}

Row _requirementRow(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start, // [cite: 579]
    children: [
      Expanded(
          flex: 3,
          child: Text(title,
              style: TextStyle(color: Colors.black54.withOpacity(0.8)))), // [cite: 580]
      Expanded(
          flex: 1,
          child: Text(':',
              style: TextStyle(color: Colors.black54.withOpacity(0.8)))), // [cite: 582]
      Expanded(
          flex: 8,
          child: Text(value,
              style: TextStyle(color: Colors.black54.withOpacity(0.8)))), // [cite: 584]
    ],
  );
}