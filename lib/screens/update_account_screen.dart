import 'package:flutter/material.dart';

import '../services/account_service.dart';
import '../theme/app_theme.dart';
import '../widgets/field_label.dart';

class UpdateAccountScreen extends StatefulWidget {
  const UpdateAccountScreen({super.key, required this.onUpdated});

  final ValueChanged<String> onUpdated;

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAccount();
  }

  Future<void> _loadAccount() async {
    final account = await AccountService.load();
    if (!mounted) return;
    _usernameController.text = account.username;
    _passwordController.text = account.password;
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final username = _usernameController.text.trim();
    await AccountService.update(
      username: username,
      password: _passwordController.text,
    );
    if (!mounted) return;
    widget.onUpdated(username);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update User & Password')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppLayout.gutter(context),
                  vertical: 20,
                ),
                children: [
                  const Text(
                    'Perbarui akun untuk login berikutnya.',
                    style: TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 24),
                  const FieldLabel('Username'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Username wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  const FieldLabel('Password'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Password wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _save,
                    child: const Text('Simpan Perubahan'),
                  ),
                ],
              ),
            ),
    );
  }
}
