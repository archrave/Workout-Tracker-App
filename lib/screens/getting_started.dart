import 'package:flutter/material.dart';
import './auth_screen.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({Key key}) : super(key: key);
  static const routeName = '/getting-started-screen';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0.21 * height),
            Text(
              'Welcome!',
              style:
                  Theme.of(context).textTheme.bodyLarge.copyWith(fontSize: 32),
            ),
            SizedBox(height: 0.50 * height),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AuthScreen.routeName);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                child: Text(
                  'Get Started',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
