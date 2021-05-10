import 'package:dicoding_flutter_fundamental/model/restaurant.dart';
import 'package:dicoding_flutter_fundamental/model/restaurants.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

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
        final List<Restaurants> restaurants = snapshot.data;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(context, restaurants[index]);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurants restaurant) {
    return ListTile(
      leading: Hero(
        tag: restaurant.pictureId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            restaurant.pictureId,
            width: 125,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        restaurant.name,
      ),
      onTap: () {},
      subtitle: Column(
        children: [
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
                        .caption
                        .apply(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
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
                        .caption
                        .apply(color: Colors.black54),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
