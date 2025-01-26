class PostModel {
  String? profileName;
  String? profileImage;
  String? postImage;
  String? uId;
  String? date;
  String? text;

  PostModel({
    required this.profileImage,
    required this.profileName,
    required this.postImage,
    required this.uId,
    required this.date,
    required this.text,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    profileName = json['profileName'];
    profileImage = json['profileImage'];
    uId = json['uId'];
    postImage = json['postImage'];
    date = json['date'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'profileName': profileName,
      'postImage': postImage,
      'date': date,
      'text': text,
      'uId': uId,
    };
  }
}
