import 'package:example_graphql/rick_and_morty/queries/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../characters/character_details_page.dart';

class EpisodeDetailsPage extends StatefulWidget {
  final String id;

  const EpisodeDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EpisodeDetailsPage> createState() => _EpisodeDetailsPageState();
}

class _EpisodeDetailsPageState extends State<EpisodeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('episode details'),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(getEpisodeDetails),
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
            print('episode data: ${result.data!['episode']}');

            final episode = result.data!['episode'];

            return Column(
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('name: ${episode['name']}'),
                      Text('episode: ${episode['episode']}'),
                    ],
                  ),
                ),
                const Text('Characters'),
                Expanded(
                  child: ListView.builder(
                      itemCount: episode['characters'].length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CharacterDetailsPage(
                                  id: episode['characters'][index]['id'],
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
                                    episode['characters'][index]['image']),
                              ),
                              Expanded(
                                  child: Text(
                                      episode['characters'][index]['name'])),
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
