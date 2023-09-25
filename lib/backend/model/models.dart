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
  // final String contactNumber;
  // final int blockNo;
  // final int lotNo;
  final List<String>? familyMember;
  // final String? photo;
  // final String role;
  // final String email;
  Homeowner({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    // required this.blockNo,
    // required this.lotNo,
    required this.familyMember,
    // required this.contactNumber,
    // this.photo,
    // required this.role,
    // required this.email,

  });
}
