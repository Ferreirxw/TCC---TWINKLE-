import 'package:flutter/material.dart';
import 'entrar.dart'; // Importa a página de login.
import 'cadastrar.dart'; // Importa a página de cadastro.
import 'camera_page.dart'; // Importa a página de câmera.


void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      routes: {
        '/entrar': (context) => const EntrarScreen(),
        '/cadastrar': (context) => const CadastrarScreen(),
        '/camera': (context) => CameraPage(),
      },
    );
  }
}
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFD6),
      body: Column(
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
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Seja Bem-Vindo(a)',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF0EFD6),
                  ),
                ),

                const SizedBox(height: 40),

                // Botão "ENTRAR"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBD3B3A),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EntrarScreen()), // Navega para a página de login
                    );
                  },
                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Botão "CADASTRAR"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBD3B3A),
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CadastrarScreen()), // Navega para a página de cadastro
                    );
                  },
                  child: const Text(
                    'CADASTRAR',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
