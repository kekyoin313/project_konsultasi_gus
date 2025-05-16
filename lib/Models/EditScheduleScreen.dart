import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditScheduleScreen extends StatefulWidget {
  final String id;
  final String currentDate;
  final String currentTime;
  final String currentDescription;

  EditScheduleScreen({
    required this.id,
    required this.currentDate,
    required this.currentTime,
    required this.currentDescription,
  });

  @override
  _EditScheduleScreenState createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.currentDate);
    _timeController = TextEditingController(text: widget.currentTime);
    _descriptionController = TextEditingController(text: widget.currentDescription);
  }

  Future<void> _editSchedule() async {
    final date = _dateController.text;
    final time = _timeController.text;
    final description = _descriptionController.text;

    if (date.isEmpty || time.isEmpty || description.isEmpty) {
      return;
    }

    // Edit jadwal di Firestore
    await FirebaseFirestore.instance.collection('schedules').doc(widget.id).update({
      'date': date,
      'time': time,
      'description': description,
    });

    Navigator.pop(context); // Kembali setelah edit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Jadwal Konsultasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Tanggal Konsultasi'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Waktu Konsultasi'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi Konsultasi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editSchedule,
              child: Text('Edit Jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}
