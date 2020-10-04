import 'package:bfnlibrary/util/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

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

  static Future<AccountResponse> getAccountResponse(String accountId) async {
    p("🍎 Getting status from .env for use in Stellar call ........");
    if (!isLoaded) {
      await DotEnv().load('.env');
      isLoaded = true;
      p("🍎 Getting status from .env .. isLoaded: $isLoaded");
    }
    var status = DotEnv().env['status'];

    StellarSDK sdk;
    if (status == 'prod') {
      sdk = StellarSDK.PUBLIC;
      p(" 🥦 🥦 🥦 🥦 We are connected to StellarSDK.PUBLIC ...  🥦 🥦 🥦");
    } else {
      sdk = StellarSDK.TESTNET;
      p(" 🥦 🥦 🥦 🥦 We are connected to StellarSDK.TESTNET ...  🥦 🥦 🥦");
    }
    p("🍊🍊🍊 Getting accountResponse from Stellar .... .........");
    var resp = await sdk.accounts.account(accountId);
    p("🥦 🥦 🥦 🥦 StellarUtility: AccountResponse from Stellar, balance: "
        "assetCode: ${resp.balances[0].assetCode} balance: ${resp.balances[0].balance} XLM "
        "issuer: ${resp.balances[0].assetIssuer}");

    return resp;
  }

  static Future getUrl() async {
    p("🍎 Getting url from .env ..");
    if (!isLoaded) {
      await DotEnv().load('.env');
      isLoaded = true;
      p("🍎 Getting url from .env .. isLoaded: $isLoaded");
    }
    var status = DotEnv().env['status'];
    var url = DotEnv().env['dev_stellarAnchorUrl'];
    if (status == 'prod') {
      url = DotEnv().env['prod_stellarAnchorUrl'];
    }
    p("🥦 Returning url from .env ..url: $url");
    return url;
  }
}
