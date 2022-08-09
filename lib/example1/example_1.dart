import 'package:example_graphql/example1/product_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../costants.dart';

class Example1 extends StatefulWidget {
  const Example1({Key? key}) : super(key: key);

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  final gQuery = r"""
                  query GetProducts 
                    {
                      products(first: 22, channel: "default-channel") {
                        edges {
                          node {
                            id
                            name
                            description
                          }
                        }
                      }
                    }
                  """;

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      kDemoSaleorIoUrl,
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
          title: const Text('test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Query(
            options: QueryOptions(
              document: gql(gQuery),
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

              print('result data: ${result.data}');

              final data = ProductModel.fromJson(result.data!);

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
                        itemCount: data.products.edges.length,
                        itemBuilder: (context, index) {
                          print('ddsd: ${result.data}');

                          return Text(
                              '${index + 1}:  ${data.products.edges[index].node.name}');
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
