import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'costants.dart';
import 'my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(
    kParseApplicationId,
    kParseServerUrl,
    clientKey: kParseClientKey,
    autoSendSessionId: true,
  );
  final List<int> list = [2, 3, 4];

  var firstObject = ParseObject('FirstClass')
    ..set('message', ' list array')
    ..set('message_count', 33)
    ..set('dateTime', DateTime.now())
    ..set('dataArray', list);

  await firstObject.save();

  print('done');
  runApp(const MyApp());
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
      home: const MyHomePage(),
    );
  }
}

final HttpLink httpLink = HttpLink(
  kParseServerUrl,
  defaultHeaders: {
    'X-Parse-Application-Id': kParseApplicationId,
    'X-Parse-Client-Key': kParseClientKey,
  },
);
//
// ValueNotifier<GraphQLClient> client = ValueNotifier(
//   GraphQLClient(
//     cache: GraphQLCache(dataIdFromObject: typenameDataIdFromObject),
//     link: httpLink,
//   ),
// );
