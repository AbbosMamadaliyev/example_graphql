import 'package:example_graphql/rick_and_morty/queries/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../episodes/episode_details_page.dart';

class CharacterDetailsPage extends StatefulWidget {
  final String id;

  const CharacterDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('details'),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(getCharacterDetails),
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
            print('character data: ${result.data!['character']}');

            final character = result.data!['character'];

            return Column(
              children: [
                SizedBox(
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('name: ${character['name']}'),
                            Text('location: ${character['location']['name']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text('episodes'),
                Expanded(
                  child: ListView.builder(
                      itemCount: character['episode'].length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EpisodeDetailsPage(
                                    id: character['episode'][index]['id'],
                                  ),
                                ),
                              );
                            },
                            child:
                                Text(character['episode'][index]['episode']));
                      }),
                )
              ],
            );
          }),
    );
  }
}
