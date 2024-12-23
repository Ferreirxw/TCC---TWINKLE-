import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'camera_page.dart';
import 'inicial.dart';
import 'material.dart';
import 'perfil.dart';

class GamePage extends StatefulWidget {
  final String name;
  final String email;
  final String birthDate;

  const GamePage({
    Key? key,
    required this.name,
    required this.email,
    required this.birthDate,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final List<Map<String, String>> _quizzes = [
    {
      'image': 'assets/port.png',
      'title': 'Quiz de Português',
      'description': 'Desenvolva seu vocabulário.',
      'url': 'https://kahoot.it/solo/?quizId=a43481f2-acd6-4855-b5bc-bc7840a56dc7',
    },
    {
      'image': 'assets/mat.png',
      'title': 'Quiz de Matemática',
      'description': 'Treine sua matemática.',
      'url': 'https://kahoot.it/solo/?quizId=407d3239-aba5-4556-ae56-86b6da0f4a03',
    },
    {
      'image': 'assets/geo.png',
      'title': 'Quiz de Geografia',
      'description': 'Explore o mundo.',
      'url': 'https://kahoot.it/solo/?quizId=6f30e730-c370-411b-a093-8be2e98ea7ff',
    },
    {
      'image': 'assets/hist.png',
      'title': 'Quiz de História',
      'description': 'Explore o passado.',
      'url': 'https://kahoot.it/solo/?quizId=8df0434b-905f-4c0d-80f2-3ba178292110',
    },
    {
      'image': 'assets/cienc.png',
      'title': 'Quiz de Ciências',
      'description': 'Explore as ciências.',
      'url': 'https://kahoot.it/solo/?quizId=265c6dba-4d4a-4ca1-8ddd-f8d71603350d',
    },
    {
      'image': 'assets/ing.png',
      'title': 'Quiz de Inglês',
      'description': 'Treine seu inglês.',
      'url': 'https://kahoot.it/solo/?quizId=0e4e9011-8839-4195-9406-091e5fcb099a',
    },
    {
      'image': 'assets/art.png',
      'title': 'Quiz de Arte',
      'description': 'Aprimore sua criatividade.',
      'url': 'https://kahoot.it/solo/?quizId=8304b86c-d628-4d98-979d-5a9c5ee819b5',
    },
    {
      'image': 'assets/ed.png',
      'title': 'Quiz de Ed. Física',
      'description': 'Conheça os esportes.',
      'url': 'https://kahoot.it/solo/?quizId=005b4737-6e52-4fa8-972b-5f51cc27e757',
    },
  ];

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
      print('Sua url está sendo aberta: $e');
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
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/twinkle.png',
                height: 170,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/quiz.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Conheça nossos Quizzes',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                '· · • • • ✤ • • • · ·',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.redAccent,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _quizzes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final quiz = _quizzes[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.asset(
                              quiz['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            children: [
                              Text(
                                quiz['title']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                quiz['description']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                onPressed: () {
                                  final url = quiz['url'];
                                  if (url != null) {
                                    _launchInBrowser(url);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ),
                                child: const Text(
                                  'Jogar Agora',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
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
          currentIndex: 3,
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
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPage(
                  ),
                ),
              );
            } else if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilPage(
                    name: widget.name,
                    email: widget.email,
                    birthDate: widget.birthDate,
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
      ),
    );
  }
}
