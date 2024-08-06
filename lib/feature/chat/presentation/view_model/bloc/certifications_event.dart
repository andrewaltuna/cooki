part of 'certifications_view_model.dart';

sealed class CertificationsEvent extends Equatable {
  const CertificationsEvent();

  @override
  List<Object> get props => [];
}

class CertificationsSelected extends CertificationsEvent {
  const CertificationsSelected(this.certification);

  final Certification certification;

  @override
  List<Object> get props => [certification];
}

class CertificationsBackPressed extends CertificationsEvent {
  const CertificationsBackPressed();
}
