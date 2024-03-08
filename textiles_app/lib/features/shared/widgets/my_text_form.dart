import 'package:flutter/material.dart';

class MiTextField extends StatelessWidget {
  final int? flex;
  final String label;
  final String value;
  final Function(String)? onChanged;
  final String? errorMessage;
  final TextEditingController? controller;

  const MiTextField(
      {Key? key,
      required this.label,
      required this.value,
      required this.onChanged,
      this.errorMessage,
      this.controller,
      this.flex
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final TextEditingController controller=TextEditingController(text: value);
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            onTap: () {
              controller?.clear();
            },
            decoration: InputDecoration(
              label: Text(label),
              errorText: errorMessage,
              suffixText: label == 'Precio' ? 'Bs' : 'mts',
              suffixStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
      ),
    );
  }
}
