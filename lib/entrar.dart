import 'package:flutter/material.dart';
import 'inicial.dart';

class EntrarScreen extends StatefulWidget {
  const EntrarScreen({Key? key}) : super(key: key);

  @override
  _EntrarScreenState createState() => _EntrarScreenState();
}

class _EntrarScreenState extends State<EntrarScreen> {
  bool _obscureText = true; // Controle da visibilidade da senha
  final _formKey = GlobalKey<FormState>(); // Chave do formulário

  // Controladores para os campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFD6),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 180),
              Image.asset(
                'assets/logoo.png',
                height: 300,
              ),
              const SizedBox(height: 80),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF335469),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
                padding:
                const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),




                    const SizedBox(height: 20),
                    const SizedBox(height: 20),


                    TextFormField(
                      controller: _nomeController,
                      style: const TextStyle(color: Colors.black), // Cor do texto
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Usuário',
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu User';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.black), // Cor do texto
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'E-mail Educacional',
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu e-mail';
                        } else if (!value.contains('@')) {
                          return 'O e-mail deve conter "@"';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _senhaController,
                      obscureText: _obscureText,
                      style: const TextStyle(color: Colors.black), // Cor do texto
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Senha',
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Exibir mensagem de sucesso
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login realizado com sucesso'),
                              ),
                            );
                            // Navegar para a página inicial
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  name: _nomeController.text, // Substitua com o nome do usuário
                                  email: _emailController.text,
                                  birthDate:
                                  'Data de Nascimento', // Substitua com a data de nascimento
                                ),
                              ),
                            );
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBD3B3A),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white),

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
    );
  }
}

