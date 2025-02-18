// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';

void dialogoDeAlerta(BuildContext context, Function onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Está seguro de que desea eliminar este elemento?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                onPressed();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }