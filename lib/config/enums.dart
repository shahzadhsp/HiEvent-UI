enum TableShape { round, square, rectangle }

enum TableNumber { TableA1, TableA2, TableA3 }

extension TableShapeExtension on TableShape {
  String get label {
    switch (this) {
      case TableShape.round:
        return 'Round';
      case TableShape.square:
        return 'Square';
      case TableShape.rectangle:
        return 'Rectangle';
    }
  }
}

extension TableNumberExtension on TableNumber {
  String get label {
    switch (this) {
      case TableNumber.TableA1:
        return 'A1 Table';
      case TableNumber.TableA2:
        return 'A2 Table';
      case TableNumber.TableA3:
        return 'A3 Table';
    }
  }
}
