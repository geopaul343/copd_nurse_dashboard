import 'package:flutter/material.dart';

PopupMenuButton<String> buildPatientPopupMenu({
  required Function(String) onSelected,
}) {
  return PopupMenuButton<String>(
    onSelected: onSelected,
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: 'add_patient',
        child: Text('Add Patient'),
      ),
      PopupMenuItem<String>(
        value: 'view_patients',
        child: Text('View Patients'),
      ),
    ],
    icon: Icon(Icons.more_vert),
  );
}