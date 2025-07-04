//4th attempt
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/config/enums.dart';
import 'package:weddinghall/res/app_colors.dart';

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

class TableWidget extends StatelessWidget {
  final TableItem table;
  final bool isPreview;

  const TableWidget({super.key, required this.table, this.isPreview = false});

  @override
  Widget build(BuildContext context) {
    double width = 100.w;
    double height = table.shape == TableShape.rectangle ? 60.h : 100.h;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            shape:
                table.shape == TableShape.round
                    ? BoxShape.circle
                    : BoxShape.rectangle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child:
              isPreview
                  ? null
                  : Center(
                    child: Container(
                      height: 28.h,
                      width: 28.w,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 25.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
        ),
        ..._buildChairs(table, width, height),
      ],
    );
  }

  // For rectangle/square tables: dynamically distribute chairs around the sides

  List<Widget> _buildChairs(TableItem table, double width, double height) {
    if (table.shape == TableShape.round) {
      const double paddingFromTable = 14;
      const double chairSize = 20; // Match with ChairWidget size
      final centerX = width / 2;
      final centerY = height / 2;
      final radius = min(centerX, centerY) + paddingFromTable;

      return List.generate(table.chairCount, (index) {
        final angle = (2 * pi / table.chairCount) * index;

        final chairX = centerX + radius * cos(angle) - (chairSize / 2);
        final chairY = centerY + radius * sin(angle) - (chairSize / 2);

        return Positioned(
          left: chairX,
          top: chairY,
          child: const ChairWidget(),
        );
      });
    }

    // Distribute chairs evenly on all 4 sides
    List<Widget> chairs = [];
    int chairsPerSide = (table.chairCount / 4).ceil();

    for (int i = 0; i < table.chairCount; i++) {
      int side = i ~/ chairsPerSide;
      double positionOnSide = (i % chairsPerSide + 1) / (chairsPerSide + 1);

      double left = 0, top = 0;

      switch (side) {
        case 0: // top
          left = width * positionOnSide - 10;
          top = -20;
          break;
        case 1: // right
          left = width - 10; // padding from right
          top = height * positionOnSide - 10;
          break;
        case 2: // bottom
          left = width * positionOnSide - 10;
          top = height - 10; // padding from bottom
          break;
        case 3: // left
          left = -20;
          top = height * positionOnSide - 10;
          break;
      }

      chairs.add(Positioned(left: left, top: top, child: const ChairWidget()));
    }

    return chairs;
  }
}

class ChairWidget extends StatelessWidget {
  final double size;

  const ChairWidget({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.black),
      ),
    );
  }
}

// class DraggableBoxScreen extends StatefulWidget {
//   const DraggableBoxScreen({super.key});

//   @override
//   State<DraggableBoxScreen> createState() => _DraggableBoxScreenState();
// }

// class _DraggableBoxScreenState extends State<DraggableBoxScreen> {
//   List<TableItem> tables = [
//     TableItem(position: const Offset(100, 100), shape: TableShape.square),
//     TableItem(position: const Offset(200, 300), shape: TableShape.round),
//     TableItem(position: const Offset(250, 180), shape: TableShape.rectangle),
//   ];
//   List<TableItem> editedTables = [];

//   void _updatePosition(int index, Offset newOffset) {
//     setState(() {
//       tables[index] = tables[index].copyWith(position: newOffset);
//     });
//   }

//   void _editTable(int index) async {
//     final updatedTable = await showDialog<TableItem>(
//       context: context,
//       builder: (context) => TableEditDialog(table: tables[index]),
//     );

//     if (updatedTable != null) {
//       setState(() {
//         tables[index] = updatedTable;
//         editedTables.add(updatedTable);
//       });

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => PreviewScreen(tables: editedTables)),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       appBar: AppBar(
//         leading: Center(
//           child: InkWell(
//             borderRadius: BorderRadius.circular(10.r),
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back,
//               size: 24,
//               color: AppColors.whiteColor,
//             ),
//           ),
//         ),
//         title: Text(
//           "Draggable Tables",
//           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//             color: AppColors.whiteColor,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         backgroundColor: AppColors.primaryColor,
//       ),
//       body: Stack(
//         children: [
//           for (int i = 0; i < tables.length; i++)
//             Positioned(
//               left: tables[i].position.dx,
//               top: tables[i].position.dy,
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   _updatePosition(i, tables[i].position + details.delta);
//                 },
//                 onTap: () => _editTable(i),
//                 child: TableWidget(table: tables[i]),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
class DraggableBoxScreen extends StatefulWidget {
  const DraggableBoxScreen({super.key});

  @override
  State<DraggableBoxScreen> createState() => _DraggableBoxScreenState();
}

class _DraggableBoxScreenState extends State<DraggableBoxScreen> {
  List<TableItem> tables = [
    TableItem(
      position: const Offset(100, 100),
      shape: TableShape.square,
      label: 'A1',
      notes: '',
      chairCount: 6,
      row: 'Row 1',
    ),
    TableItem(
      position: const Offset(200, 300),
      shape: TableShape.round,
      label: 'A2',
      notes: '',
      chairCount: 6,
      row: 'Row 1',
    ),
    TableItem(
      position: const Offset(250, 180),
      shape: TableShape.rectangle,
      label: 'A3',
      notes: '',
      chairCount: 6,
      row: 'Row 2',
    ),
  ];

  List<TableItem> editedTables = [];

  void _updatePosition(int index, Offset newOffset) {
    setState(() {
      tables[index] = tables[index].copyWith(position: newOffset);
    });
  }

  void _editTable(int index) async {
    final updatedTable = await showDialog<TableItem>(
      context: context,
      builder: (context) => TableEditDialog(table: tables[index]),
    );

    if (updatedTable != null) {
      setState(() {
        tables[index] = updatedTable;

        // If this table was edited before, update it, else add it
        final existingIndex = editedTables.indexWhere(
          (t) => t.label == updatedTable.label && t.row == updatedTable.row,
        );
        if (existingIndex >= 0) {
          editedTables[existingIndex] = updatedTable;
        } else {
          editedTables.add(updatedTable);
        }
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PreviewScreen(tables: editedTables)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 24,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        title: Text(
          "Draggable Tables",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          for (int i = 0; i < tables.length; i++)
            Positioned(
              left: tables[i].position.dx,
              top: tables[i].position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _updatePosition(i, tables[i].position + details.delta);
                },
                onTap: () => _editTable(i),
                child: TableWidget(table: tables[i]),
              ),
            ),
        ],
      ),
    );
  }
}

// class TableEditDialog extends StatefulWidget {
//   final TableItem table;

//   const TableEditDialog({super.key, required this.table});

//   @override
//   State<TableEditDialog> createState() => _TableEditDialogState();
// }

// class _TableEditDialogState extends State<TableEditDialog> {
//   late TextEditingController labelController;
//   late TextEditingController notesController;
//   late int chairCount;

//   @override
//   void initState() {
//     super.initState();
//     labelController = TextEditingController(text: widget.table.label);
//     notesController = TextEditingController(text: widget.table.notes);
//     chairCount = widget.table.chairCount;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.whiteColor,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(),
//           Text(
//             "Add Table",
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.close, size: 24.sp, color: AppColors.blackColor),
//           ),
//         ],
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 12.h),
//             TableWidget(
//               table: widget.table.copyWith(
//                 label: labelController.text,
//                 chairCount: chairCount,
//               ),
//               isPreview: true,
//             ),
//             SizedBox(height: 12.h),
//             TextField(
//               controller: labelController,
//               decoration: const InputDecoration(hintText: "Table Name"),
//             ),
//             TextField(
//               controller: notesController,
//               decoration: const InputDecoration(hintText: "Notes (optional)"),
//             ),
//             Row(
//               children: [
//                 const Text("Chairs: "),
//                 Expanded(
//                   child: Slider(
//                     value: chairCount.toDouble(),
//                     min: 4,
//                     max: 20,
//                     divisions: 16,
//                     thumbColor: AppColors.primaryColor,
//                     activeColor: AppColors.greyColor,
//                     inactiveColor: AppColors.greyColor,
//                     label: chairCount.toString(),
//                     onChanged: (value) {
//                       setState(() {
//                         chairCount = value.toInt();
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         Row(
//           children: [
//             Expanded(
//               child: TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: TextButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   "Cancel",
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                     color: AppColors.whiteColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 10.w),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(
//                     context,
//                     widget.table.copyWith(
//                       label: labelController.text,
//                       notes: notesController.text,
//                       chairCount: chairCount,
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   "Save",
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                     color: AppColors.whiteColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
class TableEditDialog extends StatefulWidget {
  final TableItem table;

  const TableEditDialog({super.key, required this.table});

  @override
  State<TableEditDialog> createState() => _TableEditDialogState();
}

class _TableEditDialogState extends State<TableEditDialog> {
  late TextEditingController labelController;
  late TextEditingController notesController;
  late int chairCount;
  late String selectedRow;

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.table.label);
    notesController = TextEditingController(text: widget.table.notes);
    chairCount = widget.table.chairCount;
    selectedRow = widget.table.row.isNotEmpty ? widget.table.row : 'Row 1';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Text(
            "Add Table",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, size: 24.sp, color: AppColors.blackColor),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            TableWidget(
              table: widget.table.copyWith(
                label: labelController.text,
                chairCount: chairCount,
              ),
              isPreview: true,
            ),
            SizedBox(height: 12.h),
            DropdownButtonFormField<String>(
              value: selectedRow,
              items:
                  ['Row 1', 'Row 2']
                      .map(
                        (row) => DropdownMenuItem(value: row, child: Text(row)),
                      )
                      .toList(),
              decoration: const InputDecoration(labelText: "Select Row"),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedRow = value;
                  });
                }
              },
            ),
            TextField(
              controller: labelController,
              decoration: const InputDecoration(
                hintText: "Table Name (A1, A2...)",
              ),
            ),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(hintText: "Notes (optional)"),
            ),
            Row(
              children: [
                const Text("Chairs: "),
                Expanded(
                  child: Slider(
                    value: chairCount.toDouble(),
                    min: 4,
                    max: 20,
                    divisions: 16,
                    thumbColor: AppColors.primaryColor,
                    activeColor: AppColors.greyColor,
                    inactiveColor: AppColors.greyColor,
                    label: chairCount.toString(),
                    onChanged: (value) {
                      setState(() {
                        chairCount = value.toInt();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    widget.table.copyWith(
                      label: labelController.text,
                      notes: notesController.text,
                      chairCount: chairCount,
                      row: selectedRow,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Save",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PreviewScreen extends StatefulWidget {
  final List<TableItem> tables;

  const PreviewScreen({super.key, required this.tables});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late List<TableItem> tables;

  @override
  void initState() {
    super.initState();
    // Copy initial list so we can modify positions
    tables = widget.tables.map((t) => t.copyWith()).toList();
  }

  void _updatePosition(int index, Offset newOffset) {
    setState(() {
      tables[index] = tables[index].copyWith(position: newOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      appBar: AppBar(
        leading: Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Preview Layout",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          for (int i = 0; i < tables.length; i++)
            Positioned(
              left: tables[i].position.dx,
              top: tables[i].position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _updatePosition(i, tables[i].position + details.delta);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TableWidget(table: tables[i], isPreview: true),
                    if (tables[i].label.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          "Name: ${tables[i].label}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    if (tables[i].notes.isNotEmpty)
                      Text(
                        "Notes: ${tables[i].notes}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        "Chairs: ${tables[i].chairCount}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (tables[i].label.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          "Name: ${tables[i].label}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    if (tables[i].row.isNotEmpty)
                      Text(
                        "Row: ${tables[i].row}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
