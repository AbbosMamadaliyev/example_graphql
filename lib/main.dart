import 'package:flutter/material.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'footbal_clubs/presentation/clubs_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final HttpLink httpLink = HttpLink(
    'https://discrete-whale-50.hasura.app/v1/graphql',
    defaultHeaders: {
      "x-hasura-admin-secret":
          "gyi06BmV0d8LQisxsvPpLH0SvNFhTAFVjKirtzVKM4h0rcpAwY70on1SiVjfTz69"
    },
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ),
  );

  runApp(
    GraphQLProvider(
      client: client,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FootballHomePage(),
    );
  }
}
