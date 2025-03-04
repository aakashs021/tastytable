import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tastytable/core/network/api_client.dart';
import 'package:tastytable/service_locator.dart';

class DetailPage extends StatelessWidget {
  final String id;

  DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                final data = await ServiceLocator.sl<ApiClient>()
                    .getIndividualRecipe(id: id);
                log(data);
              },
              child: Text('data'))
        ],
      ),
    );
  }
}
