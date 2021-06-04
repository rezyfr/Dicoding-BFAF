import 'package:dicoding_flutter_fundamental/api/api_service.dart';
import 'package:dicoding_flutter_fundamental/common/navigation.dart';
import 'package:dicoding_flutter_fundamental/common/styles.dart';
import 'package:dicoding_flutter_fundamental/data/model/category.dart';
import 'package:dicoding_flutter_fundamental/data/model/customer_review.dart';
import 'package:dicoding_flutter_fundamental/data/model/drink.dart';
import 'package:dicoding_flutter_fundamental/data/model/food.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_detail.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_detail_provider.dart';
import 'package:dicoding_flutter_fundamental/provider/restaurant_review_provider.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/add_review_screen.dart';
import 'package:dicoding_flutter_fundamental/utils/ResultState.dart';
import 'package:dicoding_flutter_fundamental/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static var routeName = '/detail_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return LoadingIndicator();
              } else if (state.state == ResultState.HasData) {
                return _buildDetailScreen(context, state.result.restaurant);
              } else if (state.state == ResultState.Error) {
                return Center(
                  child: Text(
                    state.message,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              } else {
                return Center(
                  child: Text(''),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailScreen(BuildContext context, RestaurantDetail restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextButton(
                    onPressed: () =>
                        {_navigateWithResult(context, restaurant.id)},
                    child: Text('Add review'),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildCategoryPills(context, restaurant.categories),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      size: 12,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        restaurant.city,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .apply(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  "Description",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  restaurant.description,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  "Menu",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 10,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return MenuList.food(
                                foods: restaurant.menus.foods,
                              );
                            },
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('images/food.jpeg'),
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.srcOver,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "Food",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .apply(color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    // "${restaurant.menus?.foods.length} menus",
                                    "menus",
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline!
                                        .apply(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 10,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return MenuList.drink(
                                    drinks: restaurant.menus.drinks);
                              });
                        },
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('images/drink.jpg'),
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.srcOver,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "Drink",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .apply(color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    // "${restaurant.menus?.drinks.length} menus",
                                    "menus",
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline!
                                        .apply(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Restaurant Review",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    _buildReviewList(context, restaurant.customerReviews)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateWithResult(context, restaurantId) async {
    final result = await Navigator.pushNamed(
      context,
      AddReviewScreen.routeName,
      arguments: restaurantId,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  Widget _buildCategoryPills(BuildContext context, List<Category> categories) {
    return Container(
      height: 24,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: secondaryColor,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    category.name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }

  Widget _buildReviewList(BuildContext context, List<CustomerReview> reviews) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(review.date,
                              style: Theme.of(context).textTheme.overline),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        child: Text(review.review ?? "",
                            style: Theme.of(context).textTheme.caption),
                      ),
                    ],
                  ),
                );
              },
              itemCount: reviews.length,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  final List<Foods>? foods;
  final List<Drinks>? drinks;

  MenuList.food({required this.foods, this.drinks});

  MenuList.drink({required this.drinks, this.foods});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = foods?[index] ?? drinks?[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(
            foods != null ? (item as Foods).name : (item as Drinks).name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
      },
      itemCount: foods?.length ?? drinks?.length,
    );
  }
}
