class CategoryAdsModel {
  int? id;
  String? name;
  String? slug;
  String? image;
  int? adsCount;
  List<Children>? children;

  CategoryAdsModel(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.adsCount,
      this.children});

  CategoryAdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    adsCount = json['ads_count'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['ads_count'] = this.adsCount;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? name;
  String? slug;
  String? image;
  int? adsCount;

  Children({this.id, this.name, this.slug, this.image, this.adsCount});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    adsCount = json['ads_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['ads_count'] = this.adsCount;
    return data;
  }
}
