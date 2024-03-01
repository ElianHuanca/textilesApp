import 'package:flutter/material.dart';

class ItemDashboard extends StatelessWidget {
  final String title;
  final IconData iconData;
  //final Color background;
  final Function onTap;

  const ItemDashboard({super.key, required this.title, required this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => onTap(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
