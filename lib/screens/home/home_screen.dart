import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pertemuan_10_12/controllers/produkController.dart';
import 'package:pertemuan_10_12/models/produk.dart';
import 'package:pertemuan_10_12/routes.dart';
import 'package:pertemuan_10_12/screens/detail/detail_screen.dart';
import 'package:pertemuan_10_12/utils/shared_pref.dart';
import 'package:pertemuan_10_12/widgets/Loader.dart';
import 'package:pertemuan_10_12/widgets/customButton.dart';
import 'package:pertemuan_10_12/widgets/customSearch.dart';
import 'package:pertemuan_10_12/widgets/customTextField.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,

  }) : super(key: key);

  final produkController = Get.put(ProdukController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko'),
        actions: [
          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder:(context) => Dialog(
                  child: ManipulateProduk(),
                ),
              );
            }, 
            icon: Icon(Icons.add)
          ),
          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder:(context) => AlertDialog(
                  title: const Center(child: Text("Logout?")),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text("Cancel")
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red
                      ),
                      onPressed: () async{
                        await SharedPrefs().removeUser();
                        Get.offAllNamed(GetRoutes.login);
                      }, 
                      child: Text("Logout")
                    )
                  ],
                )
              );
            }, 
            icon: Icon(Icons.logout_sharp)
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<ProdukController>(
          builder: (controller) {
            return Column(
              children: [
                CustomSearch(
                  onChanged: (val){
                    controller.search(val);
                  }
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: controller.filteredProduk.map(
                      (produk) => Slidable(
                        child: ProdukTile(produk: produk),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(), 
                          children: [
                            SlidableAction(
                              onPressed: (context){
                                controller.kodeProdukController.text = produk.kodeProduk!;
                                controller.namaProdukController.text = produk.namaProduk!;
                                controller.hargaProdukController.text = produk.hargaProduk!.toString();
                                controller.update();
                                showDialog(
                                  context: context, 
                                  builder: (context) => Dialog(
                                    child: ManipulateProduk(
                                      edit: true,
                                      id: produk.id!.toString(),
                                    ),
                                  )
                                );
                              },
                              backgroundColor: Color(0xff8394ff),
                              foregroundColor: Colors.white,
                              icon: FontAwesomeIcons.pencil,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                showDialog(
                                  context: context, 
                                  builder: ((context) => AlertDialog(
                                    actionsAlignment: MainAxisAlignment.center,
                                    title: Center(child: Text("Hapus Produk?")),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        }, 
                                        child: Text("Cancel")
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: Colors.red),
                                        onPressed: () async{
                                          await Get.showOverlay(
                                            asyncFunction: () => controller.deleteProduk(produk.id!),
                                            loadingWidget: Loader()
                                          );
                                          Navigator.pop(context);
                                        }, 
                                        child: Text("Delete")
                                      ),
                                    ],
                                  )));
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: FontAwesomeIcons.trash,
                              label: 'Delete',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                    builder: (context)=>ProdukDetail(
                                      kodeProduk: produk.kodeProduk!, 
                                      namaProduk: produk.namaProduk!, 
                                      hargaProduk: produk.hargaProduk!
                                    )
                                  )
                                );
                              },
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.white,
                              icon: FontAwesomeIcons.eye,
                              label: 'Detail',
                            ),
                          ]
                        ),
                      )).toList()
                    ),
                  )
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

class ProdukTile extends StatelessWidget {
  ProdukTile({
    Key? key, required this.produk,
  }) : super(key: key);

  final Produk produk;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 12,
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kode Produk : " + produk.kodeProduk.toString(),
            style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w600
            ),
          ),
          Text(
            "Nama Produk : " + produk.namaProduk.toString(),
            style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w600
            ),
          ),
          Text(
            'harga produk : ' + produk.hargaProduk.toString(),
            style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }
}

class ManipulateProduk extends StatelessWidget {
  const ManipulateProduk({
    Key? key,
    this.edit = false,
    this.id = ""
  }) : super(key: key);

  final bool edit;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GetBuilder<ProdukController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "${edit ? 'Edit' : 'Add' } Produk",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              CustomTextField(
                hint: 'Kode Produk', 
                controller: controller.kodeProdukController
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                hint: 'Nama Produk', 
                controller: controller.namaProdukController,
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                hint: 'Harga Produk', 
                controller: controller.hargaProdukController
              ),
              const SizedBox(height: 30,),
              CustomButton(
                label: "${edit ? 'Edit' : 'Add' } Produk", 
                onPressed: () async{
                  if (!edit) {
                    await Get.showOverlay(
                      asyncFunction: ()=>controller.addProduk(), 
                      loadingWidget: const Loader()
                    );
                  } else {
                    await Get.showOverlay(
                      asyncFunction: ()=>controller.editProduk(id), 
                      loadingWidget: const Loader()
                    );
                  }
                  Navigator.pop(context);
              }),
            ],
          );
        }
      ),
    );
  }
}