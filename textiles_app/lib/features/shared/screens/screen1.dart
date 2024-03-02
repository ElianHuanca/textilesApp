import 'package:flutter/material.dart';
import 'package:textiles_app/features/shared/shared.dart';

class Screen1 extends StatelessWidget {
  final List<Widget> widget;
  final String title;
  final bool isGridview;
  const Screen1(
      {required this.widget,
      super.key,
      required this.title,
      required this.isGridview});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          //backgroundColor: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: Container(
            /* color: Colors.white,
            constraints: const BoxConstraints.expand(), */
            padding: const EdgeInsets.all(30),
            child: isGridview
                ? GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 30,
                    children: widget,
                  )
                : ListView(
                    //padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ...widget
                    ],
                  )));
  }
}
