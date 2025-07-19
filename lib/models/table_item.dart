import 'dart:ui';

import 'package:weddinghall/config/enums.dart';

class TableItem {
  final String label;
  final String notes;
  final int chairCount;
  final Offset position;
  final TableShape shape;
  final String row; // Add this

  TableItem({
    required this.label,
    required this.shape,
    required this.notes,
    required this.chairCount,
    required this.position,
    required this.row,
  });

  TableItem copyWith({
    String? label,
    String? notes,
    int? chairCount,
    Offset? position,
    String? row,
  }) {
    return TableItem(
      label: label ?? this.label,
      notes: notes ?? this.notes,
      chairCount: chairCount ?? this.chairCount,
      position: position ?? this.position,
      row: row ?? this.row,
      shape: shape,
    );
  }
}
