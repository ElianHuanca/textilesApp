import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';

class Screen1 extends StatelessWidget {
  final List<Widget> widget;
  final String title;
  final bool isGridview;
  final FloatingActionButton? floatingActionButton;
  final bool backRoute;
  final Function? onTap;
  const Screen1(
      {required this.widget,
      super.key,
      required this.title,
      required this.isGridview,
      this.floatingActionButton,
      required this.backRoute,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          drawer: backRoute ? null : SideMenu() ,
          appBar: AppBar(
            leading: backRoute
                ? BackButton(
                    onPressed: () {                                         
                      context.pop();
                    },
                  )
                : null,
            title: Text(title, style: Theme.of(context).textTheme.titleSmall),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            actions: [
              onTap != null
                  ? IconButton(
                      onPressed: () => onTap!(), icon: const Icon(Icons.add))
                  : const SizedBox(),
            ],
          ),
          body: isGridview
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    children: widget,
                  ),
                )
              : ListView(
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  children: [...widget],
                ),
          floatingActionButton: floatingActionButton),
    );
  }
}
