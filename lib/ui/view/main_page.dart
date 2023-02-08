import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/store.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

// final httpsUri = Uri(
//     scheme: 'https',
//     host: 'dart.dev',
//     path: 'guides/libraries/library-tour',
//     fragment: 'numbers');
// print(httpsUri); // https://dart.dev/guides/libraries/library-tour#numbers
//
// final mailtoUri = Uri(
//     scheme: 'mailto',
//     path: 'John.Doe@example.com',
//     queryParameters: {'subject': 'Example'});
class _MainPageState extends State<MainPage> {
  Future<void> fetchData() async {
    var url = Uri(
        scheme: 'https',
        host: 'gist.githubusercontent.com',
        path:
            'junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');

    var response = await http.get(url);
    final jsonResult = jsonDecode(response.body);
    stores.clear();
    final jsonStores = jsonResult['stores'];
    jsonStores.forEach((e) {
      stores.add(Store.fromJson(e));
    });
  }

  List<Store> stores = <Store>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마스크 재고 있는곳 : 0곳'),
        actions: [
          IconButton(
              onPressed: () async {
                await fetchData();
                if (stores != null) {
                  print(stores[1]);
                }
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: ListView(
        children: [],
      ),
    );
  }
  // ListTile listtile() {
  //   return ListTile(
  //     title: Text( stores. ),
  //   );
}
