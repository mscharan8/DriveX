import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.userSearch}) : super(key: key);

  final String userSearch;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.text = widget.userSearch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(onPressed:(){ Navigator.of(context).pop(searchController.text);},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: const Text("Search", style:TextStyle(color: Colors.black87))),
        ),
      ),
    );
  }


  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.chevron_left),
      ),
      title: Row(
        children: [
          SizedBox(
            width: 268,
            height: 32,
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search Location',
                contentPadding: EdgeInsets.all(8.0),
              ),
              autofocus: false,
            ),
          ),
          GestureDetector(
            onTap: () {
              searchController.clear();
            },
            child:  const Padding(
              padding:EdgeInsets.symmetric(horizontal: 16.0),
              child:  Text('clear',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
