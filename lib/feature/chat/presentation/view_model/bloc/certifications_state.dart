part of 'certifications_view_model.dart';

class CertificationsState extends Equatable {
  const CertificationsState({
    this.certification = Certification.usdaOrganic,
    this.isDetailView = false,
  });

  final Certification certification;
  final bool isDetailView;

  CertificationsState copyWith({
    Certification? certification,
    bool? isDetailView,
  }) {
    return CertificationsState(
      certification: certification ?? this.certification,
      isDetailView: isDetailView ?? this.isDetailView,
    );
  }

  @override
  List<Object> get props => [
        certification,
        isDetailView,
      ];
}
