import 'package:flutter/material.dart';

import 'example1/example_1.dart';
import 'my_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: const Example1(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart' as build;
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
//
// import 'costants.dart';
// import 'my_home_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await build.Parse().initialize(
//     kParseApplicationId,
//     kParseServerUrl,
//     clientKey: kParseClientKey,
//     autoSendSessionId: true,
//   );
//   final List<int> list = [2, 3, 4];
//
//   var firstObject = build.ParseObject('FirstClass')
//     ..set('message', ' list array')
//     ..set('message_count', 33)
//     ..set('dateTime', DateTime.now())
//     ..set('lastLocation', build.ParseGeoPoint(latitude: 23.3, longitude: 34.4))
//     ..set(
//       'objects',
//       {
//         "name": "abbos",
//         "age": "25",
//       },
//     )
//     ..set('dataArray', list);
//
//   await firstObject.save();
//
//   print('done');
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// final HttpLink httpLink = HttpLink(
//   kParseServerUrl,
//   defaultHeaders: {
//     'X-Parse-Application-Id': kParseApplicationId,
//     'X-Parse-Client-Key': kParseClientKey,
//   },
// );
// //
// // ValueNotifier<GraphQLClient> client = ValueNotifier(
// //   GraphQLClient(
// //     cache: GraphQLCache(dataIdFromObject: typenameDataIdFromObject),
// //     link: httpLink,
// //   ),
// // );
//
// Future<List<build.ParseObject>> getClasses() async {
//   build.QueryBuilder<build.ParseObject> queryClasses =
//       build.QueryBuilder<ParseObject>(ParseObject('FirstClass'));
//
//   final build.ParseResponse response = await queryClasses.query();
//
//   if (response.success && response.results != null) {
//     return response.results as List<build.ParseObject>;
//   } else {
//     return [];
//   }
// }
