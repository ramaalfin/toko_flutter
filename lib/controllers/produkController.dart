import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pertemuan_10_12/models/produk.dart';
import 'package:pertemuan_10_12/utils/baseurl.dart';
import 'package:http/http.dart' as http;
import 'package:pertemuan_10_12/widgets/customSnackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProdukController extends GetxController{
  
  List<Produk> produks = [];
  List<Produk> filteredProduk = [];

  late TextEditingController kodeProdukController, namaProdukController,hargaProdukController;

  @override
  void onInit(){
    super.onInit();
    getProduk();

    kodeProdukController = TextEditingController();
    namaProdukController = TextEditingController();
    hargaProdukController = TextEditingController();
  }

  @override
  void onClose(){
    super.onClose();
    kodeProdukController.dispose();
    namaProdukController.dispose();
    hargaProdukController.dispose();
  }

  getProduk() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    
    final token = prefs.get(key) ?? 0;

    var response = await http.get(Uri.parse(produkUrl), 
      headers: {
        "Accept" : "application/json",
        'Authorization' : 'Bearer $token'
      },
    );

    var res = await json.decode(response.body);
    if(response.statusCode == 200){
      produks = AllProduks.fromJson(res).produk!;
      filteredProduk = AllProduks.fromJson(res).produk!;
      update();
    } else {
      customSnackbar("Error", "Failed to fetch products", "error");
    }
    return json.decode(response.body);
  }

  // Cari Produk
  
  search(String val){
    if (val.isEmpty) {
      filteredProduk = produks;
      update();
      return;
    }

    filteredProduk = produks.where((produk) {
      return produk.namaProduk!.toLowerCase().contains(val.toLowerCase());
    }).toList();

    update();
  }

  // Tambah Produk

  addProduk() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final token = prefs.get(key) ?? 0;

    var response = await http.post(Uri.parse(produkUrl), 
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      body: {
        "kodeProduk" : kodeProdukController.text,
        "namaProduk" : namaProdukController.text,
        "hargaProduk" : hargaProdukController.text,
      });

    var res = await json.decode(response.body);

    if (response.statusCode == 200) {
      customSnackbar("Success", res['message'], "success");
      kodeProdukController.text = "";
      namaProdukController.text = "";
      hargaProdukController.text = "";
      getProduk();
    } else {
      customSnackbar("Error", res['message'], "error");
    }
    update();
  }

  // Edit Produk

  editProduk(id) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;

    var response = await http.put(Uri.parse('$produkUrl/$id'), 
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      body: {
        "kodeProduk" : kodeProdukController.text,
        "namaProduk" : namaProdukController.text,
        "hargaProduk" : hargaProdukController.text,
      }
    );

    var res = await json.decode(response.body);

    if (response.statusCode == 200) {
      customSnackbar("Success", res['message'], "success");
      kodeProdukController.text = "";
      namaProdukController.text = "";
      hargaProdukController.text = "";
      getProduk();
    } else {
      customSnackbar("Error", res['message'], "error");
    }
    update();
  }

  // Hapus Produk

  deleteProduk(id) async{
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;

    var response = await http.delete(Uri.parse('$produkUrl/$id'), 
      headers: {
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
    );

    var res = await json.decode(response.body);

    if (response.statusCode == 200) {
      customSnackbar('Success', res['message'], 'success');
      getProduk();
    } else {
      customSnackbar("Error", res['message'], 'error');
    }
    update();
  }
}