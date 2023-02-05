import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:filter_listview/controller.dart';

void main() {
  runApp(const MaterialApp(
      home: HomePage()
  ));
}

class HomePage extends GetView<Controller> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Controller());
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
              onChanged: controller.onSearch,
              focusNode: controller.focusNode,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.englishWords.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: ListTile(
                      onTap: controller.onListItemTap,
                      title: Text(controller.englishWords.elementAt(index)),
                    ),
                  );
                },
              )),
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
