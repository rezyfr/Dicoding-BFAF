import 'package:flutter/material.dart';

class EmptyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Center(
          child: Text(
            "Error retrieving data :(",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
