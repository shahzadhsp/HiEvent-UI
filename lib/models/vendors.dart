import 'package:weddinghall/res/app_assets.dart';

class Vendors {
  final String text;
  final String image;

  Vendors({required this.text, required this.image});
}

List<Vendors> vendorsList = [
  Vendors(text: 'Decor', image: AppAssets.decor),
  Vendors(text: 'Jewlery', image: AppAssets.jewlery),
  Vendors(text: 'Travel', image: AppAssets.travel),
  Vendors(text: 'Clothing', image: AppAssets.clothing2),
];
