import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';
import 'package:weddinghall/config/enums.dart';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';

class TableItem {
  final String label;
  final String notes;
  final int chairCount;
  final Offset position;
  final TableShape shape;
  final String row;
  final double rotationAngle;

  TableItem({
    required this.label,
    required this.shape,
    required this.notes,
    required this.chairCount,
    required this.position,
    required this.row,
    this.rotationAngle = 0.0,
  });

  TableItem copyWith({
    String? label,
    String? notes,
    int? chairCount,
    Offset? position,
    TableShape? shape,
    String? row,
    double? rotationAngle,
  }) {
    return TableItem(
      label: label ?? this.label,
      notes: notes ?? this.notes,
      chairCount: chairCount ?? this.chairCount,
      position: position ?? this.position,
      shape: shape ?? this.shape,
      row: row ?? this.row,
      rotationAngle: rotationAngle ?? this.rotationAngle,
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

    // double width = 140.w;
    // double height = table.shape == TableShape.rectangle ? 200.h : 100.h;
    double baseSize = 80.0;
    double sizeIncrement = 5.0;
    double sizeDecrement = 4.0;

    double width;
    double height;

    switch (table.shape) {
      case TableShape.square:
        width = baseSize + (table.chairCount * sizeIncrement);
        height = width; // square: same width and height
        break;

      case TableShape.round:
        width = baseSize + (table.chairCount * sizeIncrement);
        height = width; // circle too: same width and height
        break;

      case TableShape.rectangle:
        width = baseSize + (table.chairCount * sizeIncrement);
        height = width * 1.4; // rectangle: longer height
        break;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width,
          height: height,
          curve: Curves.easeInOut,
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        ..._buildChairs(table, width, height, isPreview),
      ],
    );
  }

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
              // Top
              if (table.chairCount < 3) {
                top = 40;
              } else if (table.chairCount < 4) {
                top = -27;
              } else if (table.chairCount < 5) {
                top = -36;
              } else if (table.chairCount < 6) {
                top = -33;
              } else if (table.chairCount < 7) {
                top = -33;
              } else if (table.chairCount < 8) {
                top = -33;
              } else if (table.chairCount < 9) {
                top = -31;
              } else if (table.chairCount < 10) {
                top = -30;
              } else if (table.chairCount < 11) {
                top = -30;
              } else if (table.chairCount < 12) {
                top = -27;
              } else if (table.chairCount < 13) {
                top = -25;
              } else if (table.chairCount < 14) {
                top = -24;
              } else if (table.chairCount < 15) {
                top = -24;
              } else if (table.chairCount < 16) {
                top = -24;
              } else if (table.chairCount < 17) {
                top = -23;
              } else if (table.chairCount < 18) {
                top = -22;
              } else if (table.chairCount < 19) {
                top = -23;
              } else if (table.chairCount < 20) {
                top = -23;
              } else {
                top = -23; // 20 or more
              }
            } else if (table.shape == TableShape.rectangle) {
              if (table.chairCount < 3) {
                top = 12;
              } else if (table.chairCount < 4) {
                top = -27;
              } else if (table.chairCount < 5) {
                top = 1;
              } else if (table.chairCount < 6) {
                top = 3;
              } else if (table.chairCount < 7) {
                top = 3.1;
              } else if (table.chairCount < 8) {
                top = 4.6;
              } else if (table.chairCount < 9) {
                top = 7;
              } else if (table.chairCount < 10) {
                top = 10.6;
              } else if (table.chairCount < 11) {
                top = 12;
              } else if (table.chairCount < 12) {
                top = 16;
              } else if (table.chairCount < 13) {
                top = 18;
              } else if (table.chairCount < 14) {
                top = 19;
              } else if (table.chairCount < 15) {
                top = 23;
              } else if (table.chairCount < 16) {
                top = 28;
              } else if (table.chairCount < 17) {
                top = 30;
              } else if (table.chairCount < 18) {
                top = 32;
              } else if (table.chairCount < 19) {
                top = 34.5;
              } else if (table.chairCount < 20) {
                top = 38;
              } else {
                top = 40; // 20 or more
              }
            } else if (table.shape == TableShape.square) {
              // Top
              if (table.chairCount < 3) {
                top = -25;
              } else if (table.chairCount < 4) {
                top = -27;
              } else if (table.chairCount < 5) {
                top = -30;
              } else if (table.chairCount < 6) {
                top = -30;
              } else if (table.chairCount < 7) {
                top = -28;
              } else if (table.chairCount < 8) {
                top = -27;
              } else if (table.chairCount < 9) {
                top = -26;
              } else if (table.chairCount < 10) {
                top = -26;
              } else if (table.chairCount < 11) {
                top = -25;
              } else if (table.chairCount < 12) {
                top = -24;
              } else if (table.chairCount < 13) {
                top = -22;
              } else if (table.chairCount < 14) {
                top = -22;
              } else if (table.chairCount < 15) {
                top = -21;
              } else if (table.chairCount < 16) {
                top = -20;
              } else if (table.chairCount < 17) {
                top = -19;
              } else if (table.chairCount < 18) {
                top = -18;
              } else if (table.chairCount < 19) {
                top = -17;
              } else if (table.chairCount < 20) {
                top = -17;
              } else {
                top = -15; // 20 or more
              }
            }
            break;
          case 1: // Right
            top = height * positionOnSide - (chairSize / 1.7);
            if (table.shape == TableShape.round) {
              if (table.chairCount < 5) {
                left = width - (chairSize / 1.3);
              } else if (table.chairCount < 6) {
                left = width - (chairSize / 1.3);
              } else if (table.chairCount < 7) {
                left = width - (chairSize / 1.3);
              } else if (table.chairCount < 8) {
                left = width - (chairSize / 1.3);
              } else if (table.chairCount < 9) {
                left = width - (chairSize / 1.3);
              } else if (table.chairCount < 10) {
                left = width - (chairSize / 1.3);
              } else if (table.chairCount < 11) {
                left = width - (chairSize / 1.25);
              } else if (table.chairCount < 12) {
                left = width - (chairSize / 1.2);
              } else if (table.chairCount < 13) {
                left = width - (chairSize / 1.25);
              } else if (table.chairCount < 14) {
                left = width - (chairSize / 1.19);
              } else if (table.chairCount < 15) {
                left = width - (chairSize / 1.22);
              } else if (table.chairCount < 16) {
                left = width - (chairSize / 1.17);
              } else if (table.chairCount < 17) {
                left = width - (chairSize / 1.17);
              } else if (table.chairCount < 18) {
                left = width - (chairSize / 1.18);
              } else if (table.chairCount < 19) {
                left = width - (chairSize / 1.19);
              } else if (table.chairCount < 20) {
                left = width - (chairSize / 1.16);
              } else {
                left = width - (chairSize / 1.16); // 20 or more
              }
            } else if (table.shape == TableShape.rectangle) {
              // for right side
              if (table.chairCount < 5) {
                left = width - (chairSize / 1.5);
              } else if (table.chairCount < 6) {
                left = width - (chairSize / 1.6);
              } else if (table.chairCount < 7) {
                left = width - (chairSize / 1.65);
              } else if (table.chairCount < 8) {
                left = width - (chairSize / 1.69);
              } else if (table.chairCount < 9) {
                left = width - (chairSize / 1.68);
              } else if (table.chairCount < 10) {
                left = width - (chairSize / 1.66);
              } else if (table.chairCount < 11) {
                left = width - (chairSize / 1.65);
              } else if (table.chairCount < 12) {
                left = width - (chairSize / 1.66);
              } else if (table.chairCount < 13) {
                left = width - (chairSize / 1.65);
              } else if (table.chairCount < 14) {
                left = width - (chairSize / 1.65);
              } else if (table.chairCount < 15) {
                left = width - (chairSize / 1.65);
              } else if (table.chairCount < 16) {
                left = width - (chairSize / 1.67);
              } else if (table.chairCount < 17) {
                left = width - (chairSize / 1.68);
              } else if (table.chairCount < 18) {
                left = width - (chairSize / 1.65);
              } else if (table.chairCount < 19) {
                left = width - (chairSize / 1.62);
              } else if (table.chairCount < 20) {
                left = width - (chairSize / 1.59);
              } else {
                left = width - (chairSize / 1.57); // 20 or more
              }
            } else if (table.shape == TableShape.square) {
              // left = width - (chairSize / 1); // for right side
              if (table.chairCount < 5) {
                left = width - (chairSize / 1.19);
              } else if (table.chairCount < 6) {
                left = width - (chairSize / 1.24);
              } else if (table.chairCount < 7) {
                left = width - (chairSize / 1.22);
              } else if (table.chairCount < 8) {
                left = width - (chairSize / 1.2);
              } else if (table.chairCount < 9) {
                left = width - (chairSize / 1.2);
              } else if (table.chairCount < 10) {
                left = width - (chairSize / 1.15);
              } else if (table.chairCount < 11) {
                left = width - (chairSize / 1.1);
              } else if (table.chairCount < 12) {
                left = width - (chairSize / 1.12);
              } else if (table.chairCount < 13) {
                left = width - (chairSize / 1.12);
              } else if (table.chairCount < 14) {
                left = width - (chairSize / 1.11);
              } else if (table.chairCount < 15) {
                left = width - (chairSize / 1.09);
              } else if (table.chairCount < 16) {
                left = width - (chairSize / 1.08);
              } else if (table.chairCount < 17) {
                left = width - (chairSize / 1.07);
              } else if (table.chairCount < 18) {
                left = width - (chairSize / 1.06);
              } else if (table.chairCount < 19) {
                left = width - (chairSize / 1.05);
              } else if (table.chairCount < 20) {
                left = width - (chairSize / 1.025);
              } else {
                left = width - (chairSize / 1.01); // 20 or more
              }
            }
            break;
          case 2: // Bottom
            left = width * positionOnSide - (chairSize / 2);
            if (table.shape == TableShape.round) {
              // top = 37;
              // top = height - (chairSize / 2); // for bottom side
              if (table.chairCount < 5) {
                top = height - (chairSize / 1.2);
              } else if (table.chairCount < 6) {
                top = height - (chairSize / 1.2);
              } else if (table.chairCount < 7) {
                top = height - (chairSize / 1.2);
              } else if (table.chairCount < 8) {
                top = height - (chairSize / 1.2);
              } else if (table.chairCount < 9) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 10) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 11) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 12) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 13) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 14) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 15) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 16) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 17) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 18) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 19) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 20) {
                top = height - (chairSize / 1.1);
              } else {
                top = height - (chairSize / 1.05); // 20 or more
              }
            } else if (table.shape == TableShape.rectangle) {
              // top = 114;
              // top = height - (chairSize / 2); // for bottom side
              if (table.chairCount < 5) {
                top = height - (chairSize / .8);
              } else if (table.chairCount < 6) {
                top = height - (chairSize / .8);
              } else if (table.chairCount < 7) {
                top = height - (chairSize / .78);
              } else if (table.chairCount < 8) {
                top = height - (chairSize / .76);
              } else if (table.chairCount < 9) {
                top = height - (chairSize / .76);
              } else if (table.chairCount < 10) {
                top = height - (chairSize / .73);
              } else if (table.chairCount < 11) {
                top = height - (chairSize / .72);
              } else if (table.chairCount < 12) {
                top = height - (chairSize / .70);
              } else if (table.chairCount < 13) {
                top = height - (chairSize / .68);
              } else if (table.chairCount < 14) {
                top = height - (chairSize / .67);
              } else if (table.chairCount < 15) {
                top = height - (chairSize / .65);
              } else if (table.chairCount < 16) {
                top = height - (chairSize / .64);
              } else if (table.chairCount < 17) {
                top = height - (chairSize / .63);
              } else if (table.chairCount < 18) {
                top = height - (chairSize / .63);
              } else if (table.chairCount < 19) {
                top = height - (chairSize / .61);
              } else if (table.chairCount < 20) {
                top = height - (chairSize / .60);
              } else {
                top = height - (chairSize / .59); // 20 or more
              }
            } else if (table.shape == TableShape.square) {
              // top = 58;
              // top = height - (chairSize / 1); // for bottom side
              if (table.chairCount < 5) {
                top = height - (chairSize / 1.13);
              } else if (table.chairCount < 6) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 7) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 8) {
                top = height - (chairSize / 1.1);
              } else if (table.chairCount < 9) {
                top = height - (chairSize / 1.08);
              } else if (table.chairCount < 10) {
                top = height - (chairSize / 1.06);
              } else if (table.chairCount < 11) {
                top = height - (chairSize / 1.04);
              } else if (table.chairCount < 12) {
                top = height - (chairSize / 1.03);
              } else if (table.chairCount < 13) {
                top = height - (chairSize / 1.033);
              } else if (table.chairCount < 14) {
                top = height - (chairSize / 1.028);
              } else if (table.chairCount < 15) {
                top = height - (chairSize / 1.02);
              } else if (table.chairCount < 16) {
                top = height - (chairSize / 1);
              } else if (table.chairCount < 17) {
                top = height - (chairSize / .95);
              } else if (table.chairCount < 18) {
                top = height - (chairSize / .93);
              } else if (table.chairCount < 19) {
                top = height - (chairSize / .92);
              } else if (table.chairCount < 20) {
                top = height - (chairSize / .91);
              } else {
                top = height - (chairSize / .90); // 20 or more
              }
            }
            break;

          case 3: // Left
            top = height * positionOnSide - (chairSize / 1.7);
            if (table.shape == TableShape.round) {
              // left = -22;
              if (table.chairCount < 5) {
                left = -30;
              } else if (table.chairCount < 6) {
                left = -30;
              } else if (table.chairCount < 7) {
                left = -30;
              } else if (table.chairCount < 8) {
                left = -30;
              } else if (table.chairCount < 9) {
                left = -29;
              } else if (table.chairCount < 10) {
                left = -28;
              } else if (table.chairCount < 11) {
                left = -28;
              } else if (table.chairCount < 12) {
                left = -27;
              } else if (table.chairCount < 13) {
                left = -26;
              } else if (table.chairCount < 14) {
                left = -25;
              } else if (table.chairCount < 15) {
                left = -25;
              } else if (table.chairCount < 16) {
                left = -24;
              } else if (table.chairCount < 17) {
                left = -24;
              } else if (table.chairCount < 18) {
                left = -23.5;
              } else if (table.chairCount < 19) {
                left = -23;
              } else if (table.chairCount < 20) {
                left = -23;
              } else {
                left = -23; // for 20 or more
              }
            } else if (table.shape == TableShape.rectangle) {
              // left = -44;
              if (table.chairCount < 5) {
                left = -39;
              } else if (table.chairCount < 6) {
                left = -40;
              } else if (table.chairCount < 7) {
                left = -40;
              } else if (table.chairCount < 8) {
                left = -40;
              } else if (table.chairCount < 9) {
                left = -40;
              } else if (table.chairCount < 10) {
                left = -40;
              } else if (table.chairCount < 11) {
                left = -40;
              } else if (table.chairCount < 12) {
                left = -40;
              } else if (table.chairCount < 13) {
                left = -40;
              } else if (table.chairCount < 14) {
                left = -40;
              } else if (table.chairCount < 15) {
                left = -40;
              } else if (table.chairCount < 16) {
                left = -40;
              } else if (table.chairCount < 17) {
                left = -40;
              } else if (table.chairCount < 18) {
                left = -40;
              } else if (table.chairCount < 19) {
                left = -40;
              } else if (table.chairCount < 20) {
                left = -40;
              } else {
                left = -40; // for 20 or more
              }
            } else if (table.shape == TableShape.square) {
              // left = -15;
              if (table.chairCount < 5) {
                left = -26;
              } else if (table.chairCount < 6) {
                left = -24;
              } else if (table.chairCount < 7) {
                left = -21;
              } else if (table.chairCount < 8) {
                left = -20;
              } else if (table.chairCount < 9) {
                left = -19;
              } else if (table.chairCount < 10) {
                left = -18;
              } else if (table.chairCount < 11) {
                left = -17;
              } else if (table.chairCount < 12) {
                left = -16;
              } else if (table.chairCount < 13) {
                left = -15;
              } else if (table.chairCount < 14) {
                left = -16;
              } else if (table.chairCount < 15) {
                left = -17;
              } else if (table.chairCount < 16) {
                left = -18;
              } else if (table.chairCount < 17) {
                left = -18;
              } else if (table.chairCount < 18) {
                left = -19;
              } else if (table.chairCount < 19) {
                left = -16;
              } else if (table.chairCount < 20) {
                left = -16;
              } else {
                left = -15; // for 20 or more
              }
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
    final editedTemplate = tables[index]; // use as base

    final newTable = await showDialog<TableItem>(
      context: context,
      builder: (context) => TableEditDialog(table: editedTemplate),
    );

    if (newTable != null) {
      setState(() {
        // ✅ generate unique label (A1 → A2 → A3...)
        String nextLabel = _generateNextLabel();
        TableItem newTableWithLabel = newTable.copyWith(
          label: nextLabel,
          position: editedTemplate.position + const Offset(30, 30),
        );
        editedTables.add(newTableWithLabel);
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

  String _generateNextLabel() {
    int counter = 1;
    while (true) {
      final label = "A$counter";
      if (!tables.any((t) => t.label == label)) {
        return label;
      }
      counter++;
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
            // border: Border.all(color: Colors.black),
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
                    notes: notesController.text,
                    chairCount: chairCount,
                    row: selectedRow,
                  ),
                  isPreview: true,
                ),
                SizedBox(height: 12.h),
                // DropdownButtonFormField<String>(
                //   value: selectedRow,
                //   items:
                //       ['Row 1', 'Row 2']
                //           .map(
                //             (row) =>
                //                 DropdownMenuItem(value: row, child: Text(row)),
                //           )
                //           .toList(),
                //   decoration: const InputDecoration(labelText: "Select Row"),
                //   onChanged: (value) {
                //     if (value != null) {
                //       setState(() {
                //         selectedRow = value;
                //       });
                //     }
                //   },
                // ),
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
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_drop_up, size: 30),
                          onPressed: () {
                            if (chairCount < 20) {
                              setState(() {
                                chairCount++;
                              });
                            }
                          },
                        ),
                        Text(
                          '$chairCount',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_drop_down, size: 30),
                          onPressed: () {
                            if (chairCount > 4) {
                              setState(() {
                                chairCount--;
                              });
                            }
                          },
                        ),
                      ],
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
  TableItem? headTable;

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
    headTable = TableItem(
      position: const Offset(100, 50),
      label: 'Head Table',
      notes: '',
      shape: TableShape.rectangle,
      chairCount: 6,
      row: '',
      rotationAngle: 0,
    );
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

  // screen shot controller
  final ScreenshotController _screenshotController = ScreenshotController();

  // generate pdf file
  Future<void> _generatePdfFromLayout({
    required BuildContext context,
    required String venueName,
    required String yourName,
    required String partnerName,
    required bool isSeatingChart,
  }) async {
    final pdf = pw.Document();

    try {
      if (isSeatingChart) {
        // Capture seating chart as image
        final image = await _screenshotController.capture();
        if (image == null) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Error: Could not capture screenshot"),
              ),
            );
          }
          return;
        }

        final pdfImage = pw.MemoryImage(image);

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Venue: $venueName",
                    style: pw.TextStyle(fontSize: 18),
                  ),
                  pw.Text(
                    "Couple: $yourName & $partnerName",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Center(child: pw.Image(pdfImage, width: 400)),
                ],
              );
            },
          ),
        );
      } else {
        // Guest list layout
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Venue: $venueName",
                    style: pw.TextStyle(fontSize: 18),
                  ),
                  pw.Text(
                    "Couple: $yourName & $partnerName",
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "Guest List",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  if (tables.isNotEmpty)
                    ...tables.map(
                      (table) => pw.Text(
                        "- ${table.label} (Chairs: ${table.chairCount})",
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ),
                  if (headTable != null)
                    pw.Text(
                      "- ${headTable!.label} (Chairs: ${headTable!.chairCount})",
                      style: pw.TextStyle(fontSize: 14),
                    ),
                  if (specialTable != null)
                    pw.Text(
                      "- ${specialTable!.label} (Chairs: ${specialTable!.chairCount})",
                      style: pw.TextStyle(fontSize: 14),
                    ),
                ],
              );
            },
          ),
        );
      }

      final bytes = await pdf.save();

      // Upload to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('pdfs')
          .child('${DateTime.now().millisecondsSinceEpoch}.pdf');

      final uploadTask = await storageRef.putData(
        bytes,
        SettableMetadata(contentType: 'application/pdf'),
      );

      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Save to Firestore
      await FirebaseFirestore.instance.collection('pdf_urls').add({
        'venueName': venueName,
        'yourName': yourName,
        'partnerName': partnerName,
        'isSeatingChart': isSeatingChart,
        'url': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("PDF uploaded & URL saved successfully!"),
            duration: Duration(seconds: 3),
          ),
        );
      }

      // Print
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => bytes);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  // show download dialogue
  void _showDownloadDialog() async {
    final venueController = TextEditingController();
    final yourNameController = TextEditingController();
    final partnerNameController = TextEditingController();
    bool isSeatingChart = true;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Download PDF"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: venueController,
                  decoration: const InputDecoration(labelText: "Venue Name"),
                ),
                TextField(
                  controller: yourNameController,
                  decoration: const InputDecoration(labelText: "Your Name"),
                ),
                TextField(
                  controller: partnerNameController,
                  decoration: const InputDecoration(labelText: "Partner Name"),
                ),
                const SizedBox(height: 20),
                const Text("Select Format:"),
                RadioListTile<bool>(
                  title: const Text("Seating Chart (with layout)"),
                  value: true,
                  groupValue: isSeatingChart,
                  onChanged: (value) {
                    setState(() {
                      isSeatingChart = value!;
                    });
                    Navigator.of(context).pop();
                    _showDownloadDialog();
                  },
                ),
                RadioListTile<bool>(
                  title: const Text("List as Guest (table names only)"),
                  value: false,
                  groupValue: isSeatingChart,
                  onChanged: (value) {
                    setState(() {
                      isSeatingChart = value!;
                    });
                    Navigator.of(context).pop();
                    _showDownloadDialog();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final venue = venueController.text.trim();
                final yourName = yourNameController.text.trim();
                final partner = partnerNameController.text.trim();

                if (venue.isEmpty || yourName.isEmpty || partner.isEmpty)
                  return;

                Navigator.pop(context);

                _generatePdfFromLayout(
                  context: context,
                  venueName: venue,
                  yourName: yourName,
                  partnerName: partner,
                  isSeatingChart: isSeatingChart,
                );
              },
              child: const Text("Generate PDF"),
            ),
          ],
        );
      },
    );
  }

  // export as pdf
  void exportAsPdf() async {
    final image = await _screenshotController.capture();
    if (image != null) {
      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(image);

      pdf.addPage(
        pw.Page(build: (context) => pw.Center(child: pw.Image(pdfImage))),
      );

      final file = File('${(await getTemporaryDirectory()).path}/layout.pdf');
      await file.writeAsBytes(await pdf.save());

      await Printing.sharePdf(bytes: await pdf.save(), filename: 'layout.pdf');
    }
  }

  // export as image
  void exportAsImage() async {
    final image = await _screenshotController.capture();

    if (image != null) {
      // Save image as PNG
      final file = File('${(await getTemporaryDirectory()).path}/layout.png');
      await file.writeAsBytes(image);

      // Convert image to PDF
      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(image);

      pdf.addPage(
        pw.Page(build: (context) => pw.Center(child: pw.Image(pdfImage))),
      );

      // Share as PDF
      await Printing.sharePdf(bytes: await pdf.save(), filename: 'layout.pdf');
    }
  }

  // // export as excel

  // void exportAsExcel(List<Guest> guestList) async {
  //   final excel = Excel.createExcel();
  //   final sheet = excel['Guest List'];
  //   sheet.appendRow(['Guest Name', 'Seat Number']);
  //   for (var guest in guestList) {
  //     sheet.appendRow([guest.name, guest.seatNumber]);
  //   }
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file =
  //       File('${dir.path}/guest_list.xlsx')
  //         ..createSync(recursive: true)
  //         ..writeAsBytesSync(excel.encode()!);
  //   // Share or handle file
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            chairs.add(ChairItem(position: const Offset(100, 100)));
          });
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.chair, color: Colors.deepPurple),
      ),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button
                InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 24.sp, color: Colors.white),
                    ],
                  ),
                ),

                // Title
                Text(
                  "Preview Layout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Download section
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _showDownloadDialog,
                      child: Icon(Icons.download, color: Colors.white),
                    ),

                    Text(
                      "Download PDF",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed:
                () => showModalBottomSheet(
                  context: context,
                  builder:
                      (_) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.picture_as_pdf),
                            title: Text('Export as PDF'),
                            onTap: exportAsPdf,
                          ),
                          ListTile(
                            leading: Icon(Icons.image),
                            title: Text('Export as Image'),
                            onTap: exportAsImage,
                          ),
                          ListTile(
                            leading: Icon(Icons.table_chart),
                            title: Text('Export as Excel'),
                            // onTap:
                            //     () =>
                            //         exportAsExcel(guestList), // Pass your data
                            onTap: () {},
                          ),
                        ],
                      ),
                ),
            child: Text('🖨 Export & Print Options'),
          ),
          Expanded(
            child: Screenshot(
              controller: _screenshotController,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (headTable != null)
                    Positioned(
                      left: headTable!.position.dx,
                      top: headTable!.position.dy,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            headTable = headTable!.copyWith(
                              position: headTable!.position + details.delta,
                            );
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.rotate(
                              angle: headTable!.rotationAngle,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  TableWidget(
                                    table: headTable!,
                                    isPreview: false,
                                  ), // ✅
                                ],
                              ),
                            ),

                            Text(
                              "Name: ${headTable!.label}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Text(
                              "Chairs: ${headTable!.chairCount}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    final updated = await showDialog<TableItem>(
                                      context: context,
                                      builder:
                                          (_) => TableEditDialog(
                                            table: headTable!,
                                          ),
                                    );
                                    if (updated != null) {
                                      setState(() {
                                        headTable = updated;
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.rotate_right,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      headTable = headTable!.copyWith(
                                        rotationAngle:
                                            headTable!.rotationAngle +
                                            (3.14159 / 2),
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Tables
                  for (int i = 0; i < tables.length; i++)
                    Positioned(
                      left: tables[i].position.dx,
                      top: tables[i].position.dy,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          _updateTablePosition(
                            i,
                            tables[i].position + details.delta,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: tables[i].rotationAngle,
                              child: TableWidget(
                                table: tables[i],
                                isPreview: true,
                              ),
                            ),
                            Text(
                              "Name: ${tables[i].label}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            if (tables[i].notes.isNotEmpty)
                              Text(
                                "Notes: ${tables[i].notes}",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            Text(
                              "Chairs: ${tables[i].chairCount}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Text(
                              "Row: ${tables[i].row}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    final updatedTable =
                                        await showDialog<TableItem>(
                                          context: context,
                                          builder:
                                              (_) => TableEditDialog(
                                                table: tables[i],
                                              ),
                                        );
                                    if (updatedTable != null) {
                                      setState(() {
                                        tables[i] = updatedTable;
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.rotate_right,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      final newAngle =
                                          tables[i].rotationAngle +
                                          (3.14159 / 2);
                                      tables[i] = tables[i].copyWith(
                                        rotationAngle: newAngle,
                                      );
                                    });
                                  },
                                ),
                              ],
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
                          _updateChairPosition(
                            i,
                            chairs[i].position + details.delta,
                          );
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
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Chairs: ${specialTable!.chairCount}",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
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

class Guest {
  final String name;
  final String seatNumber;

  Guest({required this.name, required this.seatNumber});
}
