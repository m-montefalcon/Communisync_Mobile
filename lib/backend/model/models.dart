class Request {
  final int id;
  final int visitorId;
  final int homeownerId;
  final int? adminId;
  final int? personnelId;
  final DateTime date;
  final DateTime time;
  final String destinationPerson;
  final List<String>? visitMembers;
  final String visitStatus;
  // final String? qrCode;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final Visitor visitor;

  Request({
    required this.id,
    required this.visitorId,
    required this.homeownerId,
    this.adminId,
    this.personnelId,
    required this.date,
    required this.time,
    required this.destinationPerson,
    required this.visitMembers,
    required this.visitStatus,

    required this.visitor,
  });
}


class Visitor {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;
  final String contactNumber;

  final String? photo;
  final String role;
  final String email;
  Visitor({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    this.photo,

    required this.role,
    required this.email,

  });
}

class Homeowner {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;
  final List<String>? familyMember;


  Homeowner({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    this.familyMember,

  });


}
class RequestQr {
  final int id;
  final int visitorId;
  final int homeownerId;
  final int? adminId;
  final int? personnelId;
  // final DateTime date;
  // final DateTime time;
  final String destinationPerson;
  final List<String>? visitMembers;
  final String visitStatus;
  final String qrCode;
  final Visitor visitor;
// Add a field for QR code

  RequestQr({
    required this.id,
    required this.visitorId,
    required this.homeownerId,
    this.adminId,
    this.personnelId,
    // required this.date,
    // required this.time,
    required this.destinationPerson,
    required this.visitMembers,
    required this.visitStatus,
    required this.qrCode, // Include it in the constructor
    required this.visitor,

  });
}




class FetchAllQr {
  int? id;
  String? destinationPerson;
  List<String>? visitMembers;
  String? qrCode;
  Homeowner homeowner; // Make it nullable with '?'
  Admin admin; // Make it nullable with '?'

  FetchAllQr({
    required this.id,
    this.destinationPerson,
    this.visitMembers,
    this.qrCode,
     required this.homeowner,
     required this.admin,
  });


}
class Admin {
  int id;
  String userName;
  String firstName;
  String lastName;
  String? photo;

  Admin({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    this.photo
  });


}


class User {
  final String firstName;
  final String lastName;
  final String userName;
  final String contactNumber;
  final String email;
  final int? blockNo;
  final int? lotNo;
  final bool? manualVisitOption;
  final String? photo;

  User({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.contactNumber,
    required this.email,
    this.blockNo,
    this.lotNo,
    this.manualVisitOption,
    this.photo,
  });
}


class Announcement {
  final String title;
  final String description;
  final String? photo;
  final String date;

  Admin admin;

  Announcement({
    required this.title,
    required this.description,
    this.photo,
    required this.admin,
    required this.date

  });
}

class Complaint {
  final String title;
  final String description;
  final String? photo;
  final String? status;
  final AdminComplaints? admin;
  final List<ComplaintUpdate>? updates;

  Complaint({
    required this.title,
    required this.description,
    this.photo,
    required this.status,
    required this.admin,
    this.updates,
  });
}

class ComplaintUpdate {
  final List<String>? update;
  final String? resolution;
  final String? date;

  ComplaintUpdate({
    this.update,
    this.resolution,
    this.date,
  });
}

class AdminComplaints {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? photo;

  AdminComplaints({
   this.id,
   this.userName,
   this.firstName,
   this.lastName,
    this.photo
  });


}