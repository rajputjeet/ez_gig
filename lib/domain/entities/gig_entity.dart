class GigEntity {
  final int id;
  final String title;
  final String location;
  final String sport;
  final String date;
  final String time;
  final bool isCurrent;
  final List<String> clubs;
  final String photographerName;
  final String? thumbnail;
  final double fee;

  const GigEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.sport,
    required this.date,
    required this.time,
    required this.isCurrent,
    required this.clubs,
    required this.photographerName,
    this.thumbnail,
    required this.fee,
  });
}
