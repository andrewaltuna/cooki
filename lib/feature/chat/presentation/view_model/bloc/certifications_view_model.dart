import 'package:cooki/feature/chat/data/enum/certification.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'certifications_event.dart';
part 'certifications_state.dart';

class CertificationsViewModel
    extends Bloc<CertificationsEvent, CertificationsState> {
  CertificationsViewModel() : super(const CertificationsState()) {
    on<CertificationsSelected>(_onSelected);
    on<CertificationsBackPressed>(_onBackPressed);
  }

  void _onSelected(
    CertificationsSelected event,
    Emitter<CertificationsState> emit,
  ) {
    emit(
      state.copyWith(
        certification: event.certification,
        isDetailView: true,
      ),
    );
  }

  void _onBackPressed(
    CertificationsBackPressed _,
    Emitter<CertificationsState> emit,
  ) {
    emit(
      state.copyWith(
        isDetailView: false,
      ),
    );
  }
}
