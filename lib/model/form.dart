/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String name;
  String quantity;
  String price;
  String address;

  FeedbackForm(this.name, this.quantity, this.price, this.address);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['name']}", "${json['quantity']}",
        "${json['price']}", "${json['address']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'quantity': quantity,
        'price': price,
        'address': address,
      };
}

class FeedbackFormAdmin {
  String name;
  String price;
  String description;
  String photo;

  FeedbackFormAdmin(this.name, this.price, this.description, this.photo);

  factory FeedbackFormAdmin.fromJson(dynamic json) {
    return FeedbackFormAdmin("${json['name']}", "${json['price']}",
        "${json['description']}", "${json['photo']}");
  }

  // Method to make GET parameters.
  // Map toJson() => {
  //       'name': name,
  //       'price': price,
  //       'description': description,
  //       'photo': photo
  //     };
}
