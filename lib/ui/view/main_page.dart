import 'package:flutter/material.dart';
import 'package:flutter_mask_app/repository/store_repository.dart';


import '../../model/stores.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var _stores = <Stores>[];
  final storeRepository = StoreRepository();


  @override
  void initState() {
    super.initState();
    storeRepository.fetchData().then((stores) {
      setState(() {
        _stores = stores;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는곳 : ${_stores.where((e) {
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few';
        }).length}곳'),
        actions: [
          IconButton(
              onPressed: () {
                storeRepository.fetchData().then((stores) {
                  setState(() {
                    _stores = stores;
                  });
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: storeRepository.isLoading
          ? loadingWidget()
          : ListView(
              children: _stores.where((e) {
                return e.remainStat == 'plenty' ||
                    e.remainStat == 'some' ||
                    e.remainStat == 'few';
              }).map((e) {
                return ListTile(
                  title: Text(e.name.toString()),
                  subtitle: Text(e.addr.toString()),
                  trailing: _buildRemainStatWidget(e),
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

  Widget _buildRemainStatWidget(Stores stores) {
    String remainStat = '판매중지';
    String description = '판매중지';
    var color = Colors.black;
    switch (stores.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
    }
    return Column(
      children: <Widget>[
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
