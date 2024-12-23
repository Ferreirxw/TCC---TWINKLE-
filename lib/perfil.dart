import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io'; // Para operações com arquivos
import 'inicial.dart';
import 'material.dart';
import 'game.dart';
import 'camera_page.dart';

class PerfilPage extends StatefulWidget {
  final String name;
  final String email;
  final String birthDate;

  PerfilPage({
    required this.name,
    required this.email,
    required this.birthDate,
  });

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String? _avatarPath;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAvatar(); // Carrega o avatar ao iniciar a página
  }

  // Método para carregar o avatar salvo
  Future<void> _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarPath = prefs.getString('avatar_path');
    });
  }

  // Método para salvar o avatar
  Future<void> _saveAvatar(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar_path', path);
  }

  // Método para selecionar uma imagem
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarPath = pickedFile.path;
      });
      _saveAvatar(pickedFile.path); // Salva o avatar ao ser selecionado
    }
  }

  // Método para enviar mensagem
  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mensagem enviada com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Limpa o campo de texto
      setState(() {
        _messageController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, escreva uma mensagem antes de enviar.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFD6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFF0EFD6),
          elevation: 0,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/twinkle.png',
                  height: 300,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/teste.gif'), // Caminho da sua imagem
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _pickImage, // Trocar a imagem ao clicar no avatar
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white70,
                          image: _avatarPath == null
                              ? null
                              : DecorationImage(
                            image: FileImage(File(_avatarPath!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.transparent,
                          child: _avatarPath == null
                              ? const Icon(Icons.person, size: 70, color: Color(0xFF335469))
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF335469),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF335469),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.birthDate,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF335469),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              const Center(
                child: Text(
                  'Contéudos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF335469),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  '• ────── ✾ ────── •',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildSubjectWidget("Matemática", 'assets/matematica.png'),
              _buildSubjectWidget("Português", 'assets/lingua.png'),
              _buildSubjectWidget("Exercícios", 'assets/exercicios.png'),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dúvidas?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF335469),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Entre em contato!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF335469),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD6D6D6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: '...',
                      ),
                      minLines: 3,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFff3131),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: _sendMessage, // Chama o método de envio
                        child: const Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF99bdd2),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 4,
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    name: widget.name,
                    email: widget.email,
                    birthDate: widget.birthDate,
                  ),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DidacticMaterialPage(
                    name: widget.name,
                    email: widget.email,
                    birthDate: widget.birthDate,
                  ),
                ),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    name: widget.name,
                    email: widget.email,
                    birthDate: widget.birthDate,
                  ),
                ),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPage(),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book, size: 30),
              label: 'Livros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera, size: 30),
              label: 'Câmera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset, size: 30),
              label: 'Jogos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star, size: 30),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectWidget(String subjectName, String imagePath) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subjectName,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }
}
