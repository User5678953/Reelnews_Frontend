import 'package:flutter/material.dart';
import 'package:reel_news/services/my_news_fetch.dart';
import 'package:reel_news/utility/user_source_subscribed_list.dart';

class MySourcesScreen extends StatefulWidget {
  @override
  _MySourcesScreenState createState() => _MySourcesScreenState();
}

class _MySourcesScreenState extends State<MySourcesScreen> {
  List<String> _selectedSources = [];
  List<String> _fetchedSources = []; 

  @override
  void initState() {
    super.initState();
    _selectedSources = UserSourceSubScribedList.getSelectedSources();
  }

  void _toggleSource(String sourceName, bool isSubscribed) {
    setState(() {
      if (isSubscribed) {
        _selectedSources.add(sourceName);
      } else {
        _selectedSources.remove(sourceName);
      }
      UserSourceSubScribedList.setSelectedSources(_selectedSources);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Sources'),
      ),
      body: Column(
        children: [
          FetchSourcesWidget(
            onSourcesFetched: (List<String> sources) {
              setState(() {
                _fetchedSources = sources;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _fetchedSources.length,
              itemBuilder: (context, index) {
                String source = _fetchedSources[index];
                return ListTile(
                  title: Text(source),
                  trailing: Switch(
                    value: _selectedSources.contains(source),
                    onChanged: (bool value) {
                      _toggleSource(source, value);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: sourceNames.isEmpty
          ? CircularProgressIndicator()
          : throw UnimplementedError()
    );
  }
}
