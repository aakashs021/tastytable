import 'package:flutter/widgets.dart';

Widget EmptyTextData(){
  return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Text(style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),'Sorry!'),
                Text('Recipes are not available for now.')
              ],
            );
}