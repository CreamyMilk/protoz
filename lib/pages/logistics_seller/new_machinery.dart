import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proto/models/machineary.dart';
import 'package:proto/pages/logistics_seller/get_machine_stock.dart';

const _startColumnWidth = 45.0;

class MachineInventory extends StatefulWidget {
  const MachineInventory({Key? key}) : super(key: key);

  @override
  _MachineInventoryState createState() => _MachineInventoryState();
}

class _MachineInventoryState extends State<MachineInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "tabFab",
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed("/addProduct");
        },
        label: const Text(
          "New ",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_off,
              color: Colors.black,
            ),
          )
        ],
        title: (const Text(
          "Machinery",
          style: TextStyle(
            color: Colors.black,
          ),
        )),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
              margin: const EdgeInsets.only(top: 16),
              height: MediaQuery.of(context).size.height * .9,
              child: FutureBuilder(
                  future: getMachineStock(),
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (projectSnap.data == null) {
                      return const Center(
                          child: Text("Sadly you have no products"));
                    } else if (projectSnap.data != null) {
                      return ListView.builder(
                          itemCount: (projectSnap.data as List).length,
                          itemBuilder: (context, index) {
                            var item = (projectSnap.data as List)[index];
                            return ShoppingCartRow(
                              product: Machinery(
                                image: item["image"],
                                categoryID: item["categoryID"],
                                modelNo: item["machineID"],
                                packingType: item["packingtype"],
                                description: item["description"],
                                name: item["productname"],
                                stock: item["stock"],
                                price: item["price"],
                              ),
                              quantity: item["stock"],
                              onPressed: () {},
                            );
                          });
                    } else {
                      return const Center(
                          child: Text("Classificataion of conncetion failed"));
                    }
                  }))
        ]),
      ),
    );
  }
}

class ShoppingCartRow extends StatelessWidget {
  final Machinery product;
  final int quantity;
  final VoidCallback onPressed;

  const ShoppingCartRow({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        key: ValueKey<int>(product.modelNo), //Changed Types for better parsing
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _startColumnWidth,
            child: IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.black,
                size: 15,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/addProduct", arguments: product);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          color: Colors.white,
                          width: 70,
                          height: 70,
                          child: CachedNetworkImage(
                            imageUrl: product.image!,
                            height: 70,
                            width: 70,
                            placeholder: (context, String p) {
                              return Card(
                                  child: Container(
                                height: 70,
                                width: 70,
                                color: Colors.grey[50],
                              ));
                            },
                          )
                          // excludeFromSemantics: true,
                          ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Model No:  $quantity",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18)),
                                ),
                                Text(
                                  "x \$${product.price}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            Text(
                              product.name!,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 9),
                            Chip(
                                label: Text(
                                  product.isBooked ? "Booked" : "Available",
                                  style: TextStyle(
                                      color: !product.isBooked
                                          ? Colors.green
                                          : Colors.orange),
                                ),
                                backgroundColor: !product.isBooked
                                    ? Colors.green[50]
                                    : Colors.orange[50]),
                            //    Text(
                            //      product.description,
                            //      style: const TextStyle(
                            //
                            //          fontSize: 12,
                            //          fontWeight: FontWeight.w400,
                            //          color: Colors.green),
                            //    ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.brown,
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
