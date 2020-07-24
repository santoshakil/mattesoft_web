import 'package:flutter/material.dart';

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

List<CartItem> cartItem = [];

var _quantity = TextEditingController();
//var _address;

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              children: [
                                Text('Your Order List'),
                                Container(
                                  height: 300, // or any other number
                                  width: 300, // or any other number
                                  child: cartList(),
                                ),
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
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: List.generate(choices.length, (index) {
                      return Center(
                        child: ChoiceCard(choice: choices[index]),
                      );
                    }),
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
          for (var i in cartItem) {
            print('${i.name}');
          }
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Cart()),
          // );
        },
      ),
    );
  }
}

Widget cartList() {
  if (cartItem.length != 0) {
    return ListView.builder(
      itemCount: cartItem.length,
      itemBuilder: (context, index) {
        return Text(cartItem[index].name);
      },
    );
  }
  return Text('Nothing in Cart');
}

class Choice {
  const Choice({this.title, this.price, this.icon});
  final String title;
  final String price;
  final IconData icon;
}

const List<Choice> choices = const [
  const Choice(title: 'Car', price: '100.0', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', price: '100.0', icon: Icons.directions_bike),
  const Choice(title: 'Boat', price: '100.0', icon: Icons.directions_boat),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      color: Colors.white,
      elevation: 3,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Icon(choice.icon, size: 150)),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(choice.title),
                      Text(choice.price),
                    ],
                  ),
                ),
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
                                          name: '${choice.title}',
                                          quantity: '${_quantity.text}',
                                          price: '${choice.price}',
                                        ));
                                        showDialog(
                                          context: contex,
                                          builder: (BuildContext contex) {
                                            return AlertDialog(
                                              content: Card(
                                                elevation: 3,
                                                child: Text('Added to Cart.'),
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
            )
          ],
        ),
      ),
    );
  }
}
