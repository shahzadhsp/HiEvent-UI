class CostModelPrice {
  final String eventName;
  final String eventPrice;
  CostModelPrice({required this.eventName, required this.eventPrice});
}

List<CostModelPrice> eventCostPrice = [
  CostModelPrice(eventName: 'Venue Providers', eventPrice: 'INR 1700.00'),
  CostModelPrice(eventName: 'Caterers', eventPrice: 'INR 1700.00'),
  CostModelPrice(eventName: 'Photographers', eventPrice: 'INR 1700.00'),
  CostModelPrice(eventName: 'Florists', eventPrice: 'INR 1700.00'),
  CostModelPrice(
    eventName: 'Musicians / DJs / Bands',
    eventPrice: 'INR 1700.00',
  ),
];

// List<String> headings = [
//   'Venue Providers',
//   'Caterers',
//   'Photographers',
//   'Florists',
//   'Musicians / DJs / Bands',
// ];
