class PaymentResponse {
  PaymentResponse({
    required this.paymentCode,
    required this.description,
  });
  late final int paymentCode;
  late final String description;

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    paymentCode = json['payment_code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payment_code'] = paymentCode;
    _data['description'] = description;
    return _data;
  }
}
