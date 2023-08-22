import 'package:flutter/material.dart';

import 'annotation_informations_card.dart';

class AnnotationsStatusCardComponent extends StatelessWidget {
  const AnnotationsStatusCardComponent({
    super.key,
    this.height,
    this.width,
    this.title,
    this.content,
    this.backgroundColor,
    this.borderColor,
    this.items,
  });

  final double? height;
  final double? width;
  final String? title;
  final String? content;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<Widget>? items;

  @override
  Widget build(BuildContext context) {
    final fontSize = Theme.of(context).textTheme.bodySmall;
    return Container(
      height: height ?? 10,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.white),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Anotações semanais:", style: fontSize),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "0",
                style: fontSize,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnnotationInformationsCard(
                  backgroundColor: backgroundColor,
                  height: height! * 0.35,
                  width: width! * 0.42,
                  items: [
                    Text(
                      "Dinheiro:",
                      style: fontSize,
                    ),
                    Text(
                      "25%",
                      style: fontSize,
                    ),
                  ],
                ),
                AnnotationInformationsCard(
                  backgroundColor: backgroundColor,
                  height: height! * 0.35,
                  width: width! * 0.42,
                  items: [
                    Text(
                      "Dinheiro:",
                      style: fontSize,
                    ),
                    Text(
                      "25%",
                      style: fontSize,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height! * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnnotationInformationsCard(
                  backgroundColor: backgroundColor,
                  height: height! * 0.35,
                  width: width! * 0.42,
                  items: [
                    Text(
                      "Dinheiro:",
                      style: fontSize,
                    ),
                    Text(
                      "25%",
                      style: fontSize,
                    ),
                  ],
                ),
                AnnotationInformationsCard(
                  backgroundColor: backgroundColor,
                  height: height! * 0.35,
                  width: width! * 0.42,
                  items: [
                    Text(
                      "Dinheiro:",
                      style: fontSize,
                    ),
                    Text(
                      "25%",
                      style: fontSize,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
