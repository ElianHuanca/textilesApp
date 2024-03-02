import 'package:flutter/material.dart';
import 'package:textiles_app/features/shared/screens/screen1.dart';

class DetVentasForm extends StatelessWidget {
  const DetVentasForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen1(
      widget: _widget(context),
      title: 'Registro de Ventas',
      isGridview: false,
    );
  }

  List<Widget> _widget(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
          ],
        ),
      ),
      _button(context, 'Guardar'),
    ];
  }

  MaterialButton _button(BuildContext context, String texto) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).primaryColor,
      onPressed: () => {},
      child: Padding(
        padding:const EdgeInsets.all(15),
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
