class ModelUser {
  int? code;
  String? icon;
  String? status;
  String? message;
  Results? results;

  ModelUser({this.code, this.icon, this.status, this.message, this.results});

  ModelUser.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    icon = json['icon'];
    status = json['status'];
    message = json['message'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['icon'] = this.icon;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  User? user;
  String? role;
  int? completion;

  Results({this.user, this.role, this.completion});

  Results.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    role = json['role'];
    completion = json['completion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['role'] = this.role;
    data['completion'] = this.completion;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? passwordHint;
  String? position;
  String? address;
  String? phone;
  String? religion;
  String? gender;
  String? education;
  String? maritalStatus;
  String? birthDate;
  String? profileDir;
  String? profileImage;
  int? roleId;
  String? createdAt;
  String? updatedAt;
  String? lastLoggedIn;
  int? isLoggedIn;
  int? isActive;
  int? loggedInAttempt;

  User(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.passwordHint,
        this.position,
        this.address,
        this.phone,
        this.religion,
        this.gender,
        this.education,
        this.maritalStatus,
        this.birthDate,
        this.profileDir,
        this.profileImage,
        this.roleId,
        this.createdAt,
        this.updatedAt,
        this.lastLoggedIn,
        this.isLoggedIn,
        this.isActive,
        this.loggedInAttempt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    passwordHint = json['password_hint'];
    position = json['position'];
    address = json['address'];
    phone = json['phone'];
    religion = json['religion'];
    gender = json['gender'];
    education = json['education'];
    maritalStatus = json['marital_status'];
    birthDate = json['birth_date'];
    profileDir = json['profile_dir'];
    profileImage = json['profile_image'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLoggedIn = json['last_logged_in'];
    isLoggedIn = json['is_logged_in'];
    isActive = json['is_active'];
    loggedInAttempt = json['logged_in_attempt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password_hint'] = this.passwordHint;
    data['position'] = this.position;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['religion'] = this.religion;
    data['gender'] = this.gender;
    data['education'] = this.education;
    data['marital_status'] = this.maritalStatus;
    data['birth_date'] = this.birthDate;
    data['profile_dir'] = this.profileDir;
    data['profile_image'] = this.profileImage;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['last_logged_in'] = this.lastLoggedIn;
    data['is_logged_in'] = this.isLoggedIn;
    data['is_active'] = this.isActive;
    data['logged_in_attempt'] = this.loggedInAttempt;
    return data;
  }
}
