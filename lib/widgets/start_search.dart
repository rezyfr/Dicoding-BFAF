import 'package:flutter/material.dart';

class StartSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.view_list_rounded,
                size: 150.0,
                color: Colors.black12,
              ),
              Text(
                "Find restaurants by typing its name on the search column",
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
