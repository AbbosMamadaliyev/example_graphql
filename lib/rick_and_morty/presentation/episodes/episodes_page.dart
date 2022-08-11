import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../queries/queries.dart';
import '../characters/character_details_page.dart';
import 'episode_details_page.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({Key? key}) : super(key: key);

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('all episodes'),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(getAllEpisodes),
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

            final int episodeResponse =
                result.data!['episodes']['info']['next'];

            FetchMoreOptions fetchMoreCharacters = FetchMoreOptions(
                variables: {'next': episodeResponse},
                updateQuery: (previousResultData, fetchMoreResultData) {
                  final List<dynamic> locales = [
                    ...previousResultData!['episodes']['results']
                        as List<dynamic>,
                    ...fetchMoreResultData!['episodes']['results']
                        as List<dynamic>
                  ];

                  fetchMoreResultData['episodes']['results'] = locales;

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
                itemCount: result.data!['episodes']['results'].length,
                itemBuilder: (context, index) {
                  final episode = result.data!['episodes']['results'][index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EpisodeDetailsPage(
                            id: episode['id'],
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
                          Text('${index + 1}. name: ${episode['name']}'),
                          Text('episode: ${episode['episode']}'),
                          // Text('location: ${character['location']['name']}'),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
