import 'package:flutter/material.dart';
import 'package:video_call/Screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Home Page')),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AgoraHomePage(),
                  ),
                );
              },
              child: const Text('Agora Provider '),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ZegoHomePage()),
                );
              },
              child: const Text('Zego Provider '),
            ),
          ],
        ),
      ),
    );
  }
}
