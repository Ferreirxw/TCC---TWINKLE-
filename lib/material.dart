import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'inicial.dart';
import 'perfil.dart';
import 'game.dart';
import 'camera_page.dart';

class DidacticMaterialPage extends StatelessWidget {
  final String name;
  final String email;
  final String birthDate;

  const DidacticMaterialPage({
    Key? key,
    required this.name,
    required this.email,
    required this.birthDate,
  }) : super(key: key);

  Future<void> _launchInBrowser(String url) async {
    final Uri uri = Uri.parse(url); // Converte a URL para Uri

    try {
      // Verifica se a URL pode ser aberta
      if (await canLaunchUrl(uri)) {
        print("Abrindo URL: $url");
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Não foi possível abrir a URL: $url';
      }
    } catch (e) {
      print('Erro ao tentar abrir a URL: $e');
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        print('Erro ao tentar abrir no navegador externo: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFD6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/twinkle.png',
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Material Didático',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF335469),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30, // Aumentei o espaçamento entre os itens
              children: [
                _buildBookCard(
                  'assets/lingua.png',
                  'Língua Portuguesa - 6º ano',
                  'https://drive.google.com/file/d/1JNl_TvoC8GDPS3LDz8NHAe4_OytkvWRD/view', // URL simples para testar
                ),
                _buildBookCard(
                  'assets/matematica.png',
                  'Matemática - 6º ano',
                  'https://drive.google.com/file/d/1IKJF_jtv6OxIZlgLCcBxiS1MfayYAQSX/view', // URL simples para testar
                ),
                _buildBookCard(
                  'assets/ciencias.png',
                  'Ciências Humanas e Naturais - 6º ano',
                  'https://drive.google.com/file/d/1dJOyzZtNORySfIVsVIsSDyo3daCbF7QP/view?usp=sharing', // URL simples para testar
                ),
                _buildBookCard(
                  'assets/artes.png',
                  'Artes e Inglês - 6º ano',
                  'https://drive.google.com/file/d/1dJOyzZtNORySfIVsVIsSDyo3daCbF7QP/view?usp=sharing', // URL simples para testar
                ),
                _buildBookCard(
                  'assets/exercicios.png',
                  'Exercícios - 6º ano',
                  'https://drive.google.com/file/d/1uyUUaQpDLTQWlqcpGq_wg4XVNy5CRfFx/view?usp=sharing', // URL simples para testar
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF668da3),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 1,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      name: name,
                      email: email,
                      birthDate: birthDate,
                    ),
                  ),
                );
                break;
              case 1:
              // Add navigation for the DidacticMaterialPage
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                  ),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(
                      name: name,
                      email: email,
                      birthDate: birthDate,
                    ),
                  ),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PerfilPage(
                      name: name,
                      email: email,
                      birthDate: birthDate,
                    ),
                  ),
                );
                break;
              default:
                break;
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

  Widget _buildBookCard(String imagePath, String title, String url) {
    return GestureDetector(
      onTap: () {
        print("Card clicado para a URL: $url"); // Verificação adicional para debug
        _launchInBrowser(url);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF335469),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
