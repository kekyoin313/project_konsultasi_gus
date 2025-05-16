import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Tambahkan ini
import 'EditScheduleScreen.dart';

class ViewSchedulesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Jadwal Konsultasi'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('schedules').orderBy('createdAt').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Belum ada jadwal konsultasi'));
          }

          final schedules = snapshot.data!.docs;

          return ListView.builder(
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              final scheduledAt = (schedule['scheduledAt'] as Timestamp).toDate();
              final formattedDate = DateFormat('yyyy-MM-dd').format(scheduledAt);
              final formattedTime = DateFormat('HH:mm').format(scheduledAt);

              return ListTile(
                title: Text('Konsultasi pada $formattedDate - $formattedTime'),
                subtitle: Text(schedule['description']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteSchedule(schedule.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScheduleScreen(
                        id: schedule.id,
                        currentDate: formattedDate,
                        currentTime: formattedTime,
                        currentDescription: schedule['description'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteSchedule(String id) async {
    await _firestore.collection('schedules').doc(id).delete();
  }
}
