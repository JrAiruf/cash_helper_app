import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:flutter/material.dart';

class AnnotationPage extends StatefulWidget {
  const AnnotationPage({Key? key, required this.annotationEntity}) : super(key: key);

  final AnnotationEntity annotationEntity;
  @override
  State<AnnotationPage> createState() => _AnnotationPageState();
}

class _AnnotationPageState extends State<AnnotationPage> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: height * 0.75,
              width: width,
              decoration: BoxDecoration(color: backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
