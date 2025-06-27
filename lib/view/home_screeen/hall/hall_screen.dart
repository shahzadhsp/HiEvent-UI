// Flutter code with zoom enabled on HallScreen and PreviewScreen
// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';

class TableItem {
  Offset position;
  String asset;
  int chairCount;
  bool isBrideTable;

  TableItem({
    required this.position,
    required this.asset,
    this.chairCount = 4,
    this.isBrideTable = false,
  });
}

class HallScreen extends StatefulWidget {
  const HallScreen({super.key});

  @override
  State<HallScreen> createState() => _HallScreenState();
}

class _HallScreenState extends State<HallScreen> {
  String _stageSide = 'Left';
  String _selectedFor = 'Bride';

  List<TableItem> tables = [
    TableItem(position: Offset(50, 100), asset: AppAssets.table),
    TableItem(position: Offset(200, 100), asset: AppAssets.table2),
    TableItem(position: Offset(120, 250), asset: AppAssets.table3),
  ];

  Offset _stagePosition = Offset(100, 400);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Stage Side:", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 20.w),
                  Text("For:", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10.w),
                  DropdownButton<String>(
                    dropdownColor: Colors.grey[800],
                    value: _selectedFor,
                    items:
                        ['Bride', 'Groom']
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (val) {
                      setState(() => _selectedFor = val!);
                    },
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => _navigateToPreview(context),
                    child: Text("Print Layout"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 3.0,
                constrained: false,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 1000,
                  child: Stack(
                    children: [
                      Positioned(
                        left: _stagePosition.dx,
                        top: _stagePosition.dy,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              _stagePosition += details.delta;
                            });
                          },
                          child: Image.asset(
                            AppAssets.brideStage,
                            width: 100,
                            height: 80,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      ...tables
                          .map((table) => _buildDraggableTable(table))
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableTable(TableItem table) {
    return Positioned(
      left: table.position.dx,
      top: table.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() => table.position += details.delta);
        },
        child: Column(
          children: [
            Text(
              _getTableLabel(table.asset),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Image.asset(AppAssets.table, height: 60.h, width: 60.w),
                ..._buildChairs(table.chairCount),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      table.chairCount =
                          table.chairCount > 1 ? table.chairCount - 1 : 1;
                    });
                  },
                  icon: Icon(Icons.remove, color: Colors.white),
                ),
                Text(
                  '${table.chairCount}',
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => table.chairCount++);
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChairs(int count) {
    const double radius = 50;
    List<Widget> chairs = [];
    for (int i = 0; i < count; i++) {
      final angle = (2 * pi * i) / count;
      final dx = radius * cos(angle);
      final dy = radius * sin(angle);
      chairs.add(
        Positioned(
          left: 30 + dx,
          top: 30 + dy,
          child: Image.asset(
            AppAssets.chair,
            height: 25,
            width: 25,
            color: Colors.white,
          ),
        ),
      );
    }
    return chairs;
  }

  String _getTableLabel(String asset) {
    if (asset.contains("table2")) return "Square Table";
    if (asset.contains("table3")) return "Rectangle Table";
    return "Round Table";
  }

  void _navigateToPreview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => PreviewScreen(tables: tables, stagePosition: _stagePosition),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final List<TableItem> tables;
  final Offset stagePosition;

  const PreviewScreen({
    super.key,
    required this.tables,
    required this.stagePosition,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text("Layout Preview", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 3.0,
        constrained: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 1000,
          child: Stack(
            children: [
              Positioned(
                left: stagePosition.dx,
                top: stagePosition.dy,
                child: Image.asset(
                  AppAssets.brideStage,
                  width: 100,
                  height: 80,
                  color: AppColors.whiteColor,
                ),
              ),
              ...tables.map(
                (table) => Positioned(
                  left: table.position.dx,
                  top: table.position.dy,
                  child: Column(
                    children: [
                      Text(
                        _getTableLabel(table.asset),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(AppAssets.table, height: 60, width: 60),
                          ..._buildChairs(table.chairCount),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChairs(int count) {
    const double radius = 34;
    List<Widget> chairs = [];
    for (int i = 0; i < count; i++) {
      final angle = (2 * pi * i) / count;
      final dx = radius * cos(angle);
      final dy = radius * sin(angle);
      chairs.add(
        Positioned(
          left: 30 + dx,
          top: 30 + dy,
          child: Image.asset(
            AppAssets.chair,
            height: 20,
            width: 20,
            color: Colors.grey[300],
          ),
        ),
      );
    }
    return chairs;
  }

  String _getTableLabel(String asset) {
    if (asset.contains("table2")) return "Square Table";
    if (asset.contains("table3")) return "Rectangle Table";
    return "Round Table";
  }
}
