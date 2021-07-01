import 'package:dicoding_flutter_fundamental/common/navigation.dart';
import 'package:dicoding_flutter_fundamental/common/styles.dart';
import 'package:dicoding_flutter_fundamental/data/model/restaurant_list.dart';
import 'package:dicoding_flutter_fundamental/ui/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantItem extends StatelessWidget {
  final List<RestaurantList> restaurantList;

  RestaurantItem({
    required this.restaurantList,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final restaurant = restaurantList[index];
            return InkWell(
              onTap: () {
                Navigation.intentWithData(
                    DetailScreen.routeName, restaurant.id);
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
                          image:
                              "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
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
          itemCount: restaurantList.length,
        ),
      ),
    );
  }
}
