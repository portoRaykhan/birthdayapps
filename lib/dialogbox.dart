import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'homepage.dart';

class BirthdaySurpriseScreen extends StatelessWidget {
  final TextEditingController _wishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ulang Tahun'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
              child: GestureDetector(
                onTap: () {
                  _showBirthdayDialog(context);
                },
                child: Lottie.network(
                  'https://lottie.host/38afcb07-4068-49ad-9280-be30b859fa8b/SQu1epmejB.json',
                  repeat: true,
                  reverse: true,
                  animate: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBirthdayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Selamat Ulang Tahun',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Apa permohonanmu tahun ini?'),
                SizedBox(height: 8.0),
                TextField(
                  controller: _wishController,
                  decoration: InputDecoration(
                    labelText: 'Permohonan',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    await _sendWishToTelegram(_wishController.text);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Text('Lanjutkan Tour'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _sendWishToTelegram(String wish) async {
    final telegramBotToken = '6350484730:AAFYWPwzWS4xiPybsvshNObQO75FPu_tpCw';
    final chatId = '5581419910'; // Ganti dengan ID grup Anda

    final url = 'https://api.telegram.org/bot$telegramBotToken/sendMessage';
    final data = {'chat_id': chatId, 'text': wish};

    try {
      final response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        print('Pesan terkirim ke Telegram.');
      } else {
        print(
            'Gagal mengirim pesan ke Telegram. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Gagal mengirim permohonan ke Telegram: $e');
    }
  }
}
