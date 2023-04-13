import 'package:flutter/material.dart';

class CreateAnnotationsPage extends StatefulWidget {
  const CreateAnnotationsPage({super.key});

  @override
  State<CreateAnnotationsPage> createState() => _CreateAnnotationsPageState();
}

class _CreateAnnotationsPageState extends State<CreateAnnotationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text("Create Annotations Page"),
        ),
      ),
    );
  }
}
