import 'package:flutter/material.dart';
import 'package:proto/models/past_purchase.dart';
import 'package:proto/pages/past_purchases/future_get_purchase.dart';
import 'package:proto/pages/past_purchases/past_purchase_list.dart';

class PastPurchasesSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<PastPurchasesResponse?>(
        future: searchPastPurchases(query),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (projectSnap.hasError) {
            return const Center(child: Text("Sadly you have no PastPurchases"));
          } else if (projectSnap.hasData) {
            if (projectSnap.data!.purchases.isEmpty) {
              return const Center(child: Text("Purchases Not Found"));
            }
            PastPurchasesResponse myPurchases = projectSnap.data!;
            return Center(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: myPurchases.purchases.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    return PurchasesTile(p: myPurchases.purchases[idx]);
                  }),
            );
          } else {
            return const Text("No results");
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
