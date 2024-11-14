import 'package:flutter/material.dart';

class ReadingProgressScreen extends StatefulWidget {
  @override
  _ReadingProgressScreenState createState() => _ReadingProgressScreenState();
}

class _ReadingProgressScreenState extends State<ReadingProgressScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _mangaProgress = [
    {'title': 'Naruto', 'progress': 0.75, 'status': 'Currently Reading'},
    {'title': 'One Piece', 'progress': 0.3, 'status': 'Want to Read'},
    {'title': 'Attack on Titan', 'progress': 1.0, 'status': 'Read'},
    {'title': 'My Hero Academia', 'progress': 0.5, 'status': 'Currently Reading'},
    {'title': 'Demon Slayer', 'progress': 0.2, 'status': 'Want to Read'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<Map<String, dynamic>> _filterMangaByStatus(String status) {
    return _mangaProgress.where((manga) => manga['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Progress'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Read'),
            Tab(text: 'Currently Reading'),
            Tab(text: 'Want to Read'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProgressList(_filterMangaByStatus('Read')),
          _buildProgressList(_filterMangaByStatus('Currently Reading')),
          _buildProgressList(_filterMangaByStatus('Want to Read')),
        ],
      ),
    );
  }

  Widget _buildProgressList(List<Map<String, dynamic>> mangaList) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: mangaList.length,
      itemBuilder: (context, index) {
        final manga = mangaList[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(manga['title']),
            subtitle: LinearProgressIndicator(
              value: manga['progress'],
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            trailing: Text('${(manga['progress'] * 100).toStringAsFixed(0)}%'),
          ),
        );
      },
    );
  }
}
