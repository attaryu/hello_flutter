import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: Text('A elevated button')),
          TextButton(onPressed: () {}, child: Text('A text button')),
          OutlinedButton(onPressed: () {}, child: Text('A outlined button')),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info),
            tooltip: 'An icon button',
          ),
          MyDropdownButton(),
        ],
      ),
    );
  }
}

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String? language;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        DropdownMenuItem<String>(value: 'Dart', child: Text('Dart')),
        DropdownMenuItem<String>(value: 'Kotlin', child: Text('Kotlin')),
        DropdownMenuItem<String>(value: 'Swift', child: Text('Swift')),
      ],
      value: language,
      hint: Text('A dropdown button'),
      onChanged: (String? value) => setState(() => language = value.toString()),
    );
  }
}
