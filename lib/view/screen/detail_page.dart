import 'package:flutter/material.dart';
import 'package:flutter_noted_app/model/noted.dart';
import 'package:flutter_noted_app/view/screen/home_page.dart';
import 'package:intl/intl.dart';

import '../../model/helper/noted_local_db.dart';
import 'edit_form_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.noted});

  final Noted noted;

  @override
  Widget build(BuildContext context) {
    String getCurrentDate({required String date}) {
      final parse = DateTime.parse(date);
      final formatter = DateFormat('dd MMMM yyyy');
      return formatter.format(parse);
    }

    String getCurrentTimes({required String date}) {
      final parse = DateTime.parse(date);
      final formatter = DateFormat('HH:mm');
      return formatter.format(parse);
    }

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.access_alarm_rounded,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        getCurrentTimes(date: noted.createdTime.toString()),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        getCurrentDate(date: noted.createdTime.toString()),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  noted.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  noted.description,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditFormPage(
                    noted: noted,
                  );
                }));
              },
              child: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            FloatingActionButton(
              onPressed: () async {
                if (noted.id != null) {
                  await NotedLocalDB().deleteNoted(noted.id!);
                }
                if (context.mounted) {
                  Navigator.of(context).push(_createRoute());
                }
              },
              child: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
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
