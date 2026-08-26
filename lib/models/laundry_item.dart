enum ServiceCategory {
  washAndFold('Wash & Fold'),
  washAndIron('Wash & Iron'),
  steamIron('Steam Iron'),
  dryCleaning('Dry Cleaning'),
  shoeCleaning('Shoe Cleaning'),
  household('Household');

  final String title;
  const ServiceCategory(this.title);
}

class LaundryItem {
  final String id;
  final String name;
  final ServiceCategory category;
  final int price;
  final String unit;
  final String iconKey;
  int quantity;

  LaundryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.unit = 'pc',
    required this.iconKey,
    this.quantity = 0,
  });

  LaundryItem copyWith({
    String? id,
    String? name,
    ServiceCategory? category,
    int? price,
    String? unit,
    String? iconKey,
    int? quantity,
  }) {
    return LaundryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      iconKey: iconKey ?? this.iconKey,
      quantity: quantity ?? this.quantity,
    );
  }
}
