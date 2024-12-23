import 'package:flutter/material.dart';
import 'inicial.dart';
import 'perfil.dart'; // Importando a página de perfil

class CadastrarScreen extends StatefulWidget {
  const CadastrarScreen({Key? key}) : super(key: key);

  @override
  _CadastrarScreenState createState() => _CadastrarScreenState();
}

class _CadastrarScreenState extends State<CadastrarScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário
  final TextEditingController _nomeController = TextEditingController(); // Controlador para o nome
  final TextEditingController _dataNascimentoController = TextEditingController(); // Controlador para a data de nascimento
  final TextEditingController _emailController = TextEditingController(); // Controlador para o email
  final TextEditingController _senhaController = TextEditingController(); // Controlador para a senha
  bool _obscureText = true; // Controle da visibilidade da senha

  Future<void> _selectDate(BuildContext context) async {
    // Define a data padrão e a faixa de seleção
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      // Define o formato da data para dd/MM/yyyy
      setState(() {
        _dataNascimentoController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFD6),
      body: SingleChildScrollView(
        child: Form( // Use um formulário para validação
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 5),
              Image.asset(
                'assets/twinkle.png',
                height: 300,
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF335469),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 95, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
                  children: [
                    const Text(
                      'Cadastro',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF0EFD6),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Campo de Nome Completo
                    _buildTextField(
                      label: 'Nome Completo:',
                      controller: _nomeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu nome completo';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Campo de Data de Nascimento com seletor
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: _buildTextField(
                          label: 'Data de Nascimento:',
                          controller: _dataNascimentoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua data de nascimento';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Campo de Email Educacional
                    _buildTextField(
                      label: 'Email Educacional:',
                      controller: _emailController,
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

                    // Campo de Senha
                    _buildPasswordField(
                      controller: _senhaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    // Botão "CADASTRAR"
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBD3B3A),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) { // Valida o formulário
                            String userName = _nomeController.text; // Pega o nome completo
                            String userEmail = _emailController.text; // Pega o email
                            String userBirthDate = _dataNascimentoController.text; // Pega a data de nascimento

                            // Exibir mensagem de sucesso
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cadastro realizado com sucesso :))'),
                              ),
                            );

                            // Navegar para a página de perfil
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  name: userName,
                                  email: userEmail,
                                  birthDate: userBirthDate,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'CADASTRAR',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
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

  // Método para criar campos de texto comuns
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFF0EFD6),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
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
          validator: validator,
        ),
      ],
    );
  }

  // Método para criar o campo de senha
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Senha:',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF0EFD6),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
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
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText; // Alterna a visibilidade da senha
                });
              },
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
