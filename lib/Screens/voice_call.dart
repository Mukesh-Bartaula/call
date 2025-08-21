import 'package:flutter/material.dart';
import 'package:video_call/Screens/voice_call_page.dart';

class VoiceCall extends StatefulWidget {
  const VoiceCall({super.key});

  @override
  State<VoiceCall> createState() => _VoiceCallState();
}

class _VoiceCallState extends State<VoiceCall> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Voice Call')),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                hintText: 'Enter call id to join',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        VoiceCallPage(callID: codeController.text),
                  ),
                );
              },
              child: const Text('verify '),
            ),
          ],
        ),
      ),
    );
  }
}
