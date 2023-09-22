class Request {
  final int id;
  final int visitorId;
  final int homeownerId;
  final int? adminId;
  final int? personnelId;
  // final DateTime date;
  // final DateTime time;
  // final String destinationPerson;
  // final List<String>? visitMembers;
  // final  visitStatus;
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
    // required this.date,
    // required this.time,
    // required this.destinationPerson,
    // required this.visitMembers,
    // required this.visitStatus,
    // this.qrCode,
    // required this.createdAt,
    // required this.updatedAt,
    required this.visitor,
  });
}


class Visitor {
  final int id;
  // final String userName;
  // final String firstName;
  // final String lastName;
  // final String contactNumber;
  // final String? blockNo;
  // final String? lotNo;
  // final String? familyMember;
  // final String? emailVerifiedAt;
  // final int? manualVisitOption;
  // final String? photo;
  // final int role;
  // final String email;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  Visitor({
    required this.id,
    // required this.userName,
    // required this.firstName,
    // required this.lastName,
    // required this.contactNumber,
    // this.blockNo,
    // this.lotNo,
    // this.familyMember,
    // this.emailVerifiedAt,
    // this.manualVisitOption,
    // this.photo,
    // required this.role,
    // required this.email,
    // required this.createdAt,
    // required this.updatedAt,
  });
}
