import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place.dart';
import 'package:great_places/screens/place_detail.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = '/places-list';

  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSet(),
        builder: (BuildContext ctx, AsyncSnapshot<void> snapshot) => snapshot
                    .connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (BuildContext ctx, GreatPlaces data, Widget? child) =>
                    data.nodes.isEmpty
                        ? child as Widget
                        : ListView.builder(
                            itemCount: data.nodes.length,
                            itemBuilder: (BuildContext ctx, int index) =>
                                ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(data.nodes[index].image),
                              ),
                              title: Text(data.nodes[index].title),
                              subtitle:
                                  data.nodes[index].location?.address != null
                                      ? Text(data.nodes[index].location?.address
                                          as String)
                                      : null,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: data.nodes[index].id);
                              },
                            ),
                          ),
                child: const Center(
                  child: Text(
                    'No places yet, start adding some!',
                  ),
                ),
              ),
      ),
    );
  }
}
