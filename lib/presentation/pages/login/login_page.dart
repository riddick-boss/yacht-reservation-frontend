import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yacht_reservation_frontend/domain/di/injection.dart';
import 'package:yacht_reservation_frontend/presentation/navigation/app_router.dart';
import 'package:yacht_reservation_frontend/presentation/pages/login/cubit/login_cubit.dart';
import 'package:yacht_reservation_frontend/presentation/theme/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        switch (state.navDestination) {
          case NavDestination.home:
            context.go(Routes.home);
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Logo(),
                  const SizedBox(height: 48),
                  _LoginForm(
                    state: state,
                    onEmailChanged: cubit.emailChanged,
                    onPasswordChanged: cubit.passwordChanged,
                    onLoginPressed: cubit.login,
                    onRegisterPressed: cubit.register,
                  ),
                  const SizedBox(height: 24),
                  const _ResetPasswordButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.directions_boat, size: 64, color: AppColors.primary),
        const SizedBox(height: 16),
        Text(
          'Yacht Reservation',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.state,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  final LoginState state;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _EmailField(onEmailChanged),
        const SizedBox(height: 16),
        _PasswordField(onPasswordChanged),
        const SizedBox(height: 24),
        _LoginButton(isLoading: state.isLoading, onPressed: onLoginPressed),
        const SizedBox(height: 24),
        _RegisterButton(
          isLoading: state.isLoading,
          onPressed: onRegisterPressed,
        ),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField(this.onChanged);

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField(this.onChanged);

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock_outline),
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _LoginButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isLoading
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : const Text('Login'),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _RegisterButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: const Text('Register'),
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  const _ResetPasswordButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: Implement reset password
      },
      child: const Text('Forgot Password?'),
    );
  }
}
