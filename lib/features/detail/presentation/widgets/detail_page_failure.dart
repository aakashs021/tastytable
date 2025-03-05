import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailPageFailure extends StatelessWidget {
  const DetailPageFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  'Sorry!'),
              Text('Recipes are not available for now.')
            ],
          ),
        ),
        Positioned(
          left: 20,
          top: 40,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black26,
            child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.chevron_left_sharp,
                  color: Colors.black,
                )),
          ),
        ),
      ],
    );
  }
}
