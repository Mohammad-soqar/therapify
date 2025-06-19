/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/register_viewmodel.dart';
import 'home/home_view.dart';

class RegisterCredentialsStep extends StatelessWidget {
  const RegisterCredentialsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Credentials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: registerViewModel.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: registerViewModel.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await registerViewModel.registerUser();
                  Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (_) =>const HomeView()),
                   );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/