import 'package:flutter/material.dart';
import 'package:flutter_noted_app/model/noted.dart';
import 'package:flutter_noted_app/view/screen/detail_page.dart';
import 'package:flutter_noted_app/view/widget/text_box.dart';

import '../../model/helper/noted_local_db.dart';

class EditFormPage extends StatefulWidget {
  const EditFormPage({super.key, required this.noted});
  final Noted noted;

  @override
  State<EditFormPage> createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.noted.title;
    descController.text = widget.noted.description;
  }

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
          'Edit Note',
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
                onPressed: () {
                  Noted noted = widget.noted.copyWith(
                    title: titleController.text,
                    description: descController.text,
                  );
                  NotedLocalDB().updateNoted(noted);
                  titleController.clear();
                  descController.clear();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailPage(
                      noted: noted,
                    );
                  }));
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
