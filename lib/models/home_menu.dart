import 'package:weddinghall/res/app_assets.dart';

class HomeMenu {
  final String text;
  final String image;

  HomeMenu({required this.image, required this.text});
}

List<HomeMenu> homeMenuList = [
  HomeMenu(image: AppAssets.hallLogo, text: 'Hall'),
  HomeMenu(image: AppAssets.sms, text: 'SMS'),
  HomeMenu(image: AppAssets.guestList, text: 'Guest List'),
  HomeMenu(image: AppAssets.approvedGuest, text: 'Approved\n Guest'),
  HomeMenu(image: AppAssets.declinedGuest, text: 'Declined\n Guest'),
  HomeMenu(image: AppAssets.pendingGuest, text: 'Pending\n Guest'),
  HomeMenu(image: AppAssets.event, text: 'Event 1'),
  HomeMenu(image: AppAssets.event, text: 'Event 2'),
  HomeMenu(image: AppAssets.event, text: 'Event 3'),
  HomeMenu(image: AppAssets.tahaniGo, text: 'Tahani Go'),
  HomeMenu(image: AppAssets.eventCost, text: 'Event Cost'),
  HomeMenu(image: AppAssets.vendors, text: 'Vendors'),
];
