import 'package:example_graphql/main.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'costants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      kHasuraParseUrl,
      defaultHeaders: {
        'X-Parse-Application-Id': kParseApplicationId,
        'X-Parse-Client-Key': kParseClientKey,
        'x-hasura-admin-secret':
            'gyi06BmV0d8LQisxsvPpLH0SvNFhTAFVjKirtzVKM4h0rcpAwY70on1SiVjfTz69',
      },
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Query(
            options: QueryOptions(
              document: gql(
                r"""
                    query{
                      continents{
                        name
                        code
                      }
                    }
                  """,
              ),
            ),
            builder: (QueryResult result, {fetchMore, refetch}) {
              print('ddsd: ${result.data}');

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('ontap'),
                        onPressed: () {
                          // insert;
                        },
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: result.data!['continents'].length,
                        itemBuilder: (context, index) {
                          print('ddsd: ${result.data}');

                          return Text(
                              result.data!['continents'][index]['name']);
                        })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
