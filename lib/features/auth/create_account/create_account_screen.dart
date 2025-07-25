import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rumo/core/asset_images.dart';
import 'package:rumo/features/auth/repositories/auth_repository.dart';
import 'package:rumo/features/onboarding/routes/onboarding_routes.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool hideConfirmedPassword = true;
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,

      // Stack permite sobrepor widgets
      // nesse caso, o logo e o texto ficam sobrepostos em relação à imagem de fundo
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26, top: 30),
            child: SingleChildScrollView(
              child: Row(
                //como o texto e a imagem estão lado a lado, usamos Row, caso fosse um abaixo do outro, usaríamos Column
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AssetImages.logo,
                            width: 134,
                            height: 52,
                          ),
                          Text(
                            'Memórias na',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.68,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'palma da mão.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.68,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Image.asset(AssetImages.createAccountCharacter),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14, bottom: 10),
                    child: IconButton.filled(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          OnboardingRoutes.onboardingScreen,
                        );
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      color: Color(0xFF383838),
                      icon: Icon(Icons.chevron_left),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cadastre-se',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Preencha os dados abaixo para criar sua conta.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 24),
                        Form(
                          key: _formKey, //chave do formulário
                          child: Column(
                            spacing: 16,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(hintText: 'Nome'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu nome';
                                  }
                                  return null;
                                },
                              ),

                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(hintText: 'E-mail'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu email';
                                  }
                                  // Regex para validar email
                                  // r' indica que caracteres como \ são literais e não como caracteres especiais
                                  // ^ indica o início da string, $ indica o fim da string
                                  /*final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                  ); 
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Por favor, insira um email válido';
                                  }*/
                                  return null;
                                },
                              ),

                              TextFormField(
                                controller: _passwordController,
                                obscureText: hidePassword,
                                decoration: InputDecoration(
                                  hintText: 'Senha',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    icon: Icon(
                                      hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira sua senha';
                                  } /*
                                  if (value.length < 6) {
                                    return 'A senha deve ter pelo menos 6 caracteres';
                                  }*/
                                  return null;
                                },
                              ),
                              TextFormField(
                                obscureText: hideConfirmedPassword,
                                decoration: InputDecoration(
                                  hintText: 'Confirmar senha',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hideConfirmedPassword =
                                            !hideConfirmedPassword;
                                      });
                                    },
                                    icon: Icon(
                                      hideConfirmedPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, confirme sua senha';
                                  }

                                  if (_passwordController.text != value) {
                                    return 'As senhas não coincidem';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 62),
                        SizedBox(
                          width: double
                              .maxFinite, // botão preenche toda a largura disponível
                          child: FilledButton(
                            onPressed: () async {
                              // impede iniciar outras operações caso já esteja em execução
                              if (isLoading) {
                                return;
                              }

                              final isValid = _formKey.currentState!.validate();
                              // se os campos forem válidos (validações dos TextFormField)
                              if (isValid) {
                                try {
                                  // animação de carregamento no botão
                                  setState(() {
                                    isLoading = true;
                                  });

                                  // instancia o AuthRepository
                                  final authRepository = AuthRepository();

                                  // await espera até a função createAccount ser executada
                                  // a função createAccount requer três parâmetros obrigatórios
                                  await authRepository.createAccount(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                  );

                                  if (context.mounted) {
                                    // popUntil remove até que exista apenas uma rota em execução
                                    Navigator.of(
                                      context,
                                    ).popUntil((route) => route.isFirst);

                                    // para que a primeira rota mostrada seja a Home, precisa substituir a rota de onBoarding pela rota Home
                                    Navigator.of(
                                      context,
                                    ).pushReplacementNamed('/home');
                                  }

                                  // pega a função que dispara exceção personalizada dependendo do código (cada erro tem um código diferente)
                                } on AuthException catch (error) {
                                  // apenas mostra a janela de alerta se o widget em questão (nesse caso, o FilledButton) ainda estiver ativo
                                  if (!context.mounted) return;

                                  // cria a janela de alerta e passa o método getMessage (mensagme personalizada) do AuthException
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Erro'),
                                        content: Text(error.getMessage()),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } finally {
                                  // vai executar o finally independente se cair no catch
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                            child: Builder(
                              builder: (context) {
                                if (isLoading) {
                                  return SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                }
                                return Text('Criar conta');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
