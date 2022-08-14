import 'package:flutter/material.dart';

class AddClubPage extends StatefulWidget {
  const AddClubPage({Key? key}) : super(key: key);

  @override
  State<AddClubPage> createState() => _AddClubPageState();
}

class _AddClubPageState extends State<AddClubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('enter new club'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              child: FlutterLogo(),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'club name'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(hintText: 'players count'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text('add'),
            ),
          ],
        ),
      ),
    );
  }
}
