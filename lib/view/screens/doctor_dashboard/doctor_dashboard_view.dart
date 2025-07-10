import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'doctor_dashboard_viewmodel.dart';
import 'package:therapify/view/screens/doctor_dashboard/doctor_dashboard_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorDashboardView extends StatelessWidget {
  const DoctorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DoctorDashboardViewModel()..loadData(),
      child: const _DoctorDashboardTabs(),
    );
  }
}

class _DoctorDashboardTabs extends StatelessWidget {
  const _DoctorDashboardTabs();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Doctor Dashboard"),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const NotificationDialog(),
                );
              },
            )
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Dashboard"),
              Tab(text: "Appointments"),
              Tab(text: "Patients"),
              Tab(text: "Settings"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DashboardTab(),
            AppointmentsTab(),
            PatientsTab(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}

// ✅ DASHBOARD TAB
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoctorDashboardViewModel>(context);

    if (viewModel.isLoading || viewModel.stats == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final stats = viewModel.stats!;
    final recentPatients = viewModel.patients.take(3).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatCard(
                  label: "Patients", value: stats.totalPatients.toString()),
              _StatCard(
                  label: "Appointments",
                  value: stats.totalAppointments.toString()),
              _StatCard(
                  label: "Earnings",
                  value: "\$${stats.totalEarnings.toStringAsFixed(0)}"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Available to take appointments",
                  style: TextStyle(fontSize: 16)),
              Switch(
                value: stats.isAvailable,
                onChanged: (val) => viewModel.toggleAvailability(),
              )
            ],
          ),
          const SizedBox(height: 30),
          const Text("Recent Patients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...recentPatients.map((patient) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(patient.name),
                subtitle: Text("Age: ${patient.age} | ${patient.condition}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Open patient details coming soon.")),
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// ✅ APPOINTMENTS TAB
class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoctorDashboardViewModel>(context);

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final appointments = viewModel.appointments;

    if (appointments.isEmpty) {
      return const Center(child: Text("No upcoming appointments"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appt = appointments[index];
        final formattedDate =
            "${appt.dateTime.day}/${appt.dateTime.month}/${appt.dateTime.year}";
        final formattedTime =
            "${appt.dateTime.hour.toString().padLeft(2, '0')}:${appt.dateTime.minute.toString().padLeft(2, '0')}";

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(appt.patientName),
            subtitle: Text("Date: $formattedDate\nTime: $formattedTime"),
            isThreeLine: true,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Open appointment detail coming soon.")),
              );
            },
          ),
        );
      },
    );
  }
}
// ✅ PATIENTS TAB
class PatientsTab extends StatelessWidget {
  const PatientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoctorDashboardViewModel>(context);

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final patients = viewModel.patients;

    if (patients.isEmpty) {
      return const Center(child: Text("No patients found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(patient.name),
            subtitle: Text("Age: ${patient.age} | ${patient.condition}"),
            trailing: const Icon(Icons.note_alt),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => PatientNoteDialog(patient: patient),
              );
            },
          ),
        );
      },
    );
  }
}
// ✅ PATIENT NOTE DIALOG
class PatientNoteDialog extends StatefulWidget {
  final Patient patient;

  const PatientNoteDialog({super.key, required this.patient});

  @override
  State<PatientNoteDialog> createState() => _PatientNoteDialogState();
}

class _PatientNoteDialogState extends State<PatientNoteDialog> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Notes for ${widget.patient.name}"),
      content: TextField(
        controller: _noteController,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: "Write your notes here...",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Note saved (locally only)")),
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
// ✅ NOTIFICATION DIALOG
class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Notifications"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: const [
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("New appointment request from Sarah"),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text("Session with John starts in 1 hour"),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("You've received a 5⭐ review"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        )
      ],
    );
  }
}
// ✅ SETTINGS TAB
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _workingInController = TextEditingController();

  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);

  bool _isAvailable = true;
  String _doctorName = "";

  int _selectedConsultationTime = 30;
  final List<int> _consultationTimeOptions = [15, 30, 45, 60];

  @override
  void initState() {
    super.initState();
    _loadDoctorData();
  }

  Future<void> _loadDoctorData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(userId)
        .get();
    final data = doc.data();
    if (data != null) {
      setState(() {
        _doctorName = data['name'] ?? '';
        _bioController.text = data['bio'] ?? '';
        _workingInController.text = data['workingIn'] ?? '';
        _selectedConsultationTime = data['averageConsultationTime'] ?? 30;
        _isAvailable = data['isAvailable'] ?? true;
      });
    }
  }

  Future<void> _saveSettings() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final now = DateTime.now();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat dayFormat = DateFormat('EEEE');

    List<Map<String, dynamic>> schedule = [];

    if (_isAvailable) {
      for (int i = 0; i < 7; i++) {
        final currentDate = now.add(Duration(days: i));
        final formattedDate = dateFormat.format(currentDate);
        final formattedDay = dayFormat.format(currentDate);

        List<String> slots = [];
        DateTime slotTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          _startTime.hour,
          _startTime.minute,
        );

        final endSlotTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          _endTime.hour,
          _endTime.minute,
        );

        while (slotTime.isBefore(endSlotTime)) {
          slots.add(DateFormat('HH:mm').format(slotTime));
          slotTime = slotTime.add(Duration(minutes: _selectedConsultationTime));
        }

        schedule.add({
          'day': formattedDay,
          'date': formattedDate,
          'timeSlots': slots,
        });
      }
    }

    await FirebaseFirestore.instance.collection('doctors').doc(userId).update({
      'bio': _bioController.text,
      'workingIn': _workingInController.text,
      'averageConsultationTime': _selectedConsultationTime,
      'isAvailable': _isAvailable,
      'availabilityDate': dateFormat.format(now),
      'availabilityTime': _startTime.format(context),
      'schedule': schedule,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Settings saved successfully")),
    );
  }

  Future<void> _pickTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text("Profile Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: _doctorName.isEmpty ? "Loading..." : _doctorName,
            ),
          ),
          const SizedBox(height: 20),

          const Text("Availability",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Available for appointments"),
              Switch(
                value: _isAvailable,
                onChanged: (val) => setState(() => _isAvailable = val),
              ),
            ],
          ),

          if (_isAvailable) ...[
            const SizedBox(height: 20),
            const Text("Available Time Slot",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("Start Time"),
                    ElevatedButton(
                      onPressed: () => _pickTime(context, true),
                      child: Text(_startTime.format(context)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("End Time"),
                    ElevatedButton(
                      onPressed: () => _pickTime(context, false),
                      child: Text(_endTime.format(context)),
                    ),
                  ],
                ),
              ],
            ),
          ],

          const SizedBox(height: 20),
          const Text("Average Consultation Time",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            value: _selectedConsultationTime,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedConsultationTime = value;
                });
              }
            },
            items: _consultationTimeOptions.map((int time) {
              return DropdownMenuItem<int>(
                value: time,
                child: Text('$time minutes'),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),
          const Text("Working In",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _workingInController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Where do you currently work?",
            ),
          ),

          const SizedBox(height: 20),
          const Text("Bio",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _bioController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Write a short bio",
            ),
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _saveSettings,
            child: const Text("Save Settings"),
          ),
        ],
      ),
    );
  }
}