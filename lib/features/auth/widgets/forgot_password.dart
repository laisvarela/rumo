import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rumo/features/auth/repositories/auth_repository.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Recuperar senha'),
      content: Column(
        // mainAxisSize vai redimencionar o tamanho de acordo com os filhos
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'E-mail'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu e-mail';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          Visibility(visible: isLoading, child: CircularProgressIndicator()),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (isLoading) return;

            final bool isValid = _formKey.currentState!.validate();
            if (isValid) {
              setState(() {
                isLoading = true;
              });
              try {
                log('email: ${_emailController.text}');
                final authRepository = AuthRepository();
                await authRepository.sendPasswordResetEmail(
                  email: _emailController.text,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('E-mail enviado com sucesso!')),
                  );
                  Navigator.of(context).pop();
                }
              } on AuthException catch (e) {
                if (!context.mounted) return;
                /*showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Erro'),
                      content: Text(e.getMessage()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    );*/
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.getMessage())),
                    );

              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            }
          },
          child: Text('Enviar e-mail'),
        ),
      ],
    );
  }
}
