import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/store.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = false;

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    var url = Uri(
        scheme: 'https',
        host: 'gist.githubusercontent.com',
        path:
            'junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');

    var response = await http.get(url);
    final jsonResult = jsonDecode(response.body);
    setState(() {
      stores.clear();
      final jsonStores = jsonResult['stores'];
      jsonStores.forEach((e) {
        stores.add(Stores.fromJson(e));
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<Stores> stores = <Stores>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는곳 : ${stores.length}곳'),
        actions: [
          IconButton(
              onPressed: () {
                fetchData();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: isLoading
          ? loadingWidget()
          : ListView(
              children: stores.map((e) {
                return ListTile(
                  title: Text(e.name.toString()),
                  subtitle: Text(e.addr.toString()),
                  trailing: Text(e.remainStat ?? '매진'),
                );
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
