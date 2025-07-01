import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'package:weddinghall/res/app_assets.dart';
import 'package:weddinghall/res/app_colors.dart';
import 'package:weddinghall/view/home_screeen/hall/hall_screen.dart'
    hide AppAssets, AppColors;

class TableItem {
  Offset position;
  String asset;
  int chairCount;

  TableItem({required this.position, required this.asset, this.chairCount = 4});
}

class HallScreen2 extends StatefulWidget {
  const HallScreen2({super.key});
  @override
  State<HallScreen2> createState() => _HallScreenState();
}

class _HallScreenState extends State<HallScreen2> {
  String _stageSide = 'Left';
  String _searchText = '';
  TextEditingController _searchController = TextEditingController();

  List<TableItem> tables = [];
  Offset stagePosition = Offset(150, 20);

  @override
  void initState() {
    super.initState();
    _generateTables();
    _searchController.addListener(() {
      setState(() => _searchText = _searchController.text.toLowerCase());
    });
  }

  void _generateTables() {
    tables.clear();
    double startXLeft = 40;
    double startXRight = 260;
    double startY = 100;
    double spacingY = 120;
    int leftCount = _stageSide == 'Left' ? 9 : 10;
    int rightCount = _stageSide == 'Right' ? 9 : 10;

    for (int i = 0; i < leftCount; i++) {
      tables.add(
        TableItem(
          position: Offset(startXLeft, startY + i * spacingY),
          asset: AppAssets.table,
        ),
      );
    }
    for (int i = 0; i < rightCount; i++) {
      tables.add(
        TableItem(
          position: Offset(startXRight, startY + i * spacingY),
          asset: AppAssets.table2,
        ),
      );
    }

    // Center rectangle table between two rows
    double centerX = (startXLeft + startXRight) / 2;
    tables.add(
      TableItem(
        position: Offset(centerX - 30, startY + 3 * spacingY),
        asset: AppAssets.table3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text("Stage Side:", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    dropdownColor: Colors.grey[800],
                    value: _stageSide,
                    items:
                        ['Left', 'Right']
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
                      setState(() {
                        _stageSide = val!;
                        _generateTables();
                      });
                    },
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () => _navigateToPreview(context),
                    icon: Icon(Icons.print),
                    label: Text("Print Layout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Search table type...',
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Container(
                    height: 1500.h,
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Positioned(
                          left: stagePosition.dx,
                          top: stagePosition.dy,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                stagePosition += details.delta;
                              });
                            },
                            child: Image.asset(
                              AppAssets.brideStage,
                              height: 50,
                              width: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ...tables
                            .where(
                              (table) => _getTableLabel(
                                table.asset,
                              ).toLowerCase().contains(_searchText),
                            )
                            .map((table) => _buildDraggableTable(table))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HallScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor,
                foregroundColor: AppColors.blackColor,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 60.h),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Add Bride Details',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: AppColors.blackColor),
              ),
            ),
            SizedBox(height: 20.h),
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
          setState(() {
            table.position += details.delta;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              Text(
                _getTableLabel(table.asset),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Image.asset(table.asset, height: 60.h, width: 60.w),
                  ..._buildChairs(table.chairCount),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed:
                        () => setState(
                          () =>
                              table.chairCount =
                                  table.chairCount > 1
                                      ? table.chairCount - 1
                                      : 1,
                        ),
                    icon: Icon(Icons.remove, color: Colors.white),
                  ),
                  Text(
                    '${table.chairCount}',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () => setState(() => table.chairCount++),
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ],
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
            (_) => PreviewScreen(tables: tables, stagePosition: stagePosition),
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
      body: SingleChildScrollView(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 3.0,
          child: Container(
            padding: EdgeInsets.all(12),
            height: 1500,
            child: Stack(
              children: [
                Positioned(
                  left: stagePosition.dx,
                  top: stagePosition.dy,
                  child: Image.asset(
                    AppAssets.brideStage,
                    height: 50,
                    width: 80,
                    color: Colors.white,
                  ),
                ),
                ...tables.map((table) => _buildPreviewTable(table)).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewTable(TableItem table) {
    return Positioned(
      left: table.position.dx,
      top: table.position.dy,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _getTableLabel(table.asset),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 4),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Image.asset(table.asset, height: 60, width: 60),
              ..._buildChairs(table.chairCount),
            ],
          ),
        ],
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
