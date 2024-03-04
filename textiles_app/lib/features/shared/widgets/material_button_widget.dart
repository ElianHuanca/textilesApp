import 'package:flutter/material.dart';

class MaterialButtonWidget extends StatelessWidget {
  final Function ontap;
  final String texto;
  const MaterialButtonWidget(
      {required this.ontap, required this.texto, super.key});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (texto) {
      case 'Guardar':
        color = Colors.green;
        break;
      case 'Modificar':
        color = Colors.blue;
        break;
      default:
        color = Colors.red;
    }
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).primaryColor,
      onPressed: () => ontap(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Text(
              texto,
              style: TextStyle(color: color, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
