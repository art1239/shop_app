class MuttableProduct {
  String id;
  String title;
  String desc;
  double price;
  String imageUrl;
  bool isFavorite;
  MuttableProduct(
      {this.title,
      this.id,
      this.desc,
      this.price,
      this.imageUrl,
      this.isFavorite = false});
}
