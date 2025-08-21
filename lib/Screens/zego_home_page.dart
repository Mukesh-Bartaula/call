import 'package:flutter/material.dart';
import 'package:video_call/Screens/screens.dart';

class ZegoHomePage extends StatefulWidget {
  const ZegoHomePage({super.key});

  @override
  State<ZegoHomePage> createState() => _ZegoHomePageState();
}

class _ZegoHomePageState extends State<ZegoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zego Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const VideoCall()),
                );
              },
              child: const Text('Video Call '),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const VoiceCall()),
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
