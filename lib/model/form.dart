/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String name;
  String quantity;
  String price;
  String address;

  FeedbackForm(this.name, this.quantity, this.price, this.address);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['name']}", "${json['quantity']}",
        "${json['status']}", "${json['address']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'quantity': quantity,
        'price': price,
        'address': address,
      };
}
