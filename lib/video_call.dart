import 'package:flutter/material.dart';
import 'package:video_call/video_call_page.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({super.key});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Video Call')),
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
                try {
                  if (codeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a call ID')),
                    );
                    return;
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoCallPage(callID: codeController.text),
                      ),
                    );
                  }
                } catch (e) {
                  print('The error is :$e');
                }
              },
              child: const Text('verify '),
            ),
          ],
        ),
      ),
    );
  }
}
