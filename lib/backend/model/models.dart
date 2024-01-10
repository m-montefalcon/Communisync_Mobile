
class Request {
  final int id;
  final int visitorId;
  final int homeownerId;
  final int? adminId;
  final int? personnelId;
  final DateTime date;
  final DateTime dateOut;
  final String destinationPerson;
  final List<String>? visitMembers;
  final String visitStatus;

  final Visitor visitor;

  Request({
    required this.id,
    required this.visitorId,
    required this.homeownerId,
    this.adminId,
    this.personnelId,
    required this.date,
    required this.dateOut,
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
  final DateTime? date;
  final DateTime? dateOut;
// Add a field for QR code

  RequestQr({
    required this.id,
    required this.visitorId,
    required this.homeownerId,
    this.adminId,
    this.personnelId,

    this.date,
    this.dateOut,
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
  late final int? manualVisitOption;
  final String? photo;
  final String? familyMember;


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
    this.familyMember
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


class PaymentRecords{
  final String? message;
  final int transactionNumber;
  final String paymentDate;
  final String? notes;
  final String paymentAmount;
  final AdminComplaints? admin;

  PaymentRecords({
    this.message,
    required this.transactionNumber,
    required this.paymentDate,
    this.notes,
    required this.paymentAmount,
    this.admin

  });
}


class Logbook {
  final int id;
  final Visitor? visitor;
  final List<String>? visitMembers;
  final String? contactNumber;
  final String visitDate;
  final String visitTime;

  Logbook( {
    required this.id,
    this.visitor,
    this.visitMembers,
    this.contactNumber,
    required this.visitDate,
    required this.visitTime,
  });
}

class Notification {
  final int id;
  final int recipientId;
  final String title;
  final String body;
  final DateTime date;
  Notification( {
    required this.id,
    required this.recipientId,
    required this.title,
    required this.body,
    required this.date
  });
}