class AdsListModel {
  int? id;
  String? title;
  String? excerpt;
  String? featuredImage;
  String? author;
  String? date;
  Null? categoryId;
  int? views;
  String? price;
  String? currency;
  int? commentsCount;

  AdsListModel(
      {this.id,
      this.title,
      this.excerpt,
      this.featuredImage,
      this.author,
      this.date,
      this.categoryId,
      this.views,
      this.price,
      this.currency,
      this.commentsCount});

  AdsListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    excerpt = json['excerpt'];
    featuredImage = json['featured_image'];
    author = json['author'];
    date = json['date'];
    categoryId = json['category_id'];
    views = json['views'];
    price = json['price'];
    currency = json['currency'];
    commentsCount = json['comments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['excerpt'] = this.excerpt;
    data['featured_image'] = this.featuredImage;
    data['author'] = this.author;
    data['date'] = this.date;
    data['category_id'] = this.categoryId;
    data['views'] = this.views;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['comments_count'] = this.commentsCount;
    return data;
  }
}
