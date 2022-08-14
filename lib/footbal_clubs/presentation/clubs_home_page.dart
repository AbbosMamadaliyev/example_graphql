import 'package:example_graphql/footbal_clubs/presentation/add_club_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FootballHomePage extends StatefulWidget {
  const FootballHomePage({Key? key}) : super(key: key);

  @override
  State<FootballHomePage> createState() => _FootballHomePageState();
}

class _FootballHomePageState extends State<FootballHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('all clubs'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddClubPage(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Query(
          options: QueryOptions(
            document: gql(
              """
              query getClubs{
                    clubs{
                      id
                      name
                      player_count
                      image_url
                    }
                  }
            """,
            ),
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

            print('data: ${result.data}');

            return ListView.builder(
                itemCount: result.data!['clubs'].length,
                itemBuilder: (context, index) {
                  final club = result.data!['clubs'][index];

                  return InkWell(
                    onTap: () {},
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            height: 150,
                            width: 120,
                            padding: EdgeInsets.all(12),
                            child: Image.network(
                              club['image_url'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  club['name'],
                                  style: TextStyle(fontSize: 16),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
