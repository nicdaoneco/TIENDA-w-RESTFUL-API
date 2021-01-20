class Note {
  String name;
  String category;
  String price;
  String qty;
  String description;
  Note(this.name, this.category, this.price, this.qty, this.description);

  Note.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    price = json['price'];
    qty = json['qty'];
    description = json['description'];
  }
}
