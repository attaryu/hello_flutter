import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  const MyInput({super.key});

  @override
  State<MyInput> createState() => _MyWidgetInput();
}

class _MyWidgetInput extends State<MyInput> {
  final TextEditingController _textFieldController = TextEditingController();
  bool _isLightOn = false;
  bool? _isAgreed = false;
  String? _language;

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            children: [
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  hintText: 'Write your name here...',
                  labelText: 'Your name',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text('Hello, ${_textFieldController.text}!'),
                    ),
                  ).whenComplete(() => _textFieldController.clear());
                },
                child: Text('Submit'),
              ),
            ],
          ),
          Switch(
            value: _isLightOn,
            onChanged: (value) {
              setState(() => _isLightOn = value);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isLightOn ? 'Really bright!' : 'Really dark...',
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          RadioGroup(
            groupValue: _language,
            onChanged: (value) {
              setState(() => _language = value);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$_language is selected'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: Column(
              children: [
                ListTile(
                  leading: Radio(value: 'Dart'),
                  title: Text('Dart'),
                ),
                ListTile(
                  leading: Radio(value: 'Kotlin'),
                  title: Text('Kotlin'),
                ),
                ListTile(
                  leading: Radio(value: 'Swift'),
                  title: Text('Swift'),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: _isAgreed,
              onChanged: (value) => setState(() => _isAgreed = value),
            ),
            title: Text('Agree/Disagree'),
          ),
        ],
      ),
    );
  }
}
