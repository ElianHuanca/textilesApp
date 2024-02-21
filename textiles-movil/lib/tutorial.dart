import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBill extends StatefulWidget {
  final String taskId;
  AddBill({Key? key, required this.taskId}) : super(key: key);

  @override
  State<AddBill> createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  final List<TextEditingController> _items = [];
  final List<TextEditingController> _quantity = [];
  final List<TextEditingController> _price = [];

  double textFieldButtonPaddin = 15,
      textFieldRounded = 10,
      inputFieldPadding = 2;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addField();
    });
  }

  _addField() {
    setState(() {
      _items.add(TextEditingController());
      _quantity.add(TextEditingController());
      _price.add(TextEditingController());
    });
  }

  _removeItem(i) {
    setState(() {
      _items.removeAt(i);
      _quantity.removeAt(i);
      _price.removeAt(i);
    });
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    FormData formData = FormData.fromMap({});

    for (int i = 0; i < _items.length; i++) {
      formData.fields.addAll([
        MapEntry('items[$i]', _items[i].text),
        MapEntry('quantities[$i]', _quantity[i].text),
        MapEntry('prices[$i]', _price[i].text),
      ]);
    }
    /* networkRequest(
      context: context,
      requestType: 'post',
      url: "${Urls.billAdd}${widget.taskId}?jhhihu",
      data: formData,
      action:(r){
        Navigator.pop(context);
      }
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bill Items'),
        backgroundColor: Colors.deepOrange, //ColorConstants.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _addField();
                  },
                  child: const Icon(
                    Icons.add_circle,
                    color: Colors.deepOrange,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  for (int i = 0; i < _items.length; i++)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _removeItem(i);
                              },
                              child: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.all(inputFieldPadding),
                                child: TextFormField(
                                  controller: _items[i],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter item';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: const Text('title'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          textFieldRounded),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(inputFieldPadding),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _quantity[i],
                                  validator: (value) {
                                    if (value!.isEmpty || value == '0') {
                                      return 'Please enter quantity';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: const Text('quantity'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          textFieldRounded),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(inputFieldPadding),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _price[i],
                                  validator: (value) {
                                    if (value!.isEmpty || value == '0') {
                                      return 'Please enter price';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: const Text('price'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          textFieldRounded),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        )
                      ],
                    )
                ],
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                //borderRadius: BorderRadius.circular(Adaptive.px(10)),
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.deepOrange,
              onPressed: () {
                _submit();
              },
              child: Padding(
                padding: EdgeInsets.all(textFieldButtonPaddin),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SizedBox(width: Adaptive.px(10)),
                    SizedBox(width: 10),
                    Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20//.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
