import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../queries/queries.dart';
import 'character_details_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('all characters'),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(getAllCharacters),
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

            final int charactersResponse =
                result.data!['characters']['info']['next'];

            FetchMoreOptions fetchMoreCharacters = FetchMoreOptions(
                variables: {'next': charactersResponse},
                updateQuery: (previousResultData, fetchMoreResultData) {
                  final List<dynamic> locales = [
                    ...previousResultData!['characters']['results']
                        as List<dynamic>,
                    ...fetchMoreResultData!['characters']['results']
                        as List<dynamic>
                  ];

                  fetchMoreResultData['characters']['results'] = locales;

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
                itemCount: result.data!['characters']['results'].length,
                itemBuilder: (context, index) {
                  final character =
                      result.data!['characters']['results'][index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CharacterDetailsPage(
                                id: character['id'],
                              )));
                    },
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            child: Image.network(character['image']),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('name: ${character['name']}'),
                              // Text('location: ${character['location']['name']}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
