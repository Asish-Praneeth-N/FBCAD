import 'package:flutter/material.dart';

import 'manga_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, String>> favorites;

  FavoritesScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: favorites.isNotEmpty
          ? ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final manga = favorites[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Image.asset(
                manga['image']!,
                width: 50,
                height: 75,
                fit: BoxFit.cover,
              ),
              title: Text(manga['title']!),
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
            ),
          );
        },
      )
          : Center(
        child: Text(
          'No favorites yet.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
