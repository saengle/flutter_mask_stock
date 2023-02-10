import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/stores.dart';


class StoreRepository {
  var isLoading = false;


  Future<List<Stores>> fetchData() async {
    List<Stores> stores = <Stores>[];
    // setState(() {
    //   isLoading = true;
    // });

    var url = Uri(
        scheme: 'https',
        host: 'gist.githubusercontent.com',
        path:
            'junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');

    var response = await http.get(url);
    final jsonResult = jsonDecode(response.body);
    // setState(() {

      final jsonStores = jsonResult['stores'];
      jsonStores.forEach((e) {
        stores.add(Stores.fromJson(e));
      });
    // });
    // setState(() {
    //   isLoading = false;
    // });
    return stores;
  }
}
