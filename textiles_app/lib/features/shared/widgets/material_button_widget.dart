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
      case 'Guardando...':
        color = Colors.grey;
        break;
      case 'Eliminar':
        color = Colors.red;
        break;
      default:
        color = Colors.black;
    }
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: color, //Theme.of(context).primaryColor,
      onPressed: () => ontap(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Text(
              texto,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
