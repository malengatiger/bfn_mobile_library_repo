import 'package:bfnlibrary/util/fb_util.dart';
import 'package:bfnlibrary/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

import 'functions.dart';

///Handles all Stellar related tasks
///
class StellarUtility {
  static var isLoaded = false;
  static var client = http.Client();
  // static var auth = FirebaseAuth.instance;

  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static Future<void> ping() async {
    p("$BLUE_DOT$BLUE_DOT$BLUE_DOT ... starting new Stellar ping ...");
    await FireBaseUtil.initialize();
    var auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      p('👿👿👿 user is not logged in yet. 👿 ping cannot happen');
      return;
    }
    var token = await auth.currentUser.getIdToken(true);
    headers['Authorization'] = 'Bearer $token';
    var url = await getUrl();
    var suffix = 'ping';
    try {
      var uriResponse = await client.get('$url$suffix', headers: headers);
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
    p("🍊 🍊 🍊 Getting accountResponse from Stellar .... .........");
    var resp = await sdk.accounts.account(accountId);
    p("🥦 🥦 🥦 🥦 StellarUtility: AccountResponse from Stellar:  🍎 ${resp.accountId} ");
    p("🥦 🥦 🥦 🥦 StellarUtility: AccountResponse from Stellar:  🍎 ${resp.accountId} ");
    resp.signers.forEach((element) {
      p("🤟 🤟 Account Signer: ${element.accountId} type: ${element.type}  weight: ${element.weight}");
    });
    resp.balances.forEach((element) {
      p("🥦 🥦  balance: "
          "assetCode: ${element.assetCode} balance: ${element.balance}  "
          "issuer: ${element.assetIssuer}");
    });

    return resp;
  }

  static Future<List<TransactionResponse>> getTransactions(
      String accountId) async {
    if (!isLoaded) {
      await DotEnv().load('.env');
      isLoaded = true;
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
    p("🍊 🍊 🍊 Getting transactions from Stellar .... .........");
    var page = await sdk.transactions.forAccount(accountId).execute();

    var mPage = await sdk.payments.forAccount(accountId).execute();
    mPage.records.forEach((payment) {
      p("🔷🔷 transactionSuccessful: ${payment.transactionSuccessful} "
          "sourceAccount: ${payment.sourceAccount} createdAt: ${payment.createdAt} "
          "transactionHash: ${payment.transactionHash}");
    });
    page.records.forEach((transactionResponse) {
      p("🤟🤟🤟 links.effects: ${transactionResponse.links.effects.toJson()}");
      p("🤟🤟🤟 pagingToken: ${transactionResponse.pagingToken}");
      p("🤟🤟🤟🤟 transactionResponse createdAt: ${transactionResponse.createdAt} sourceAccount: ${transactionResponse.sourceAccount}  "
          "feeCharged: ${transactionResponse.feeCharged}");
    });
    return page.records;
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
    p("🥦🥦🥦🥦 Returning url from .env .. 🥦 url: $url");
    return url;
  }
}
