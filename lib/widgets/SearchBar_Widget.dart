import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String selectedCountry = 'us'; // 
  int selectedMax = 10; 
  String selectedSortBy = 'publishedAt'; 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: <Widget>[
          // Search Icon
          Icon(Icons.search, color: Colors.grey),

          // Search Text Field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),

          // Country Dropdown Menu
          DropdownButton<String>(
            value: selectedCountry,
            onChanged: (String? newValue) {
              setState(() {
                selectedCountry = newValue!;
              });
            },
            items: <String>['us', 'gb', 'ca', 'au'] // Add more country codes
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text('Country: $value'),
              );
            }).toList(),
          ),

          // Max Dropdown Menu
          DropdownButton<int>(
            value: selectedMax,
            onChanged: (int? newValue) {
              setState(() {
                selectedMax = newValue!;
              });
            },
            items: <int>[1, 5, 10, 20] // Add more max options
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('Max: $value'),
              );
            }).toList(),
          ),

          // SortBy Dropdown Menu
          DropdownButton<String>(
            value: selectedSortBy,
            onChanged: (String? newValue) {
              setState(() {
                selectedSortBy = newValue!;
              });
            },
            items:
                <String>['publishedAt', 'relevance'] // Add more sorting options
                    .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text('SortBy: $value'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
