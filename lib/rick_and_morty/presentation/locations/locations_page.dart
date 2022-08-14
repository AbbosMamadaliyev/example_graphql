import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../queries/queries.dart';
import 'location_details_page.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('all locations'),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(getAllLocations),
            variables: {"page": 1},
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

            final int locationsResponse =
                result.data!['locations']['info']['next'];

            FetchMoreOptions fetchMoreCharacters = FetchMoreOptions(
                variables: {'next': locationsResponse},
                updateQuery: (previousResultData, fetchMoreResultData) {
                  final List<dynamic> locales = [
                    ...previousResultData!['locations']['results']
                        as List<dynamic>,
                    ...fetchMoreResultData!['locations']['results']
                        as List<dynamic>
                  ];

                  fetchMoreResultData['locations']['results'] = locales;

                  return fetchMoreResultData;
                });

            _scrollController.addListener(() {
              if (_scrollController.position.maxScrollExtent ==
                  _scrollController.position.pixels) {
                if (!isLoading) {
                  // isLoading = !isLoading;
                  fetchMore!(fetchMoreCharacters);
                }
              }
            });

            return ListView.builder(
                controller: _scrollController,
                itemCount: result.data!['locations']['results'].length,
                itemBuilder: (context, index) {
                  final location = result.data!['locations']['results'][index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LocationDetailsPage(
                            id: location['id'],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${index + 1}. name: ${location['name']}'),
                          Text('type: ${location['type']}'),
                          Text('dimension: ${location['dimension']}'),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
