class ViaCepModel {
  final String zipCode;
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String complement;

  const ViaCepModel({
    required this.zipCode,
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.complement,
  });

  factory ViaCepModel.fromJson(Map<String, dynamic> json) {
    return ViaCepModel(
      zipCode: json['zip_code'] as String? ?? '',
      street: json['street'] as String? ?? '',
      neighborhood: json['neighborhood'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      complement: json['complement'] as String? ?? '',
    );
  }
}
