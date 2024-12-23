import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String? result; // Variável para armazenar o QR Code lido
  String currentMessage = 'Seja bem-vindo(a)!'; // Mensagem inicial do rodapé
  List<String> messages = [
    'Seja bem-vindo(a)!',
    'Vamos explorar juntos!',
    'Descubra algo incrível!'
  ]; // Lista de mensagens para alternar
  int messageIndex = 0; // Índice da mensagem atual
  Timer? messageTimer; // Timer para alternar mensagens

  @override
  void initState() {
    super.initState();
    _startMessageTimer();
  }

  @override
  void dispose() {
    messageTimer?.cancel(); // Cancela o Timer quando a página é destruída
    super.dispose();
  }

  void _startMessageTimer() {
    messageTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        messageIndex = (messageIndex + 1) % messages.length; // Alterna entre as mensagens
        currentMessage = messages[messageIndex];
      });
    });
  }

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
      appBar: AppBar(
        title: Text(
          "Realidade Aumentada",
          style: TextStyle(color: Colors.red), // Cor do texto do cabeçalho
        ),
        backgroundColor: const Color(0xFFF0EFD6), // Define o cabeçalho amarelo
        iconTheme: IconThemeData(color: Colors.red), // Cor dos ícones do cabeçalho, se houver
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (barcodeCapture) {
                final String? code = barcodeCapture.barcodes.first.rawValue;
                if (code != null && code != result) {
                  setState(() {
                    result = code; // Armazena o código lido para evitar leituras duplicadas
                  });
                  print("QR Code detectado: $result");
                  _launchInBrowser(code);
                }
              },
            ),
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'QR Code Detectado: $result',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.red), // Texto em vermelho
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFF0EFD6), // Cor do rodapé
        child: Container(
          height: 100, // Define a altura total do rodapé
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Texto centralizado
              Center(
                child: Text(
                  currentMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // Texto em vermelho
                  ),
                ),
              ),
              // Imagem à direita
              Positioned(
                right: -10, // Ajuste a margem direita da imagem
                child: Image.asset(
                  'assets/character.gif',
                  width: 80, // Ajuste a largura conforme necessário
                  height: 70, // Ajuste a altura conforme necessário
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
