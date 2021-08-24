class Buyer {
  String id, name, cnic, phoneNo, address;

  Buyer(
      {required this.id,
      required this.name,
      required this.cnic,
      required this.phoneNo,
      required this.address});

  factory Buyer.fromJson(Map<String, dynamic> json) {
    return new Buyer(
      id: json['_id'].toString(),
      name: json['Name'].toString(),
      cnic: json['CNIC'].toString(),
      phoneNo: json['PhoneNo'].toString(),
      address: json['Address'].toString(),
    );
  }
}
