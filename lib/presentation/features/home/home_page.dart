import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Loged in'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/sign_in');
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
