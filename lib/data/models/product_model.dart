import '../../domain/entities/gig_entity.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final String thumbnail;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int? ?? 0,
        title: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        category: json['category']?.toString() ?? 'sports',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        rating: (json['rating'] as num?)?.toDouble() ?? 3.0,
        thumbnail: json['thumbnail']?.toString() ?? '',
      );

  /// Map product fields to a game/gig context
  GigEntity toEntity(int index) {
    final sports = ['Lacrosse', 'Soccer', 'Basketball', 'Baseball', 'Football'];
    final clubs  = [
      ['Wolverhampton FC', 'Chelsea Football'],
      ['Manchester City', 'Arsenal FC'],
      ['Real Madrid', 'Barcelona FC'],
      ['Bayern Munich', 'Dortmund FC'],
      ['PSG', 'Lyon FC'],
    ];
    final cities = ['Blaine, MN', 'Chicago, IL', 'Austin, TX', 'Denver, CO', 'Miami, FL'];
    final photographers = ['Harris', 'Jordan', 'Alex', 'Morgan', 'Casey'];
    final dates  = ['Oct 26, 2025', 'Nov 02, 2025', 'Nov 09, 2025', 'Nov 16, 2025', 'Nov 23, 2025'];
    final times  = ['12:45 PM', '02:00 PM', '10:00 AM', '03:30 PM', '06:00 PM'];

    final i = index % 5;
    return GigEntity(
      id: id,
      title: sports[i],
      location: cities[i],
      sport: sports[i],
      date: dates[i],
      time: times[i],
      isCurrent: index == 0,
      clubs: clubs[i],
      photographerName: photographers[i],
      thumbnail: thumbnail,
      fee: price,
    );
  }
}
