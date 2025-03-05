
import 'package:flutter/material.dart';
import 'package:tastytable/features/detail/data/model/ingredients_model.dart';

class IngredientsContentColumnWidget extends StatefulWidget {
  final List ingredients;
  IngredientsContentColumnWidget({super.key, required this.ingredients});

  @override
  State<IngredientsContentColumnWidget> createState() =>
      _IngredientsContentColumnWidgetState();
}

class _IngredientsContentColumnWidgetState
    extends State<IngredientsContentColumnWidget> {
  late bool showContent;

  @override
  void initState() {
    showContent = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showContent = !showContent;
                      });
                    },
                    icon: Icon(showContent
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded))
              ],
            ),
           AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child:
                     showContent
                ?  ListView.builder(
                      padding: null,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.ingredients.length,
                      itemBuilder: (context, index) {
                        IngredientsModel model = IngredientsModel.fromJson(
                            json: widget.ingredients[index]);
                        return Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 5,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              model.ingredientAmount +
                                  " " +
                                  model.ingredientUnit +
                                  " of " +
                                  model.ingredientName,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      },
                    ): SizedBox(),
                  ),
                
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
