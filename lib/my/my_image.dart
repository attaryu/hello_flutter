import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          'https://i.pinimg.com/736x/6c/17/04/6c170458cce1097e4ac64f6e195a928a.jpg',
          width: 150,
          height: 150,
        ),
        Image.asset('assets/images/iroha.jpg', width: 150, height: 150),
      ],
    );
  }
}
