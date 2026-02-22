import 'dart:typed_data';

class PropertyAdInput {
  final String type;
  final String priceBrl;
  final String zipCode;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String? complement;
  final Uint8List? imageBytes;
  final String? imageName;

  const PropertyAdInput({
    required this.type,
    required this.priceBrl,
    required this.zipCode,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    this.complement,
    this.imageBytes,
    this.imageName,
  });
}
