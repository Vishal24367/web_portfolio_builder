// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.success,
    this.message,
    this.data,
    this.meta,
    this.errors,
  });

  bool success;
  String message;
  Data data;
  Meta meta;
  List<dynamic> errors;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        meta: Meta.fromJson(json["meta"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "meta": meta.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class Data {
  Data({
    this.userData,
  });

  List<UserDatum> userData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: List<UserDatum>.from(
            json["user_data"].map((x) => UserDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_data": List<dynamic>.from(userData.map((x) => x.toJson())),
      };
}

class UserDatum {
  UserDatum({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNo,
    this.username,
    this.about,
    this.project,
    this.education,
    this.workExperience,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String phoneNo;
  String username;
  About about;
  List<Project> project;
  List<Education> education;
  List<WorkExperience> workExperience;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        username: json["username"],
        about: About.fromJson(json["about"]),
        project:
            List<Project>.from(json["project"].map((x) => Project.fromJson(x))),
        education: List<Education>.from(
            json["education"].map((x) => Education.fromJson(x))),
        workExperience: List<WorkExperience>.from(
            json["work_experience"].map((x) => WorkExperience.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_no": phoneNo,
        "username": username,
        "about": about.toJson(),
        "project": List<dynamic>.from(project.map((x) => x.toJson())),
        "education": List<dynamic>.from(education.map((x) => x.toJson())),
        "work_experience":
            List<dynamic>.from(workExperience.map((x) => x.toJson())),
      };
}

class About {
  About({
    this.id,
    this.skills,
    this.header,
    this.footer,
    this.links,
    this.bio,
    this.content,
  });

  int id;
  String skills;
  String header;
  String footer;
  String links;
  String bio;
  String content;

  factory About.fromJson(Map<String, dynamic> json) => About(
        id: json["id"],
        skills: json["skills"],
        header: json["header"],
        footer: json["footer"],
        links: json["links"],
        bio: json["bio"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skills": skills,
        "header": header,
        "footer": footer,
        "links": links,
        "bio": bio,
        "content": content,
      };
}

class Education {
  Education({
    this.id,
    this.universityName,
    this.specialization,
    this.achievements,
    this.startDate,
    this.endDate,
  });

  int id;
  String universityName;
  String specialization;
  String achievements;
  DateTime startDate;
  DateTime endDate;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"],
        universityName: json["university_name"],
        specialization: json["specialization"],
        achievements: json["achievements"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "university_name": universityName,
        "specialization": specialization,
        "achievements": achievements,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}

class Project {
  Project({
    this.id,
    this.avatarUrl,
    this.projectName,
    this.projectDescription,
    this.projectLink,
  });

  int id;
  String avatarUrl;
  String projectName;
  String projectDescription;
  String projectLink;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        avatarUrl: json["avatar_url"],
        projectName: json["project_name"],
        projectDescription: json["project_description"],
        projectLink: json["project_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar_url": avatarUrl,
        "project_name": projectName,
        "project_description": projectDescription,
        "project_link": projectLink,
      };
}

class WorkExperience {
  WorkExperience({
    this.id,
    this.companyName,
    this.role,
    this.workDescription,
    this.startDate,
    this.endDate,
  });

  int id;
  String companyName;
  String role;
  String workDescription;
  DateTime startDate;
  DateTime endDate;

  factory WorkExperience.fromJson(Map<String, dynamic> json) => WorkExperience(
        id: json["id"],
        companyName: json["company_name"],
        role: json["role"],
        workDescription: json["work_description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "role": role,
        "work_description": workDescription,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
