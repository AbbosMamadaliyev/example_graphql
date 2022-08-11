import 'package:example_graphql/rick_and_morty/queries/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../characters/character_details_page.dart';

class LocationDetailsPage extends StatefulWidget {
  final String id;

  const LocationDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<LocationDetailsPage> createState() => _LocationDetailsPageState();
}

class _LocationDetailsPageState extends State<LocationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('location details'),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(getLocationDetails),
            variables: {"id": widget.id},
          ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Center(
                child: Text(result.exception.toString()),
              );
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            print('location details data: ${result.data!['location']}');

            final location = result.data!['location'];

            return Column(
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('name: ${location['name']}'),
                      Text('type: ${location['type']}'),
                      Text('created: ${location['created']}'),
                    ],
                  ),
                ),
                const Text('Residents'),
                Expanded(
                  child: ListView.builder(
                      itemCount: location['residents'].length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CharacterDetailsPage(
                                  id: location['residents'][index]['id'],
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 150,
                                width: 100,
                                margin: EdgeInsets.symmetric(horizontal: 24),
                                child: Image.network(
                                    location['residents'][index]['image']),
                              ),
                              Expanded(
                                  child: Text(
                                      location['residents'][index]['name'])),
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          }),
    );
  }
}
