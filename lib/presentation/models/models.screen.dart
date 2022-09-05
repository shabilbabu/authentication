import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/models.controller.dart';

class ModelsScreen extends GetView<ModelsController> {
  const ModelsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ModelsScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ModelsScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
