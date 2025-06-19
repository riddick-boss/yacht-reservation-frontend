import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final AuthService _authService;

  ProfileCubit(this._authService) : super(const ProfileState());

  Future<void> logout() async {
    await _authService.logout();
    emit(state.copyWith(effect: const ProfileEffect.logout()));
  }
}
