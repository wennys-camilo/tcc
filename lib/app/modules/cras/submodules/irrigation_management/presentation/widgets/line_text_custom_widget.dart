import 'package:flutter/material.dart';

class LineTextCustomWidget extends StatelessWidget {
  final String text;
  const LineTextCustomWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              thickness: 2.5,
              color: Color(0xff97c93d),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xff97c93d),
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Divider(
                thickness: 2.5,
                color: Color(0xff97c93d),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
