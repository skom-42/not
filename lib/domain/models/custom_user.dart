class CustomUser {
  final String email;
  final bool isVerified;
  final String? name;
  final String? surname;
  final String notificationToken;
  final String? plate;
  final int registrationDate;
  final String documentId;

  CustomUser({
    required this.email,
    required this.isVerified,
    required this.name,
    required this.surname,
    required this.notificationToken,
    required this.plate,
    required this.registrationDate,
    required this.documentId,
  });

  CustomUser copyWithNewPlate({required String? plate}) {
    return CustomUser(
      email: email,
      isVerified: isVerified,
      name: name,
      surname: surname,
      notificationToken: notificationToken,
      plate: plate,
      registrationDate: registrationDate,
      documentId: documentId,
    );
  }

  CustomUser updateIsVerified() {
    return CustomUser(
      email: email,
      isVerified: true,
      name: name,
      surname: surname,
      notificationToken: notificationToken,
      plate: plate,
      registrationDate: registrationDate,
      documentId: documentId,
    );
  }
}
