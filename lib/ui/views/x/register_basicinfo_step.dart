/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapify/ui/views/register_credentials_step.dart';
import '../../viewmodels/register_viewmodel.dart';

class RegisterBasicInfoStep extends StatelessWidget {
  const RegisterBasicInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Basic Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: registerViewModel.fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
                controller: registerViewModel.nationalityController,
                decoration: const InputDecoration(labelText: 'Nationality'),
              ),
              TextField(
                controller: registerViewModel.genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: registerViewModel.birthDateController,
                decoration:
                    const InputDecoration(labelText: 'Birth Date (YYYY-MM-DD)'),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterCredentialsStep()),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
*/