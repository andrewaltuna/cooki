import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/chat/data/enum/certification.dart';
import 'package:equatable/equatable.dart';

class ProductManufacturer extends Equatable {
  const ProductManufacturer({
    required this.name,
    required this.certifications,
  });

  factory ProductManufacturer.fromJson(Map<String, dynamic> json) {
    final certifications = json['certificates'] as List;
    return ProductManufacturer(
      name: json['name'],
      certifications: certifications
          .map(
            (certification) => Certification.values.firstWhere(
              (element) => element.apiValue == certification,
              orElse: () => Certification.values.first,
            ),
          )
          .toList(),
    );
  }

  static const empty = ProductManufacturer(
    name: '',
    certifications: [],
  );

  final String name;
  final List<Certification> certifications;

  @override
  List<Object?> get props => [
        name,
        certifications,
      ];
}
