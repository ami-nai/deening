import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/text_styles.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  
  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _usernameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    if (_usernameController.text.isEmpty) {
      setState(() => _usernameError = 'Username is required');
      isValid = false;
    }

    if (_emailController.text.isNotEmpty &&
        !_isValidEmail(_emailController.text)) {
      setState(() => _emailError = 'Please enter a valid email');
      isValid = false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() => _passwordError = 'Password is required');
      isValid = false;
    } else if (_passwordController.text.length < 6) {
      setState(() => _passwordError = 'Password must be at least 6 characters');
      isValid = false;
    }

    if (_confirmPasswordController.text != _passwordController.text) {
      setState(() => _confirmPasswordError = 'Passwords do not match');
      isValid = false;
    }

    return isValid;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email);
  }

  void _register() async {
    if (!_validateForm()) return;

    await ref.read(authNotifierProvider.notifier).register(
          username: _usernameController.text,
          password: _passwordController.text,
          email: _emailController.text.isEmpty ? null : _emailController.text,
        );

    if (mounted) {
      final authState = ref.read(authNotifierProvider);
      authState.whenData((auth) {
        if (auth != null) {
          context.go('/home');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Account',
                  style: TextStyles.displaySmall.copyWith(
                    color: AppColors.grey900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Start tracking your daily prayers',
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppColors.grey500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Username',
                  hintText: 'Choose a username',
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                  validator: (_) => _usernameError,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Email (Optional)',
                  hintText: 'your@email.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (_) => _emailError,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Password',
                  hintText: 'At least 6 characters',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (_) => _passwordError,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Confirm Password',
                  hintText: 'Confirm your password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: (_) => _confirmPasswordError,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  label: 'Create Account',
                  onPressed: _register,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppColors.grey700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        'Sign In',
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
