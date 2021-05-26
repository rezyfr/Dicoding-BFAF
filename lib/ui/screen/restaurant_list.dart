import 'package:dicoding_flutter_fundamental/model/restaurant.dart';
import 'package:dicoding_flutter_fundamental/model/restaurants.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../styles.dart';

class RestaurantList extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    Future<String> _loadAsset(BuildContext context) async {
      return await DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json');
    }

    Future<List<Restaurants>> _loadRestaurants(BuildContext context) async {
      String jsonString = await _loadAsset(context);
      return parseLocal(jsonString).restaurants;
    }

    return FutureBuilder(
      future: _loadRestaurants(context),
      builder: (context, snapshot) {
        final List<Restaurants> restaurants =
            snapshot.data as List<Restaurants>;
        if (restaurants.isEmpty) {
          return _buildEmptyItem(context);
        } else {
          return _buildRestaurantItem(context, restaurants);
        }
      },
    );
  }

  Widget _buildRestaurantItem(
      BuildContext context, List<Restaurants> restaurants) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeName,
                    arguments: restaurant);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    Hero(
                      tag: restaurant.pictureId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: restaurant.pictureId,
                          height: 100,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
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
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: primaryColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        "${restaurant.rating}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .apply(color: Colors.black54),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: restaurants.length,
        ),
      ),
    );
  }

  Widget _buildEmptyItem(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
