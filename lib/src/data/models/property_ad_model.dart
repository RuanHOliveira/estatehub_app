class PropertyAdModel {
  final String id;
  final String userId;
  final String type;
  final double priceBrl;
  final double? priceUsd;
  final String? imagePath;
  final String? imageData;
  final String zipCode;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String? complement;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PropertyAdModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.priceBrl,
    this.priceUsd,
    this.imagePath,
    this.imageData,
    required this.zipCode,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    this.complement,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PropertyAdModel.fromJson(Map<String, dynamic> json) {
    return PropertyAdModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      priceBrl: (json['price_brl'] as num).toDouble(),
      priceUsd: json['price_usd'] != null
          ? (json['price_usd'] as num).toDouble()
          : null,
      imagePath: json['image_path'] as String?,
      imageData: json['image_data'] as String?,
      zipCode: json['zip_code'] as String,
      street: json['street'] as String,
      number: json['number'] as String,
      neighborhood: json['neighborhood'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      complement: json['complement'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
