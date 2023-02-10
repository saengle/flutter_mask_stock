class Stores {
  final String? addr;
  final String? code;
  final String? createdAt;
  final num? lat;
  final num? lng;
  final String? name;
  final String? remainStat;
  final String? stockAt;
  final String? type;

  Stores({
    this.addr,
    this.code,
    this.createdAt,
    this.lat,
    this.lng,
    this.name,
    this.remainStat,
    this.stockAt,
    this.type,
  });

  Stores copyWith({
    String? addr,
    String? code,
    String? createdAt,
    num? lat,
    num? lng,
    String? name,
    String? remainStat,
    String? stockAt,
    String? type,
  }) {
    return Stores(
      addr: addr ?? this.addr,
      code: code ?? this.code,
      createdAt: createdAt ?? this.createdAt,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      remainStat: remainStat ?? this.remainStat,
      stockAt: stockAt ?? this.stockAt,
      type: type ?? this.type,
    );
  }

  Stores.fromJson(Map<String, dynamic> json)
      : addr = json['addr'] as String?,
        code = json['code'] as String?,
        createdAt = json['created_at'] as String?,
        lat = json['lat'] as double?,
        lng = json['lng'] as double?,
        name = json['name'] as String?,
        remainStat = json['remain_stat'] as String?,
        stockAt = json['stock_at'] as String?,
        type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
        'addr': addr,
        'code': code,
        'created_at': createdAt,
        'lat': lat,
        'lng': lng,
        'name': name,
        'remain_stat': remainStat,
        'stock_at': stockAt,
        'type': type
      };
}
