import 'dart:developer';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);
  static const routeName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  // In order to compare password and Confirm Password
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authFormKey = GlobalKey<FormState>();
  bool _passVisible = false;
  bool _confirmPassVisible = false;
  bool _signUpModeOn = true;

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
                if (_signUpModeOn)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: buildInputDecoration(
                          text: 'First Name',
                          prefixIcon: const Icon(Icons.person, size: 20)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Name cannot be empty!';
                        } else if (value.length == 1) {
                          return 'At least type two characters!';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _authData['name'] = value;
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: buildInputDecoration(
                      text: 'Email',
                      prefixIcon: const Icon(Icons.email, size: 20),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: buildInputDecoration(
                      text: 'Password',
                      prefixIcon: const Icon(Icons.lock, size: 20),
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
                    obscureText: !_passVisible,
                    validator: (value) {
                      if (value.isEmpty || value.length <= 5) {
                        return 'Password must be at least 6 characters long!';
                      }
                      return null;
                    },
                    textInputAction: _signUpModeOn
                        ? TextInputAction.next
                        : TextInputAction.done,
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                ),
                if (_signUpModeOn)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: buildInputDecoration(
                        text: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock, size: 20),
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
                      textInputAction: TextInputAction.done,
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
                        _signUpModeOn ? 'Sign Up' : 'Login',
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
                      onPressed: _changeAuthMode,
                      child: Text(
                        _signUpModeOn ? 'Login' : 'Create a New Account',
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
    FocusManager.instance.primaryFocus.unfocus();
  }

  void _changeAuthMode() {
    _authData['name'] = _nameController.text = '';
    _authData['email'] = _emailController.text = '';
    _authData['password'] = _passwordController.text = '';

    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      FocusManager.instance.primaryFocus.unfocus();
    }
    setState(() {
      _signUpModeOn = !_signUpModeOn;
    });
  }
}
