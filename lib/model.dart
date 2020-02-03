String apiBaseUrl = "http://192.168.43.208:8000/api";
String basePlaceImageUrl = "http://192.168.43.208:8000/uploads/places_photos";
String baseGuideImageUrl = "http://192.168.43.208:8000/uploads/guides_photos";
String baseCategoryImageUrl =
    "http://192.168.43.208:8000/uploads/category_photos";

class Place {
  String name;
  String address;
  String imagePath;
  String videoPath;
  String description;
  String category;
  int visits;
  int id;

  Place(
      {this.name,
      this.address,
      this.imagePath,
      this.videoPath,
      this.description,
      this.category,
      this.visits,
      this.id});
  Place.fromMap(Map<String, dynamic> table) {
    name = table["name"];
    address = table["address"];
    imagePath = table["image_path"];
    videoPath = table["video_path"];
    description = table["description"];
    category = table["category"];
    visits = table["visits"];
    id = table["id"];
  }
  @override
  String toString() {
    // TODO: implement toString
    return "($name, $address, $imagePath, $videoPath, $description, $category, $visits, $id)";
  }
}

class Category {
  String type;
  String imagePath;
  int id;
  Category({this.type, this.imagePath, this.id});
  Category.fromMap(Map<String, dynamic> table) {
    type = table["name"];
    id = table["id"];
    imagePath = table["image_path"];
  }
  @override
  String toString() {
    // TODO: implement toString
    return "($type, $imagePath, $id)";
  }
}

class Guide {
  String name;
  String address;
  String contact;
  String email;
  String imagePath;
  String status;
  String nationalid;
  int rating;
  int id;

  Guide({
    this.name,
    this.address,
    this.contact,
    this.email,
    this.imagePath,
    this.status,
    this.nationalid,
    this.rating,
    this.id,
  });
  Guide.fromMap(Map<String, dynamic> table) {
    name = table["name"];
    address = table["address"];
    contact = table["contact_no"];
    email = table["email"];
    imagePath = table["image_path"];
    status = table["status"];
    nationalid = table["national_id_no"];
    rating = table["rating"];
    id = table["id"];
  }
}
