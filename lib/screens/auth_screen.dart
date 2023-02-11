import 'dart:developer';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);
  static const routeName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _passVisible = false;
  bool _confirmPassVisible = false;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  final _passwordController =
      TextEditingController(); // In order to compare password and Confirm Password
  final _authFormKey = GlobalKey<FormState>();

  InputDecoration buildInputDecoration(
      {@required String text, Widget prefixIcon, Widget suffixIcon}) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      // .copyWith(color: Colors.black38),
      label: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            .copyWith(color: Colors.black45),
      ),
      fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.20),
      filled: true,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _authFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.21 * height),
                Text('Create an Account',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: buildInputDecoration(text: 'First Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name cannot be empty!';
                      } else if (value.length == 1) {
                        return 'At least type two characters!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['name'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: buildInputDecoration(text: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: buildInputDecoration(
                      text: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _passVisible = !_passVisible;
                        }),
                        icon: _passVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: !_passVisible,
                    validator: (value) {
                      if (value.isEmpty || value.length <= 5) {
                        return 'Password must be at least 6 characters long!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: buildInputDecoration(
                      text: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () {
                            _confirmPassVisible = !_confirmPassVisible;
                          },
                        ),
                        icon: _confirmPassVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_confirmPassVisible,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30),
                      child: Text(
                        'Sign up',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodySmall.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_authFormKey.currentState.validate()) {
      return;
    }
    _authFormKey.currentState.save();
    log(_authData['name']);
    log(_authData['email']);
    log(_authData['password']);
  }

  void _changeAuthMode() {}
}
