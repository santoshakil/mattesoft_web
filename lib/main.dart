import 'package:flutter/material.dart';
import 'controller/form_controller.dart';
import 'controller/form_controller_admin.dart';
import 'model/form.dart';

void main() {
  runApp(MaterialApp(
    title: 'Hamim Shop',
    home: MyApp(),
  ));
}

class CartItem {
  String name;
  String quantity;
  String price;

  CartItem({
    this.name,
    this.quantity,
    this.price,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<FeedbackFormAdmin> feedbackItems = List<FeedbackFormAdmin>();
  List<CartItem> cartItem = [];
  var _quantity = TextEditingController();

  @override
  void initState() {
    super.initState();

    FormControllerAdmin().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController addressController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    for (int i = 0; i < cartItem.length; i++) {
      if (_formKey.currentState.validate()) {
        // If the form is valid, proceed.
        FeedbackForm feedbackForm = FeedbackForm(cartItem[i].name,
            cartItem[i].quantity, cartItem[i].price, addressController.text);

        FormController formController = FormController();

        _showSnackbar("Submitting Feedback");

        // Submit 'feedbackForm' and save it in Google Sheets.
        formController.submitForm(feedbackForm, (String response) {
          print("Response: $response");
          if (response == FormController.STATUS_SUCCESS) {
            // Feedback is saved succesfully in Google Sheets.
            _showSnackbar("Order Submitted");
          } else {
            // Error Occurred while saving data in Google Sheets.
            _showSnackbar("Error Occurred!");
          }
        });
      }
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(height: 30),
                ),
                Expanded(
                  flex: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hamim',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Shop',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        'Order Anything from HOME',
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: RaisedButton(
                    elevation: 1,
                    color: Colors.blueGrey,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext contex) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Your Order List'),
                                TextField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                      hintText: 'What is your Address?'),
                                ),
                                SizedBox(height: 10),
                                cartList(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Conferm Order',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(height: 30),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(flex: 1, child: SizedBox(height: 30)),
                Expanded(
                  flex: 10,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 900,
                      child: GridView.builder(
                        itemCount: feedbackItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: GridTile(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(feedbackItems[index].name),
                                  Expanded(
                                    child: Image.network(
                                      '${feedbackItems[index].photo}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                              footer: Row(
                                children: [
                                  Expanded(
                                      child: Text(feedbackItems[index].price)),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext contex) {
                                          return AlertDialog(
                                            content: Stack(
                                              overflow: Overflow.visible,
                                              children: [
                                                Text('How much do you need?'),
                                                Container(
                                                  height: 100,
                                                  child: Row(
                                                    children: [
                                                      Text('Quantity: '),
                                                      Container(
                                                        width: 50,
                                                        child: TextField(
                                                          controller: _quantity,
                                                          maxLines: 1,
                                                          minLines: 1,
                                                        ),
                                                      ),
                                                      SizedBox(width: 20),
                                                      IconButton(
                                                        icon: Icon(Icons.add),
                                                        onPressed: () {
                                                          cartItem.add(CartItem(
                                                            name:
                                                                '${feedbackItems[index].name}',
                                                            quantity:
                                                                '${_quantity.text}',
                                                            price:
                                                                '${feedbackItems[index].price}',
                                                          ));
                                                          showDialog(
                                                            context: contex,
                                                            builder:
                                                                (BuildContext
                                                                    contex) {
                                                              return AlertDialog(
                                                                content: Card(
                                                                  elevation: 3,
                                                                  child: Text(
                                                                      'Added to Cart.'),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox(height: 30))
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('You Pressed');
        },
      ),
    );
  }

  Widget cartList() {
    if (cartItem.length != 0) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 300,
              width: 200,
              child: ListView.builder(
                itemCount: cartItem.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Text(cartItem[index].name),
                        Text(
                            'Price ${cartItem[index].quantity}*${cartItem[index].price} = ${int.tryParse(cartItem[index].price) * int.tryParse(cartItem[index].quantity)}'),
                        Text('Quantity: ${cartItem[index].quantity}')
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text('Total price: ${totalPrice()}'),
            RaisedButton(
                child: Text('Conferm Order'),
                elevation: 1,
                color: Colors.blueGrey,
                onPressed: () {
                  _submitForm();
                })
          ],
        ),
      );
    } else {
      return Text('Nothing in Cart');
    }
  }

  totalPrice() {
    int total = 0;
    for (int i = 0; i < cartItem.length; i++) {
      int price =
          int.tryParse(cartItem[i].quantity) * int.tryParse(cartItem[i].price);
      total = total + price;
    }
    return total;
  }
}
