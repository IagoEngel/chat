import 'dart:io';

import 'package:flutter/material.dart';

import '../models/auth_form_data.dart';
import 'user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePicker(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError("Imagem não selecionada!");
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePicker,
                ),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey("name"),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    final name = value ?? '';
                    if (name.trim().length < 5) {
                      return "Nome deve ter no mínimo 5 caracteres.";
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey("email"),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: "E-mail"),
                validator: (value) {
                  final email = value ?? '';
                  if (!email.contains('@')) {
                    return "Email informado não é inválido.";
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("password"),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Senha"),
                validator: (value) {
                  final password = value ?? '';
                  if (password.length < 6) {
                    return "Senha deve ter no mínimo 6 caracteres.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? "Entrar" : "Cadastrar"),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(_formData.isLogin
                    ? "Criar uma nova conta?"
                    : "Já possui conta?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
