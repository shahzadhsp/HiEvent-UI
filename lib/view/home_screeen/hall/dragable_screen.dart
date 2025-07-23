import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weddinghall/config/enums.dart';
import 'package:weddinghall/res/app_assets.dart';
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
    String imagePath;
    switch (table.shape) {
      case TableShape.square:
        imagePath = AppAssets.square;
        break;
      case TableShape.round:
        imagePath = AppAssets.circle;
        break;
      case TableShape.rectangle:
        imagePath = AppAssets.rectangle;
        break;
    }

    double width = 140.w;
    double height = table.shape == TableShape.rectangle ? 200.h : 100.h;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(imagePath, width: width, height: height, fit: BoxFit.cover),
        ..._buildChairs(table, width, height, isPreview),
      ],
    );
  }

  // build chairs based on table shape and count
  // This method calculates chair positions based on the table shape and chair count

  List<Widget> _buildChairs(
    TableItem table,
    double width,
    double height,
    bool isPreview,
  ) {
    const double chairSize = 80;
    List<Widget> chairs = [];
    // Limit max chairs to 20
    int totalChairs = table.chairCount.clamp(0, 20);
    // Chairs per side: top, right, bottom, left
    List<int> chairsPerSide = [0, 0, 0, 0];
    if (table.shape == TableShape.rectangle) {
      // chairsPerSide = [4, 1, 4, 1];
      // totalChairs = 16;
      for (int i = 0; i < totalChairs; i++) {
        chairsPerSide[i % 4]++;
      }
    } else if (table.shape == TableShape.round) {
      // chairsPerSide = [2, 2, 2, 2];
      // totalChairs = 8;
      for (int i = 0; i < totalChairs; i++) {
        chairsPerSide[i % 4]++;
      }
    } else {
      // Square or fallback: evenly distribute
      for (int i = 0; i < totalChairs; i++) {
        chairsPerSide[i % 4]++;
      }
    }

    int chairsPlaced = 0;

    for (int side = 0; side < 4 && chairsPlaced < totalChairs; side++) {
      int chairsOnThisSide = chairsPerSide[side];
      for (int i = 0; i < chairsOnThisSide; i++) {
        // double positionOnSide = (i + 1) / (chairsOnThisSide + 1);
        double positionOnSide;
        if (table.shape == TableShape.round) {
          positionOnSide = (i + 1.2) / (chairsOnThisSide + 1.3);
        } else if (table.shape == TableShape.rectangle) {
          // Slightly more spacing for longer sides
          positionOnSide = (i + 3) / (chairsOnThisSide + 5);
        } else if (table.shape == TableShape.square) {
          // Tighten spacing slightly for square
          positionOnSide = (i + 1.1) / (chairsOnThisSide + 1.5);
        } else {
          // fallback
          positionOnSide = (i + 1) / (chairsOnThisSide + 1);
        }

        double left = 0, top = 0;

        switch (side) {
          case 0: // Top
            left = width * positionOnSide - (chairSize / 1.7);
            if (table.shape == TableShape.round) {
              top = -35;
            } else if (table.shape == TableShape.rectangle) {
              top = 42;
            } else if (table.shape == TableShape.square) {
              top = -33;
            }
            break;
          case 1: // Right
            top = height * positionOnSide - (chairSize / 1.7);
            if (table.shape == TableShape.round) {
              left = 88;
            } else if (table.shape == TableShape.rectangle) {
              left = 113;
            } else if (table.shape == TableShape.square) {
              left = 83;
            }
            break;

          case 2: // Bottom
            left = width * positionOnSide - (chairSize / 2);
            if (table.shape == TableShape.round) {
              top = 65;
            } else if (table.shape == TableShape.rectangle) {
              top = 114;
            } else if (table.shape == TableShape.square) {
              top = 59;
            }
            break;

          case 3: // Left
            top = height * positionOnSide - (chairSize / 1.7);
            if (table.shape == TableShape.round) {
              left = -22;
            } else if (table.shape == TableShape.rectangle) {
              left = -44;
            } else if (table.shape == TableShape.square) {
              left = -15;
            }
            break;
        }

        double rotationAngle;
        switch (side) {
          case 0:
            rotationAngle = 0;
            break;
          case 1:
            rotationAngle = pi / 2;
            break;
          case 2:
            rotationAngle = pi;
            break;
          case 3:
            rotationAngle = -pi / 2;
            break;
          default:
            rotationAngle = 0;
        }

        chairs.add(
          Positioned(
            left: left,
            top: top,
            child: Transform.rotate(
              angle: rotationAngle,
              child: ChairWidget(size: chairSize),
            ),
          ),
        );

        chairsPlaced++;
      }
    }

    return chairs;
  }
}

// chair widget
class ChairWidget extends StatelessWidget {
  final double size;

  const ChairWidget({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: size.h,
      child: Image.asset(
        AppAssets.chairPng,
        height: size.h,
        width: size.w,
        color: AppColors.whiteColor,
      ),
    );
  }
}

class DraggableBoxScreen extends StatefulWidget {
  const DraggableBoxScreen({super.key});

  @override
  State<DraggableBoxScreen> createState() => _DraggableBoxScreenState();
}

class _DraggableBoxScreenState extends State<DraggableBoxScreen> {
  bool isShowTable = false;

  Future<SpecialTableItem?> showSpecialTableDialog(
    BuildContext context,
    SpecialTableItem table,
  ) {
    TextEditingController customLabelController = TextEditingController(
      text: table.label,
    );
    int chairCount = table.chairCount;
    bool isShowChairs = table.showChairs;

    String selectedOption =
        ['Bar', 'Cafe', 'Dj', 'Details'].contains(table.label)
            ? table.label
            : 'Enter Name';

    return showDialog<SpecialTableItem>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: Text("Customize Table"),
          content: StatefulBuilder(
            builder:
                (context, setState) => SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<String>(
                        value: selectedOption,
                        items:
                            [
                              'Bar',
                              'Cafe',
                              'Dj',
                              'Details',
                              'Gifts',
                              'Guestbook',
                              'Podium',
                              'Other',
                              'Stage',
                              'Photo Booth',
                              'Dance Floor',
                              'CustomName',
                            ].map((label) {
                              return DropdownMenuItem(
                                value: label,
                                child: Text(label),
                              );
                            }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => selectedOption = value);
                          }
                        },
                      ),
                      if (selectedOption == 'CustomName')
                        TextField(
                          controller: customLabelController,
                          decoration: InputDecoration(
                            hintText: "Enter custom name",
                          ),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        "Chairs: $chairCount",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Slider(
                        value: chairCount.toDouble(),
                        min: 4,
                        max: 20,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.greyColor,
                        divisions: 16,
                        onChanged: (value) {
                          setState(() => chairCount = value.toInt());
                        },
                      ),
                      // Only show table+chairs preview if isShowChairs is true
                      isShowChairs
                          ? Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                color: AppColors.primaryColor,
                                child: Stack(
                                  children: List.generate(chairCount, (index) {
                                    final angle =
                                        2 * 3.1415926 * index / chairCount;
                                    final radius = 40.0;
                                    final dx =
                                        50 +
                                        radius * cos(angle) -
                                        10; // center - half chair size
                                    final dy = 50 + radius * sin(angle) - 10;
                                    return Positioned(
                                      left: dx,
                                      top: dy,
                                      child: ChairWidget(size: 28),
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          )
                          : const SizedBox.shrink(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isShowChairs = isShowChairs;
                          });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              Checkbox(
                                value: isShowChairs,
                                onChanged: (value) {
                                  setState(() {
                                    isShowChairs = value!;
                                  });
                                },
                              ),
                              Text(isShowChairs ? 'No chairs' : 'Add Chairs'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final label =
                          selectedOption == 'CustomName'
                              ? customLabelController.text
                              : selectedOption;

                      Navigator.pop(context);

                      Future.delayed(const Duration(milliseconds: 100), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => PreviewScreen(
                                  tables: editedTables,
                                  specialTable: table.copyWith(
                                    label: label,
                                    chairCount: chairCount,
                                    showChairs: isShowChairs,
                                  ),
                                ),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  SpecialTableItem specialTable = SpecialTableItem(
    position: const Offset(150, 150),
    label: 'Bar',
    chairCount: 4,
    showChairs: true,
  );

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
        MaterialPageRoute(
          builder:
              (_) => PreviewScreen(
                tables: editedTables,
                specialTable: specialTable,
              ),
        ),
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
      body: InteractiveViewer(
        panEnabled: true,
        scaleEnabled: true,
        minScale: 0.5,
        maxScale: 3.0,
        // boundaryMargin: const EdgeInsets.all(100),
        child: Stack(
          children: [
            for (int i = 0; i < tables.length; i++)
              Positioned(
                left: tables[i].position.dx,
                top: tables[i].position.dy,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanUpdate: (details) {
                    _updatePosition(i, tables[i].position + details.delta);
                  },
                  onTap: () => _editTable(i),
                  child: TableWidget(table: tables[i], isPreview: false),
                ),
              ),
            Positioned(
              left: specialTable.position.dx,
              top: specialTable.position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    specialTable = specialTable.copyWith(
                      position: specialTable.position + details.delta,
                    );
                  });
                },
                onTap: () async {
                  final updated = await showSpecialTableDialog(
                    context,
                    specialTable,
                  );
                  if (updated != null) {
                    setState(() => specialTable = updated);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PreviewScreen(
                              tables: editedTables,
                              specialTable: updated,
                            ),
                      ),
                    );
                  }
                },
                child: SpecialTableWidget(table: specialTable),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialTableWidget extends StatelessWidget {
  final SpecialTableItem table;
  const SpecialTableWidget({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    // Size depends on chair count
    double size = 60 + (table.chairCount * 4).toDouble();
    return Column(
      children: [
        Container(
          width: size.w,
          height: size.h,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: Text(table.label, style: TextStyle(color: Colors.black)),
        ),
        SizedBox(height: 4.h),
        Text(
          "${table.chairCount} chairs",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

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
      backgroundColor: Colors.grey.shade300,
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
        child: StatefulBuilder(
          builder: (context, setInnerState) {
            return Column(
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
                            (row) =>
                                DropdownMenuItem(value: row, child: Text(row)),
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
                  decoration: const InputDecoration(
                    hintText: "Notes (optional)",
                  ),
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
            );
          },
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
  final SpecialTableItem? specialTable;

  const PreviewScreen({super.key, required this.tables, this.specialTable});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late List<TableItem> tables;
  List<ChairItem> chairs = [];
  SpecialTableItem? specialTable;

  @override
  void initState() {
    super.initState();
    tables = widget.tables.map((t) => t.copyWith()).toList();
    specialTable = widget.specialTable?.copyWith();
    chairs = [
      ChairItem(position: const Offset(50, 50)),
      ChairItem(position: const Offset(60, 50)),
      ChairItem(position: const Offset(70, 50)),
    ];
  }

  void _updateTablePosition(int index, Offset newOffset) {
    setState(() {
      tables[index] = tables[index].copyWith(position: newOffset);
    });
  }

  void _updateChairPosition(int index, Offset newOffset) {
    setState(() {
      // Store the old table index before moving
      final oldTableIndex = chairs[index].tableIndex;
      // Update the chair position
      chairs[index].position = newOffset;
      // Find if the chair is now over a table
      final newTableIndex = _getTableIndexUnderChair(chairs[index]);
      // If the chair was previously attached to a different table, remove it from that table's count
      if (oldTableIndex != null && oldTableIndex != newTableIndex) {
        tables[oldTableIndex] = tables[oldTableIndex].copyWith(
          chairCount: tables[oldTableIndex].chairCount - 1,
        );
        chairs[index].attachedToTable = false;
        chairs[index].tableIndex = null;
      }

      // If the chair is now over a table and wasn't already attached to this table
      // if (newTableIndex != null &&
      //     (oldTableIndex != newTableIndex || !chairs[index].attachedToTable)) {
      //   tables[newTableIndex] = tables[newTableIndex].copyWith(
      //     chairCount: tables[newTableIndex].chairCount + 1,
      //   );
      //   chairs[index].attachedToTable = true;
      //   chairs[index].tableIndex = newTableIndex;
      // }
      if (newTableIndex != null &&
          (oldTableIndex != newTableIndex || !chairs[index].attachedToTable)) {
        tables[newTableIndex] = tables[newTableIndex].copyWith(
          chairCount: tables[newTableIndex].chairCount + 1,
        );
        chairs[index].attachedToTable = true;
        chairs[index].tableIndex = newTableIndex;

        // ✅ NEW: Remove the chair from screen once attached
        chairs.removeAt(index);
      }

      // If the chair is no longer over any table (and was previously attached)
      if (newTableIndex == null && oldTableIndex != null) {
        chairs[index].attachedToTable = false;
        chairs[index].tableIndex = null;
      }
    });
  }

  int? _getTableIndexUnderChair(ChairItem chair) {
    for (int i = 0; i < tables.length; i++) {
      final table = tables[i];
      final tableRect = Rect.fromLTWH(
        table.position.dx,
        table.position.dy,
        260.w,
        table.shape == TableShape.rectangle ? 140.h : 140.h,
      );

      // You might need to adjust this radius based on your chair size
      final chairRect = Rect.fromCircle(center: chair.position, radius: 15.w);
      if (tableRect.overlaps(chairRect)) {
        return i;
      }
    }
    return null;
  }

  void _deleteChair(int index) {
    setState(() {
      final chair = chairs[index];
      if (chair.attachedToTable && chair.tableIndex != null) {
        tables[chair.tableIndex!] = tables[chair.tableIndex!].copyWith(
          chairCount: tables[chair.tableIndex!].chairCount - 1,
        );
      }
      chairs.removeAt(index);
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
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, size: 24.sp, color: Colors.white),
          ),
        ),
        centerTitle: true,
        title: Text("Preview Layout", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            chairs.add(ChairItem(position: const Offset(100, 100)));
          });
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.chair, color: Colors.deepPurple),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Tables
          for (int i = 0; i < tables.length; i++)
            Positioned(
              left: tables[i].position.dx,
              top: tables[i].position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _updateTablePosition(i, tables[i].position + details.delta);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TableWidget(table: tables[i], isPreview: true),
                    SizedBox(height: 16.h),
                    Text(
                      "Name: ${tables[i].label}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    if (tables[i].notes.isNotEmpty)
                      Text(
                        "Notes: ${tables[i].notes}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    Text(
                      "Chairs: ${tables[i].chairCount}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Text(
                      "Row: ${tables[i].row}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Chairs
          for (int i = 0; i < chairs.length; i++)
            Positioned(
              left: chairs[i].position.dx,
              top: chairs[i].position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _updateChairPosition(i, chairs[i].position + details.delta);
                },
                onLongPress: () => _deleteChair(i),
                child: ChairWidget(size: 80),
              ),
            ),
          if (specialTable != null)
            Positioned(
              left: specialTable!.position.dx,
              top: specialTable!.position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    specialTable = specialTable!.copyWith(
                      position: specialTable!.position + details.delta,
                    );
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpecialTableWidget(table: specialTable!),
                    SizedBox(height: 8.h),
                    Text(
                      "Name: ${specialTable!.label}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Chairs: ${specialTable!.chairCount}",
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

class ChairItem {
  Offset position;
  bool attachedToTable;
  int? tableIndex;

  ChairItem({
    required this.position,
    this.attachedToTable = false,
    this.tableIndex,
  });

  ChairItem copyWith({
    Offset? position,
    bool? attachedToTable,
    int? tableIndex,
  }) {
    return ChairItem(
      position: position ?? this.position,
      attachedToTable: attachedToTable ?? this.attachedToTable,
      tableIndex: tableIndex ?? this.tableIndex,
    );
  }
}

// class SpecialTableItem {
//   final Offset position;
//   final String label;
//   final int chairCount;

//   SpecialTableItem({
//     required this.position,
//     required this.label,
//     required this.chairCount,
//   });

//   SpecialTableItem copyWith({
//     Offset? position,
//     String? label,
//     int? chairCount,
//   }) {
//     return SpecialTableItem(
//       position: position ?? this.position,
//       label: label ?? this.label,
//       chairCount: chairCount ?? this.chairCount,
//     );
//   }
// }

class SpecialTableItem {
  final String label;
  final int chairCount;
  final Offset position;
  final bool showChairs; // <-- Add this

  SpecialTableItem({
    required this.label,
    required this.chairCount,
    required this.position,
    required this.showChairs,
  });

  SpecialTableItem copyWith({
    String? label,
    int? chairCount,
    Offset? position,
    bool? showChairs,
  }) {
    return SpecialTableItem(
      label: label ?? this.label,
      chairCount: chairCount ?? this.chairCount,
      position: position ?? this.position,
      showChairs: showChairs ?? this.showChairs,
    );
  }
}
