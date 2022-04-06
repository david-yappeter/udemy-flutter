import 'package:flutter/material.dart';
import 'package:great_places/helpers/custom_route.dart';
import 'package:great_places/screens/add_place.dart';
import 'package:great_places/screens/place_detail.dart';
import 'package:provider/provider.dart';
import 'package:great_places/screens/places_list.dart';
import 'package:great_places/providers/great_places.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext ctx) => GreatPlaces(),
        ),
      ],
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            colorScheme: const ColorScheme.light().copyWith(
              secondary: Colors.amber,
            ),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            )),
        initialRoute: PlacesListScreen.routeName,
        routes: {
          // HomeScreen.routeName: (BuildContext ctx) => const HomeScreen(),
          PlacesListScreen.routeName: (BuildContext ctx) =>
              const PlacesListScreen(),
          AddPlaceScreen.routeName: (BuildContext ctx) =>
              const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (BuildContext ctx) =>
              const PlaceDetailScreen(),
        },
      ),
    );
  }
}
