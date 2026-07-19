import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/text_styles.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  String? _usernameError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _usernameError = null;
      _passwordError = null;
    });

    if (_usernameController.text.isEmpty) {
      setState(() => _usernameError = 'Username is required');
      isValid = false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() => _passwordError = 'Password is required');
      isValid = false;
    } else if (_passwordController.text.length < 6) {
      setState(() => _passwordError = 'Password must be at least 6 characters');
      isValid = false;
    }

    return isValid;
  }

  void _login() async {
    if (!_validateForm()) return;

    await ref.read(authNotifierProvider.notifier).login(
          username: _usernameController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AsyncLoading;

    // Listen for auth state changes to navigate on success
    ref.listen(authNotifierProvider, (previous, next) {
      next.when(
        data: (auth) {
          if (auth != null && mounted) {
            context.go('/home');
          }
        },
        error: (error, stackTrace) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          }
        },
        loading: () {},
      );
    });

    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  'Welcome Back',
                  style: TextStyles.displaySmall.copyWith(
                    color: AppColors.grey900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue to your prayers',
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppColors.grey500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                CustomTextField(
                  label: 'Username',
                  hintText: 'Enter your username',
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                  validator: (_) => _usernameError,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (_) => _passwordError,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/recover'),
                    child: Text(
                      'Forgot password?',
                      style: TextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Sign In',
                  onPressed: _login,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppColors.grey700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: Text(
                        'Sign Up',
                        style: TextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
