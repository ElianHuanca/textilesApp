import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';

class Screen1 extends StatelessWidget {
  final List<Widget> widget;
  final String title;
  final bool isGridview;
  final FloatingActionButton? floatingActionButton;
  const Screen1(
      {required this.widget,
      super.key,
      required this.title,
      required this.isGridview,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: Text(title, style: Theme.of(context).textTheme.titleSmall),
          centerTitle: true,
          //backgroundColor: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.go('/det_venta');
                },
                icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: isGridview
            ? Container(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  children: widget,
                ),
              )
            : ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [...widget],
              ),
        floatingActionButton: floatingActionButton);
  }
}
