import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
      home: HomePage()
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode focusNode = FocusNode();
  List mainEnglishWords = <String>[];
  List englishWords = <String>[];

  void getEnglishWords() async {
    rootBundle.loadString("assets/words/words.txt").then((value){
      setState(() {
        mainEnglishWords = value.split('\n');
        englishWords = value.split('\n');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getEnglishWords();
  }

  void onSearch(String text) {
    List newList = [];
    for (String name in mainEnglishWords) {
      if (
      name.toLowerCase().contains(text.toLowerCase())
      ){
        newList.add(name);
      }
    }
    setState(() {
      englishWords = newList;
    });
  }

  void onListItemTap() async {
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Demo App"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          children: [
            SearchBox(
              hintText: 'Search for any english word...',
              onChanged: onSearch,
              focusNode: focusNode,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: englishWords.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: ListTile(
                      onTap: onListItemTap,
                      title: Text(englishWords[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    this.focusNode,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);
  final String hintText;
  final FocusNode? focusNode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
