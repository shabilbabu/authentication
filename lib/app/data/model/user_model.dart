class UserModel{
  String? name;
  String? email;
  String? id;
  String? accessTocken;

  UserModel({this.name,this.email,this.id,this.accessTocken});

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    id = json['id'];
    accessTocken = json['access_token'];
  }

  
}