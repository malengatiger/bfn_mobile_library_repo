import 'dart:convert';

import 'package:bfnlibrary/data/accepted_offer.dart';
import 'package:bfnlibrary/data/account.dart';
import 'package:bfnlibrary/data/dashboard_data.dart';
import 'package:bfnlibrary/data/fb_user.dart';
import 'package:bfnlibrary/data/invoice.dart';
import 'package:bfnlibrary/data/invoice_offer.dart';
import 'package:bfnlibrary/data/network_operator.dart';
import 'package:bfnlibrary/data/node_info.dart';
import 'package:bfnlibrary/data/profile.dart';
import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Net {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static bool firebaseInitialized = false;

  static Future _getCachedURL() async {
    var url = await Prefs.getUrl();
    return url;
  }

  static Future getNetworkOperator() async {}

  static const String BFN = '/bfn/admin/';
  // static Future<List<NodeInfo>> getNodesFromFirestore() async {
  //   if (!firebaseInitialized) {
  //     await Firebase.initializeApp();
  //     debugPrint('🔵 🔵 🔵 🔵 🔵 🔵 🔵 🔵 Firebase has been initialized 🍎');
  //     firebaseInitialized = true;
  //   }
  //   var list = List<NodeInfo>();
  //   print(
  //       '🍎 🍎 🍎 🍎 🍎 🍎 getNodesFromFirestore: about to call auth.currentUser ... ');
  //   var result = auth.currentUser;
  //   if (result == null) {
  //     print(
  //         '🍎 🍎 🍎 🍎  there is no current auth user ... login with admin 🍎 🍎');
  //     var email = DotEnv().env['email'];
  //     var pass = DotEnv().env['password'];
  //     print(
  //         '🌸 🌸 🌸 🌸 🌸 ADMIN 🧡 auth for getting nodes from firestore: 🧡🧡 email from .env : 🥏  $email 🥏  pass: $pass 🥏 ');
  //     var userResult = await auth.signInWithEmailAndPassword(
  //         email: 'aubrey@bfn.com',
  //         password: '2a91f706-81c7-47bf-a172-3d36095d5a32');
  //     print(
  //         '🍊 🍊 🍊 Logged into Firebase with .env credentials,  🌸 uid: ${userResult.user.uid} ... getting nodes ...');
  //     list = await _readCurrentNodes(list);
  //     await auth.signOut();
  //     print('🍊 🍊 🍊 Logged OUT of Firebase  ${userResult.user.uid} ... ');
  //   } else {
  //     print(
  //         '🍎 🍎 🍎 🍎 getNodesFromFirestore: about to get nodes from firestore  🍎 🍎');
  //     list = await _readCurrentNodes(list);
  //   }
  //   if (list.isNotEmpty) {
  //     await Prefs.saveNodes(list);
  //   }
  //   return list;
  // }
  //
  // static Future _readCurrentNodes(List<NodeInfo> list) async {
  //   var snapshot = await db.collection("nodes").get();
  //   print(
  //       '🥏 🥏 🥏 🥏 nodes found on Firestore: 🥏 ${snapshot.docs.length} 🥏 ');
  //   snapshot.docs.forEach((doc) {
  //     var data = doc.data();
  //
  //     var node = NodeInfo.fromJson(data);
  //     var springBootProfile = DotEnv().env['springBootProfile'];
  //     if (springBootProfile == null) {
  //       list.add(node);
  //       print('🥏 data from Firestore: $data');
  //     } else {
  //       if (node.springBootProfile == springBootProfile) {
  //         list.add(node);
  //         print('🥏 data from Firestore: $data');
  //       }
  //     }
  //   });
  //   return list;
  // }

  static Future<String> get(String mUrl) async {
    var start = DateTime.now();
    var client = new http.Client();
    var resp = await client
        .get(
      mUrl,
      headers: headers,
    )
        .whenComplete(() {
      client.close();
    });

    var end = DateTime.now();
    debugPrint(
        '🍎 🍊 Net: post  ##################### elapsed: ${end.difference(start).inSeconds} seconds\n');
    if (resp.statusCode == 200) {
      p('🍎 🍊 Net: get: SUCCESS: Network Response Status Code: 🥬  🥬 ${resp.statusCode} 🥬  $mUrl');
      return resp.body;
    } else {
      var msg = ' 👿  Failed status code: ${resp.statusCode} 🥬  $mUrl';
      p(msg);
      throw Exception(msg);
    }
  }

  static Future post(String mUrl, Map bag) async {
    var start = DateTime.now();
    var client = new http.Client();
    String body;
    if (bag != null) {
      body = json.encode(bag);
    }
    debugPrint('🍊 🍊 🍊 Net: post ... calling with bag: $body');
    var resp = await client
        .post(
      mUrl,
      body: body,
      headers: headers,
    )
        .whenComplete(() {
      debugPrint('🍊 🍊 🍊 Net: post whenComplete ');
      client.close();
    });
    debugPrint(
        '🍎 🍊🍊🍊🍊🍊🍊🍊🍊🍊🍊🍊🍊🍊 Net: post : PRINTING respomse.body from: $mUrl - $body');
    print(resp.body);
    var end = DateTime.now();
    debugPrint(
        '🍎 🍊 Net: post  ##################### elapsed: ${end.difference(start).inSeconds} seconds');
    if (resp.statusCode == 200) {
      debugPrint(
          '🍎 🍊 Net: post: SUCCESS: Network Response Status Code: 🥬  🥬 ${resp.statusCode} 🥬  $mUrl');
      return resp.body;
    } else {
      var msg = ' 👿  Failed status code: ${resp.statusCode} 🥬  $mUrl';
      debugPrint(resp.body);
      throw Exception(msg);
    }
  }

  static Future<NetworkOperator> updateAnchor(NetworkOperator anchor) async {
    String mx = await buildUrl();
    debugPrint('🌸 CONCATENATED URL: 🌸 $mx' + 'bfn/admin/updateAnchor');
    final response = await post(mx + 'bfn/admin/updateAnchor', anchor.toJson());
    var m = json.decode(response);
    var acct = NetworkOperator.fromJson(m);
    return acct;
  }

  static Future<NetworkOperator> createAnchor(NetworkOperator anchor) async {
    debugPrint('🍊🍊🍊🍊🍊 createAnchor starting the call ...');
    var nodes = await Prefs.getNodes();
    if (nodes == null || nodes.isEmpty) {
      throw Exception("Nodes not found in Preferences");
    }
    NodeInfo node;
    nodes.forEach((m) {
      if (m.addresses[0].contains(anchor.name)) {
        node = m;
      }
    });
    if (node == null) {
      throw Exception("Anchor has no node running");
    }
    await Prefs.saveNode(node);
    String mx = await buildUrl();
    debugPrint('🌸 CONCATENATED URL: 🌸 $mx' + 'bfn/admin/createAnchor');
    final response = await post(mx + 'bfn/admin/createAnchor', anchor.toJson());
    var m = json.decode(response);
    var acct = NetworkOperator.fromJson(m);
    return acct;
  }

  static Future<String> buildUrl() async {
    var node = await Prefs.getNode();
    if (node == null) {
      throw Exception('Node not found in Prefs');
    }
    var mx = '${node.webServerAddress}';
    debugPrint("🍊 🍊 🍊  🌸 🌸 🌸 ${node.toJson()}  🌸 🌸 🌸  🍊 🍊 🍊 ");
    if (node.webServerPort != null || node.webServerPort > 0) {
      mx += ':${node.webServerPort}/';
    } else {
      mx += '/';
    }
    return mx;
  }

  // static Future<Anchor> getAnchor(String identifier) async {
  //   var qs = await db
  //       .collection("accounts")
  //       .where("identifier", isEqualTo: identifier)
  //       .get();
  //   AccountInfo acct;
  //   qs.docs.forEach((doc) {
  //     acct = AccountInfo.fromJson(doc.data());
  //   });
  //   if (acct == null) {
  //     throw Exception('Account not found on Firestore');
  //   }
  //   var nodes = await Prefs.getNodes();
  //   if (nodes == null || nodes.isEmpty) {
  //     throw Exception('Nodes not found in Prefs');
  //   }
  //   NodeInfo node;
  //   nodes.forEach((n) {
  //     if (n.addresses.first.contains(acct.name)) {
  //       node = n;
  //     }
  //   });
  //   if (node == null) {
  //     throw Exception('Node cannot be determined from list of ${nodes.length}');
  //   }
  //   await Prefs.saveNode(node);
  //   var bag = {
  //     "identifier": identifier,
  //   };
  //   debugPrint('🍊🍊🍊🍊🍊 getAnchor starting the call ...');
  //   var url = await buildUrl();
  //   final response = await get(url + '${BFN}getAnchor?identifier=$identifier');
  //   var m = json.decode(response);
  //   var anchor = Anchor.fromJson(m);
  //   prettyPrint(anchor.toJson(), "🥏 🥏 🥏 🥏 ANCHOR RECEIVED 🍎 ");
  //   return anchor;
  // }

  static Future<AccountInfo> startAccountRegistrationFlow(
      String name, String email, String password, String cellphone) async {
    var bag = {
      "name": name,
      "email": email,
      "password": password,
      "cellphone": cellphone
    };
    debugPrint('🍊🍊🍊🍊🍊 startAccountRegistrationFlow starting the call ...');
    var node = await Prefs.getNode();
    final response =
        await post(node.webAPIUrl + '${BFN}startAccountRegistrationFlow', bag);
    var m = json.decode(response);
    var acct = AccountInfo.fromJson(m);
    return acct;
  }

  static Future<Invoice> startRegisterInvoiceFlow(Invoice invoice) async {
    var node = await Prefs.getNode();
    final response = await post(
        node.webAPIUrl + 'supplier/startRegisterInvoiceFlow', invoice.toJson());
    var m = json.decode(response);
    var acct = Invoice.fromJson(m);
    return acct;
  }

  static Future<String> buyInvoiceOffer(String invoiceId) async {
    var user = await Prefs.getAccount();
    var node = await Prefs.getNode();
    final response = await get(node.webAPIUrl +
        'investor/buyInvoiceOffer?invoiceId=$invoiceId&investorId=${user.identifier}');
    return response;
  }

  static Future<InvoiceOffer> startInvoiceOfferFlow(
      InvoiceOffer invoiceOffer) async {
    var node = await Prefs.getNode();
    final response = await post(
        node.webAPIUrl + 'supplier/startInvoiceOfferFlow',
        invoiceOffer.toJson());
    var m = json.decode(response);
    var acct = InvoiceOffer.fromJson(m);
    return acct;
  }

  static Future<List<AccountInfo>> getAccounts() async {
    var prefix = await buildUrl();
    debugPrint("🔱 getAccounts url = $prefix${BFN}getAccounts");
    final response = await get('$prefix${BFN}getAccounts');

    List<AccountInfo> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(AccountInfo.fromJson(f));
    });
    debugPrint(
        '🍊 Net: ..................................... getAccounts: found ${list.length}');
    return list;
  }

  static Future<AccountInfo> getAccount(String accountId) async {
    var node = await Prefs.getNode();
    final response =
        await get(node.webAPIUrl + '${BFN}getAccount?accountId=$accountId');

    AccountInfo acctInfo = AccountInfo.fromJson(json.decode(response));
    debugPrint(
        '🍎 🍊 Net: getAccount: .................... found ${acctInfo.toJson()}');
    return acctInfo;
  }

  static Future<SupplierProfile> getSupplierProfile(String accountId) async {
    var node = await Prefs.getNode();
    final response = await get(
        node.webAPIUrl + '${BFN}getSupplierProfile?accountId=$accountId');

    if (response == null) {
      return null;
    }
    SupplierProfile profile = SupplierProfile.fromJson(json.decode(response));
    debugPrint('🍎 🍊 Net: getSupplierProfile: found ${profile.toJson()}');

    return profile;
  }

  static Future<InvestorProfile> getInvestorProfile(String accountId) async {
    var node = await Prefs.getNode();
    final response = await get(
        node.webAPIUrl + '${BFN}getInvestorProfile?accountId=$accountId');
    if (response == null) {
      return null;
    }
    InvestorProfile profile = InvestorProfile.fromJson(json.decode(response));
    debugPrint('🍎 🍊 Net: getInvestorProfile: found ${profile.toJson()}');
    return profile;
  }

  static Future<String> createInvestorProfile(InvestorProfile profile) async {
    var node = await Prefs.getNode();
    final response = await post(
        node.webAPIUrl + '${BFN}createInvestorProfile', profile.toJson());

    debugPrint('🍎 🍊 Net: createInvestorProfile: $response');
    return response;
  }

  static Future<String> createSupplierProfile(SupplierProfile profile) async {
    var node = await Prefs.getNode();
    final response = await post(
        node.webAPIUrl + '${BFN}createSupplierProfile', profile.toJson());

    debugPrint('🍎 🍊 Net: createSupplierProfile: $response');
    return response;
  }

  static Future<UserRecord> getUser(String email) async {
    var node = await Prefs.getNode();
    String url = node.webAPIUrl + '${BFN}getUser?email=$email';
    ;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      debugPrint(
          '🍎 🍊 Net: getInvoices: Network Response Status Code: 🥬  🥬 ${response.statusCode} 🥬 ');
      if (response.body == null) {
        return null;
      }
      return UserRecord.fromJson(json.decode(response.body));
    } else {
      print(
          ' 👿  Failed : getUser Status Code: 🥬  🥬 ${response.statusCode} 🥬 ');
      return null;
    }
  }

  static Future<List<UserDTO>> getUsers() async {
    var node = await Prefs.getNode();
    String url = node.webAPIUrl + '${BFN}getUsers';
    print('🌸 🌸 🌸 Net: ...... getUsers ............ 🍊 $url');

    List<UserDTO> users = List();
    final response = await http.get(url);
    if (response.statusCode == 200) {
      debugPrint(
          '🍎 🍊 Net: getUsers: Network Response Status Code: 🥬  🥬 ${response.statusCode} 🥬 ');
      if (response.body == null) {
        return null;
      }

      List k = json.decode(response.body);
      k.forEach((m) {
        users.add(UserDTO.fromJson(m));
      });
      return users;
    } else {
      print(
          ' 👿  Failed : getUsers Status Code: 🥬  🥬 ${response.statusCode} 🥬 ');
      return null;
    }
  }

  static Future<List<Invoice>> getInvoicesByAccount(
      {String accountId, bool consumed = false}) async {
    var node = await Prefs.getNode();
    String url = await buildUrl();
    if (accountId == null) {
      url += '${BFN}findInvoicesForNode?consumed=$consumed';
    } else {
      url +=
          '${BFN}findInvoicesForNode?accountId=$accountId&consumed=$consumed';
    }
    debugPrint('sending  $blue ... $url');
    final response = await get(url);

    List<Invoice> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(Invoice.fromJson(f));
    });
    debugPrint('$good Net: findInvoicesForSupplier: found ${list.length}');
    return list;
  }

  static Future<List<NodeInfo>> getNetworkNodes() async {
    await DotEnv().load(".env");
    var status = DotEnv().env['status'];
    var mUrl = DotEnv().env['dev_anchorNodeUrl'];
    if (status == 'prod') {
      mUrl = DotEnv().env['dev_anchorNodeUrl'];
    }
    mUrl += 'getNetworkNodes';
    p('getNetworkNodes: sending  $blue ... $mUrl');
    final response = await get(mUrl);

    List<NodeInfo> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(NodeInfo.fromJson(f));
    });
    debugPrint('$good Net: getNetworkNodes: found ${list.length}');
    return list;
  }

  static Future<List<CustomerProfile>> getCustomerProfiles() async {
    var node = await Prefs.getNode();
    var mUrl = node.webAPIUrl;
    mUrl += '${BFN}getCustomerProfiles';
    p('getCustomerProfiles: sending  $blue ... $mUrl');
    final response = await get(mUrl);

    List<CustomerProfile> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(CustomerProfile.fromJson(f));
    });
    debugPrint('$good Net: getCustomerProfiles: found ${list.length}');
    return list;
  }

  static Future<List<InvestorProfile>> getInvestorProfiles() async {
    var node = await Prefs.getNode();
    var mUrl = node.webAPIUrl;
    mUrl += '${BFN}getInvestorProfiles';
    p('getInvestorProfiles: sending  $blue ... $mUrl');
    final response = await get(mUrl);

    List<InvestorProfile> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(InvestorProfile.fromJson(f));
    });
    debugPrint('$good Net: getInvestorProfiles: found ${list.length}');
    return list;
  }

  static Future<List<SupplierProfile>> getSupplierProfiles() async {
    var node = await Prefs.getNode();
    var mUrl = node.webAPIUrl;
    mUrl += '${BFN}getSupplierProfiles';
    p('getSupplierProfiles: sending  $blue ... $mUrl');
    final response = await get(mUrl);
    List<SupplierProfile> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(SupplierProfile.fromJson(f));
    });
    debugPrint('$good Net: getSupplierProfiles: found ${list.length}');
    return list;
  }

  static Future<List<PurchaseOrder>> getPurchaseOrders(
      {String startDate, String endDate}) async {
    var node = await Prefs.getNode();
    var mUrl = node.webAPIUrl;
    mUrl += '${BFN}getPurchaseOrders?startDate=$startDate&endDate=$endDate';
    p('getPurchaseOrders: sending  $blue ... $mUrl');
    final response = await get(mUrl);
    List<PurchaseOrder> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(PurchaseOrder.fromJson(f));
    });
    debugPrint('$good Net: getPurchaseOrders: found ${list.length}');
    return list;
  }

  static Future<List<Invoice>> getInvoices(
      {String startDate, String endDate}) async {
    var node = await Prefs.getNode();
    var mUrl = node.webAPIUrl;
    mUrl += '${BFN}getInvoices?startDate=$startDate&endDate=$endDate';
    p('getInvoices: sending  $blue ... $mUrl');
    final response = await get(mUrl);
    List<Invoice> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(Invoice.fromJson(f));
    });
    debugPrint('$good Net: getInvoices: found ${list.length}');
    return list;
  }

  static Future<List<InvoiceOffer>> getInvoiceOffers(
      {String startDate, String endDate}) async {
    var node = await Prefs.getNode();
    var mUrl = node.webAPIUrl;
    mUrl += '${BFN}getInvoiceOffers?startDate=$startDate&endDate=$endDate';
    p('getInvoiceOffers: sending  $blue ... $mUrl');
    final response = await get(mUrl);
    List<InvoiceOffer> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(InvoiceOffer.fromJson(f));
    });
    debugPrint('$good Net: getInvoiceOffers: found ${list.length}');
    return list;
  }

  static Future<List<SupplierPayment>> getSupplierPayments(
      {String startDate, String endDate}) async {
    var node = await Prefs.getNode();
    var mUrl = node.webAPIUrl;
    mUrl += '${BFN}getSupplierPayments?startDate=$startDate&endDate=$endDate';
    p('getSupplierPayments: sending  $blue ... $mUrl');
    final response = await get(mUrl);
    List<SupplierPayment> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(SupplierPayment.fromJson(f));
    });
    debugPrint('$good Net: getSupplierPayments: found ${list.length}');
    return list;
  }

  static Future<List<AcceptedOffer>> getAcceptedInvoiceOffers(
      {String startDate, String endDate}) async {
    var node = await Prefs.getNode();
    var mUrl = node.webAPIUrl;
    mUrl +=
        '${BFN}getAcceptedInvoiceOffers?startDate=$startDate&endDate=$endDate';
    p('getAcceptedInvoiceOffers: sending  $blue ... $mUrl');
    final response = await get(mUrl);
    List<AcceptedOffer> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      var offer = AcceptedOffer.fromJson(f);
      list.add(offer);
    });
    debugPrint('$good Net: getAcceptedInvoiceOffers: found ${list.length}');
    return list;
  }

  static const String blue = '🔵  🔵  🔵', good = '🍎 🍊 ';
  static Future<List<InvoiceOffer>> getSupplierInvoiceOffers(
      {String accountId, bool consumed}) async {
    var node = await Prefs.getNode();
    if (consumed == null) consumed = false;
    String url;
    if (accountId == null) {
      url = node.webAPIUrl + '${BFN}findOffersForSupplier?consumed=$consumed';
    } else {
      url = node.webAPIUrl +
          '${BFN}findOffersForSupplier?accountId=$accountId&consumed=$consumed';
    }
    debugPrint(url);
    final response = await get(url);

    List<InvoiceOffer> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(InvoiceOffer.fromJson(f));
    });
    debugPrint('$good Net: findOffersForInvestor: found ${list.length}');
    return list;
  }

  static Future<List<InvoiceOffer>> getInvestorInvoiceOffers(
      {String accountId, bool consumed}) async {
    var node = await Prefs.getNode();
    if (consumed == null) consumed = false;
    String url = await buildUrl();
    if (accountId == null) {
      url += '${BFN}findOffersForInvestor?consumed=$consumed';
    } else {
      url +=
          '${BFN}findOffersForInvestor?accountId=$accountId&consumed=$consumed';
    }
    debugPrint('sending  $blue ... $url');
    final response = await get(url);

    List<InvoiceOffer> list = List();
    List m = json.decode(response);
    m.forEach((f) {
      list.add(InvoiceOffer.fromJson(f));
    });
    debugPrint('$good Net: findOffersForInvestor: found ${list.length}');
    return list;
  }

  static Future<DashboardData> getDashboardData() async {
    var node = await Prefs.getNode();
    String url = node.webAPIUrl + '${BFN}getDashboardData';

    debugPrint(url);
    final response = await get(url);
    var data = DashboardData.fromJson(json.decode(response));
    debugPrint('$good Net: getDashboardData: found ${data.toJson()}');
    return data;
  }

  static Future<String> ping() async {
    var node = await Prefs.getNode();
    final response = await http.get(node.webAPIUrl + '${BFN}ping');
    if (response.statusCode == 200) {
      debugPrint(
          '🍎 🍊 Net: ping: Network Response Status Code: 🥬  🥬 ${response.statusCode} 🥬 ');
      return response.body;
    } else {
      throw Exception(' 👿  Failed ping');
    }
  }
//
//  static Future<String> startDemoDataGeneration() async {
//    final response = await http.get(URL + '${BFN}demo');
//
//    if (response.statusCode == 200) {
//      debugPrint(
//          '🍎 🍊 Net: startDemoDataGeneration: Network Response Status Code: 🥬  🥬 ${response.statusCode} 🥬 ');
//      Prefs.setDemoString('DEMO DATA COMPLETE');
//      return response.body;
//    } else {
//      throw Exception(' 👿  Failed: startDemoDataGeneration');
//    }
//  }
}
