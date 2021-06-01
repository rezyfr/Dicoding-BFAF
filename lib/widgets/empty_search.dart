import 'package:flutter/material.dart';

class EmptySearch extends StatelessWidget {
  final String query;

  EmptySearch({required this.query});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ":(",
                style: TextStyle(
                  fontSize: 150.0,
                  color: Colors.black12,
                ),
              ),
              Text(
                "No restaurant found for '$query'",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .apply(color: Colors.black26),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
