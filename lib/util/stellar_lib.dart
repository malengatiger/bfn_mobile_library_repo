import 'package:bfnlibrary/util/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'functions.dart';

///Handles all Stellar related tasks
///
class StellarUtility {
  static var isLoaded = false;
  static var client = http.Client();
  static Future<void> ping() async {
    p("$BLUE_DOT ... starting new Stellar ping ...");

    var url = await getUrl();
    var suffix = 'ping';
    try {
      var uriResponse = await client.get('$url$suffix');
      var statusCode = uriResponse.statusCode;
      var body = uriResponse.body;
      p("$BLUE_HEART RESPONSE from ping at $url $YELLOW_FLOWER statusCode: $statusCode $PINK_FLOWER body: $body ...");
    } catch (e) {
      p(e);
    }
  }

  static Future<void> newChallenge() async {
    p("$BLUE_DOT starting new Stellar Wallet Challenge ...");

    var url = await getUrl();
    try {
      var uriResponse = await client.get(url);
      var statusCode = uriResponse.statusCode;
      var body = uriResponse.body;
      p("$BLUE_HEART RESPONSE from ping at $url statusCode: $statusCode body: $body ...");
    } finally {
      client.close();
    }
  }

  static Future getUrl() async {
    if (!isLoaded) {
      await DotEnv().load('.env');
      isLoaded = true;
    }
    var status = DotEnv().env['status'];
    var url = DotEnv().env['dev_stellarAnchorUrl'];
    if (status == 'prod') {
      url = DotEnv().env['prod_stellarAnchorUrl'];
    }
    return url;
  }
}
