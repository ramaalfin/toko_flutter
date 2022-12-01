class AllProduks {
  int? code;
  bool? status;
  String? message;
  List<Produk>? produk;

  AllProduks({this.code, this.status, this.message, this.produk});

  AllProduks.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      produk = <Produk>[];
      json['data'].forEach((v) {
        produk!.add(new Produk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.produk != null) {
      data['data'] = this.produk!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Produk {
  int? id;
  int? userId;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;
  String? createdAt;
  String? updatedAt;

  Produk(
      {this.id,
      this.userId,
      this.kodeProduk,
      this.namaProduk,
      this.hargaProduk,
      this.createdAt,
      this.updatedAt,
      });

  Produk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    kodeProduk = json['kodeProduk'];
    namaProduk = json['namaProduk'];
    hargaProduk = json['hargaProduk'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['kodeProduk'] = this.kodeProduk;
    data['namaProduk'] = this.namaProduk;
    data['hargaProduk'] = this.hargaProduk;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
