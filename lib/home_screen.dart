import 'package:flutter/material.dart';
import 'manga_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> mangaList = [
    {'title': 'Naruto', 'image': 'assets/naruto.jpg', 'description': 'A story about a young ninja with big dreams.'},
    {'title': 'One Piece', 'image': 'assets/one_piece.jpg', 'description': 'Join Luffy on his quest for the One Piece.'},
    {'title': 'Attack on Titan', 'image': 'assets/attack_on_titan.jpg', 'description': 'Humans fighting for survival against Titans.'},
    {'title': 'My Hero Academia', 'image': 'assets/my_hero_academia.jpg', 'description': 'In a world of heroes, one boy dreams of greatness.'},
    {'title': 'Demon Slayer', 'image': 'assets/demon_slayer.jpg', 'description': 'A story of vengeance and demon hunting.'},
  ];

  final List<Map<String, String>> favorites;

  HomeScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: mangaList.length,
        itemBuilder: (context, index) {
          final manga = mangaList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MangaDetailScreen(
                    manga: manga,
                    favorites: favorites,
                  ),
                ),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        manga['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        manga['title']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
