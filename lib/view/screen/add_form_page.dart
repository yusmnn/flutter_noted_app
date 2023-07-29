import 'package:flutter/material.dart';
import 'package:flutter_noted_app/model/noted.dart';
import 'package:flutter_noted_app/view/widget/text_box.dart';

import '../../model/helper/noted_local_db.dart';

class AddFormPage extends StatefulWidget {
  const AddFormPage({super.key});

  @override
  State<AddFormPage> createState() => _AddFormPageState();
}

class _AddFormPageState extends State<AddFormPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Add Note',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextBox(
                controller: titleController,
                labelText: 'Title',
                maxLines: 2,
                maxLength: 80,
              ),
              const SizedBox(height: 24),
              TextBox(
                controller: descController,
                labelText: 'Description',
                maxLines: 7,
                maxLength: 300,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width, 44),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Noted noted = Noted(
                      title: titleController.text,
                      description: descController.text,
                      createdTime: DateTime.now(),
                    );
                    NotedLocalDB().insertNoted(noted);
                    titleController.clear();
                    descController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
