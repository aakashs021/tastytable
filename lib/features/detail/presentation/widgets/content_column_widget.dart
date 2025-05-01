import 'package:flutter/material.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';

class ContentColumnWidget extends StatefulWidget {
  final String title;
  final String content;
  final int colorCode;
  // final Color? color;
  ContentColumnWidget(
      {super.key,
      required this.title,
      required this.content,
      this.colorCode = 1});

  @override
  State<ContentColumnWidget> createState() => _ContentColumnWidgetState();
}

class _ContentColumnWidgetState extends State<ContentColumnWidget> {
  late Color color;
  late Color bgColor;
  late bool showContent;
  @override
  void initState() {
    showContent = true;
    color = containerColorFunction(colorCode: widget.colorCode);
    int bgColorCode = widget.colorCode - 1;
    bgColor = containerColorFunction(colorCode: bgColorCode);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.colorCode == 3 ? null : bgColor,
        gradient: widget.colorCode == 3
            ? LinearGradient(
                colors: [
                  bgColor,
                  AppColors.detailDirectionsContainerBottomColor
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
      ),
      child: Container(
        // height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
              bottom: Radius.circular(widget.colorCode == 3 ? 30 : 0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
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
              child: showContent
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.content,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : SizedBox(),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

Color containerColorFunction({required int colorCode}) {
  if (colorCode == 1) {
    return AppColors.detailSummaryContainer;
  }
  if (colorCode == 2) {
    return AppColors.detailIngredientsContainer;
  }
  if (colorCode == 3) {
    return AppColors.detailDirectionsContainer;
  }
  return AppColors.detailContentBackgroundColor;
}
