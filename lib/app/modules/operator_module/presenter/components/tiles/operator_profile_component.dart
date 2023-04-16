import 'package:flutter/material.dart';

class OperatorProfileComponent extends StatelessWidget {
  const OperatorProfileComponent({
    super.key,
    this.height,
    this.width,
    this.title,
    this.content,
    this.backgroundColor,
  });

  final double? height;
  final double? width;
  final String? title;
  final String? content;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        height: height! * 0.04,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                content ?? "",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
