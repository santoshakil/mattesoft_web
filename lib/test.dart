import 'package:flutter/material.dart';
import 'controller/form_controller_admin.dart';
import 'model/form.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<FeedbackFormAdmin> feedbackItems = List<FeedbackFormAdmin>();

  @override
  void initState() {
    super.initState();

    FormControllerAdmin().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.builder(
          itemCount: feedbackItems.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new GridTile(
                footer: new Text(feedbackItems[index].name),
                child: new Text(feedbackItems[index]
                    .price), //just for testing, will fill with image later
              ),
            );
          },
        ),
      ),
    );
  }
}
