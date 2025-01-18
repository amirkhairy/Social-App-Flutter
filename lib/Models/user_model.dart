class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? cover;
  String? image;
  String? bio;
  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.cover,
    required this.image,
    required this.bio,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'cover': cover,
      'image': image,
      'bio': bio,
      'uId': uId,
    };
  }
}
