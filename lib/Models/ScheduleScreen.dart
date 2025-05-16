import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime? selectedDateTime;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  Future<void> _addSchedule() async {
    final description = _descriptionController.text;

    if (selectedDateTime == null || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Isi tanggal dan deskripsi terlebih dahulu.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('schedules').add({
        'scheduledAt': Timestamp.fromDate(selectedDateTime!),
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _descriptionController.clear();
      setState(() {
        selectedDateTime = null;
      });
      Navigator.pop(context);
    } catch (e) {
      print('Gagal menambahkan jadwal: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan jadwal. Silakan coba lagi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        selectedDateTime != null
            ? DateFormat('yyyy-MM-dd – HH:mm').format(selectedDateTime!)
            : 'Pilih Tanggal & Waktu';

    return Scaffold(
      appBar: AppBar(title: Text('Atur Jadwal Konsultasi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: _selectDateTime, child: Text(dateText)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi Konsultasi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addSchedule,
              child: Text('Tambah Jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}
