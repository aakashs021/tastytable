import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Padding(
          padding:
              EdgeInsets.zero, // Remove the padding between leading and title
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search recipes', // Hint text for the TextField
              border: InputBorder.none, // Remove the border completely
              focusedBorder: InputBorder.none, // Ensure no border when focused
              enabledBorder:
                  InputBorder.none, // Ensure no border when not focused
            ),
          ),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Divider(
                color: Colors.grey,
              ),
            )),
      ),
      body: Container(
        height: 100,
        width: double.infinity,
        // color: Colors.red,
      ),
    );
  }
}
// Widget SearchAppBar(){}
