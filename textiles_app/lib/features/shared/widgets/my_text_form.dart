import 'package:flutter/material.dart';

class MiTextField extends StatelessWidget {
  final int? flex;
  final String label;
  final String? initialValue;
  final Function(String)? onChanged;
  final String? errorMessage;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const MiTextField(
      {Key? key,
      required this.label,
      this.initialValue,
      required this.onChanged,
      this.errorMessage,
      this.controller,
      this.flex,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
            initialValue: initialValue ?? '',
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            onChanged: onChanged,
            //onTap: () => controller?.clear(),
            /* validator: (initialValue) =>
                controller!.text.isEmpty ? 'Campo Requerido' : null, */
            decoration: InputDecoration(
              label: Text(label),
              //errorText: errorMessage,
              suffixText: label == 'Cantidad'
                  ? ' mts'
                  : (label.contains('Precio') ? ' Bs' : ''),
              suffixStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
      ),
    );
  }
}
/* isela@gmail.com
Huanca1962 */