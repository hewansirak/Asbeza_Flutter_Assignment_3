class Item {
  int id;
  String title;
  num price;
  String description;
  String image;
  int quantity;
  int itemAdded;

  Item(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.quantity,
      required this.itemAdded});

  factory Item.fromJson(Map<String, dynamic> parsedjson) {
    return Item(
        id: parsedjson['id'],
        title: parsedjson['title'],
        price: parsedjson['price'],
        description: parsedjson['description'],
        image: parsedjson['image'],
        quantity: 1,
        itemAdded: 0);
  }

  factory Item.historyfromJson(Map<String, dynamic> parsedJson) {
    return Item(
      id: parsedJson["id"],
      title: parsedJson["title"],
      description: parsedJson["description"],
      price: parsedJson["price"],
      image: parsedJson["image"],
      quantity: parsedJson["quantity"],
      itemAdded: parsedJson["itemAdded"],
    );
  }

  toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['title'] = title;
    json['description'] = description;
    json['price'] = price;
    json['image'] = image;
    json['quantity'] = quantity;
    json['itemAdded'] = itemAdded;
    return json;
  }

  static List asbezaList(List asbeza) {
    List asbezas = [];
    for (var i = 0; i < asbeza.length; i++) {
      asbezas.add(Item.fromJson(asbeza[i]));
    }
    return asbezas;
  }

  static List historyList(List asbeza) {
    List asbezas = [];
    for (var i = 0; i < asbeza.length; i++) {
      asbezas.add(Item.historyfromJson(asbeza[i]));
    }
    return asbezas;
  }
}
