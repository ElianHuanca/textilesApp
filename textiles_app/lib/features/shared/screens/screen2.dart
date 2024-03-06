import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Screen2 extends StatelessWidget {
  final String title;
  final String subtitle;
  //final String route;
  final DataTable dataTable;
  const Screen2(
      {super.key,
      required this.title,
      required this.subtitle,
      //required this.route,
      required this.dataTable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: EdgeInsets.zero, children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,          
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              title: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white)),
              subtitle: Text(subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white70)),
              trailing: SizedBox(
                width: 56,
                height: 56,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: 4,
                  onPressed: () {
                    context.push('/det_venta');
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [dataTable, const SizedBox(height: 20)],
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
