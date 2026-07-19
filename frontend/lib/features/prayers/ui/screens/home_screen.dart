import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/fazr'),
              child: const Text('Go to Fazr'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/zuhr'),
              child: const Text('Go to Zuhr'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/asr'),
              child: const Text('Go to Asr'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/maghrib'),
              child: const Text('Go to Maghrib'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/isha'),
              child: const Text('Go to Isha'),
            ),
          ],
        ),
      ),
    );
  }
}
