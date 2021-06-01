import 'package:dicoding_flutter_fundamental/common/navigation.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_review_provider.dart';
import 'package:dicoding_flutter_fundamental/utils/ResultState.dart';
import 'package:dicoding_flutter_fundamental/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddReviewScreen extends StatefulWidget {
  static String routeName = '/add_review_screen';

  final String restaurantId;

  const AddReviewScreen({required this.restaurantId});

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  late TextEditingController _nameController;
  late TextEditingController _reviewController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _reviewController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "title",
                child: Text(
                  'Add Review',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .apply(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Your name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: _reviewController,
                        decoration: InputDecoration(
                          labelText: 'Your review',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            Provider.of<RestaurantReviewProvider>(context,
                                    listen: false)
                                .searchRestaurant(
                              widget.restaurantId,
                              _nameController.text,
                              _reviewController.text,
                            );
                          }
                        },
                        child: Text('Submit Review'),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<RestaurantReviewProvider>(builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return LoadingIndicator();
                } else if (state.state == ResultState.HasData) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('Success')));
                  Navigation.backWithResult("Success");
                  return Text('');
                } else {
                  return Text('');
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
