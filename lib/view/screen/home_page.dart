import 'dart:async';

import 'package:flutter/material.dart';

import '../../model/helper/noted_local_db.dart';
import '../../model/noted.dart';
import '../widget/list_widget.dart';
import 'add_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Noted> notedList = [];
  bool isLoading = false;

  Future<void> getAllNote() async {
    setState(() {
      isLoading = true;
    });
    notedList = await NotedLocalDB().getAllNoted();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAllNote();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Noted App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notedList.length,
              itemBuilder: (context, index) {
                final Noted noted = notedList[index];
                return ListWidget(
                  index: index,
                  noted: noted,
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(_createRoute());
          getAllNote();
        },
        child: const Icon(
          Icons.add_rounded,
          size: 36,
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) =>
        const AddFormPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
