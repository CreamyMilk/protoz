// ignore_for_file: non_constant_identifier_names

class PastPurchasesResponse {
  PastPurchasesResponse({
    required this.status,
    required this.purchases,
  });
  late final int status;
  late final List<Purchases> purchases;

  PastPurchasesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    purchases =
        List.from(json['purchases']).map((e) => Purchases.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['purchases'] = purchases.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Purchases {
  Purchases({
    required this.ID,
    required this.CreatedAt,
    required this.UpdatedAt,
    required this.buyer,
    required this.seller,
    required this.productID,
    required this.pname,
    required this.Quantity,
    required this.total,
    required this.code,
    required this.Deadline,
    required this.CompletedAt,
    required this.Status,
  });
  late final int ID;
  late final String CreatedAt;
  late final String UpdatedAt;
  late final String buyer;
  late final int seller;
  late final int productID;
  late final String pname;
  late final int Quantity;
  late final int total;
  late final String code;
  late final int Deadline;
  late final int CompletedAt;
  late final String Status;

  Purchases.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    CreatedAt = json['CreatedAt'];
    UpdatedAt = json['UpdatedAt'];
    buyer = json['buyer'];
    seller = json['seller'];
    productID = json['productID'];
    pname = json['pname'];
    Quantity = json['Quantity'];
    total = json['total'];
    code = json['code'];
    Deadline = json['Deadline'];
    CompletedAt = json['CompletedAt'];
    Status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ID'] = ID;
    _data['CreatedAt'] = CreatedAt;
    _data['UpdatedAt'] = UpdatedAt;
    _data['buyer'] = buyer;
    _data['seller'] = seller;
    _data['productID'] = productID;
    _data['pname'] = pname;
    _data['Quantity'] = Quantity;
    _data['total'] = total;
    _data['code'] = code;
    _data['Deadline'] = Deadline;
    _data['CompletedAt'] = CompletedAt;
    _data['Status'] = Status;
    return _data;
  }
}
