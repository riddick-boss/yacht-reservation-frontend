import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/models/profile.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final AuthService _authService;

  ProfileCubit(this._authService) : super(const ProfileState()) {
    getProfile();
  }

  Future<void> logout() async {
    await _authService.logout();
    emit(state.copyWith(effect: const ProfileEffect.logout()));
  }

  Future<void> getProfile() async {
    try {
      final profile = await _authService.getProfile();
      emit(state.copyWith(profile: profile));
    } catch (e) {
      AppLogger.err(e);
    }
  }

  Future<void> updateUserName(String newName) async {
    try {
      final profile = await _authService.updateProfile(newName);
      emit(state.copyWith(profile: profile));
    } catch (e) {
      AppLogger.err(e);
    }
  }
}
