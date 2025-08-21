import 'package:flutter/material.dart';
import 'package:video_call/Screens/screens.dart';

class AgoraHomePage extends StatelessWidget {
  const AgoraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agora Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VideoCallScreen(),
                  ),
                );
              },
              child: const Text('Video Call '),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VoiceCallScreen(),
                  ),
                );
              },

              child: const Text('Voice call '),
            ),
          ],
        ),
      ),
    );
  }
}
