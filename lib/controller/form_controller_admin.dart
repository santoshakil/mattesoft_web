import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mattesoft_web/model/form.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormControllerAdmin {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbxBigIvzWJyczrWCbTp_cCuKVLPwX_QO6CP4fwM03MKMjYDFP1y/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<FeedbackFormAdmin>> getFeedbackList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback
          .map((json) => FeedbackFormAdmin.fromJson(json))
          .toList();
    });
  }
}
