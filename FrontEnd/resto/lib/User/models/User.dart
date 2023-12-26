class UserData {
  final int personId;
  final String firstName;
  final String lastName;
  final double longitudeAddress;
  final double latitudeAddress;
  final String email;
  final String phoneNumber;

  const UserData({
    required this.personId,
    required this.firstName,
    required this.lastName,
    required this.longitudeAddress,
    required this.latitudeAddress,
    required this.email,
    required this.phoneNumber,
  });

  static List<UserData> toList(List<dynamic> data) {
    List<UserData> card = [];
    for (int i = 0; i < data.length; i++) {
      try {
        card.add(UserData(
          personId: data[i]['personId'],
          longitudeAddress: double.parse(data[i]['longitudeAddress']),
          latitudeAddress: double.parse(data[i]['latitudeAddress']),
          firstName: data[i]['firstName'],
          lastName: data[i]['lastName'],
          email: data[i]['email'],
          phoneNumber: data[i]['phoneNumber'].toString(),
        ));
      } catch (err) {
        print(err);
      }
    }

    return card;
  }
}
