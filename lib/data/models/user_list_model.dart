import '../../domain/entities/talent_entity.dart';

class UserListModel {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final String phone;
  final String address;

  const UserListModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.phone,
    required this.address,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    final addr = json['address'] as Map<String, dynamic>? ?? {};
    final city  = addr['city']?.toString() ?? '';
    final state = addr['state']?.toString() ?? '';
    return UserListModel(
      id: json['id'] as int? ?? 0,
      firstName: json['firstName']?.toString() ?? '',
      lastName:  json['lastName']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: city.isNotEmpty ? '$city, $state' : 'New York, NY',
    );
  }

  TalentEntity toEntity(int index) {
    final ratings = [3.0, 3.5, 4.0, 4.5, 5.0];
    final exp     = [1, 2, 3, 4, 5];
    final i = index % 5;
    return TalentEntity(
      id: id,
      name: '$firstName $lastName',
      image: image,
      rating: ratings[i],
      experienceYears: exp[i],
      location: address,
      role: 'Videographer',
    );
  }
}
