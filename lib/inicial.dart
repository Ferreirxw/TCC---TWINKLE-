import 'package:flutter/material.dart';
import 'package:main_aplicativo/camera_page.dart'; // Importando a página da câmera
import 'material.dart';
import 'perfil.dart';
import 'game.dart';

class HomePage extends StatelessWidget {
  final String name;
  final String email;
  final String birthDate;

  const HomePage({
    Key? key,
    required this.name,
    required this.email,
    required this.birthDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFD6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/twinkle.png',
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                image: const DecorationImage(
                  image: AssetImage('assets/inicial2.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'É um prazer, ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF335469),
                    ),
                  ),
                  TextSpan(
                    text: name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0056B3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: '!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF335469),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildFeatureCard(
              title1: 'REALIDADE',
              title2: 'AUMENTADA',
              buttonText: 'Habilitar',
              imageAsset: 'assets/AR.webp',
              onPressed: () {
                // Navega até a CameraPage ao clicar no botão "Habilitar"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(), // Redireciona para a CameraPage
                  ),
                );
              },
              color: const Color(0xFF668da3),
            ),
            const SizedBox(height: 20),
            _buildFeatureCard(
              title1: 'MATERIAL',
              title2: '',
              buttonText: 'Acesse',
              imageAsset: 'assets/icon.webp',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DidacticMaterialPage(name: name, email: email, birthDate: birthDate,),
                  ),
                );
              },
              color: const Color(0xFF668da3),
            ),
            const SizedBox(height: 70),
            _buildMainSectionHeader(),
            const SizedBox(height: 10),
            _buildWidgetSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildFeatureCard({
    required String title1,
    required String title2,
    required String buttonText,
    required String imageAsset,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (title2.isNotEmpty)
                Text(
                  title2,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Image.asset(
            imageAsset,
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _buildMainSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Descubra',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red[800],
          ),
        ),
        Text(
          'Veja tudo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red[800],
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Primeiro Widget
        _buildCustomWidgetCard(
          image: 'assets/ensino.png', // Caminho da imagem de fundo
          width: 180,  // Largura ajustável
          height: 345, // Altura ajustável
          onTap: () {
            // Ação para o primeiro widget
          },
        ),
        Column(
          children: [
            // Segundo Widget
            _buildCustomWidgetCard(
              // Pass the context
              image: 'assets/quiz (1).gif',
              width: 180,
              height: 150,
           // Pass birth date
              onTap: () {},
                ),

            const SizedBox(height: 10),
            // Terceiro Widget
            _buildCustomWidgetCard(
              image: 'assets/boy.gif', // Caminho da imagem de fundo
              width: 180,  // Largura ajustável
              height: 160, // Altura ajustável
              onTap: () {
                // Ação para o terceiro widget
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomWidgetCard({
    required String image,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,  // Dimensões personalizáveis
        height: height, // Dimensões personalizáveis
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),  // Definir a imagem de fundo
            fit: BoxFit.cover,          // A imagem cobrirá todo o container
          ),
          borderRadius: BorderRadius.circular(20), // Bordas arredondadas
        ),
      ),
    );
  }


  Widget _buildBottomNavigationBar(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF99bdd2),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DidacticMaterialPage(
                  name: name,
                  email: email,
                  birthDate: birthDate,
                ),
              ),
            );
          } else if (index == 4) {
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
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraPage(),
              ),
            );
          } else if (index == 3) {
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
    );
  }
}

class QuizOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const QuizOption({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 450,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFB4D5E4),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: const Color(0xFF0056B3),
            ),
            const SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
