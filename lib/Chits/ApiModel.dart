class Chit {
  int cid;
  int type;
  String name;
  String? mobile;
  String email;
  String address;
  String gender;

  Chit({
    required this.type,
    required this.cid,
    required this.name,
    this.mobile,
    required this.email,
    required this.address,
    required this.gender,
  });

  factory Chit.fromJson(Map<String, dynamic> json) {
    return Chit(
      type: json['type'],
      cid: json['cid'],
      name: json['Name'],
      mobile: json['Mobile'],
      email: json['Email'],
      address: json['Address'],
      gender: json['Gender'],
    );
  }
}
