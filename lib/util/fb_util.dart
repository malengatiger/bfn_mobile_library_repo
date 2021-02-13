import 'package:bfnlibrary/data/investor_payment.dart';
import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'functions.dart';
import 'utils.dart';

class FireBaseUtil {
  static var isAuthed = false;
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static Future initialize() async {
    if (!isAuthed) {
      p('🥦 Trying to initialize Firebase ........');
      var m = await Firebase.initializeApp();
      isAuthed = true;
      p('$FERN $FERN $FERN Firebase has been initialized: '
          '$PINK_FLOWER ${m.name} ${m.options.databaseURL} authed: $isAuthed');
      return isAuthed;
    }
    return isAuthed;
  }

  static Future<List<BFNUser>> getBFNUsers() async {
    var mList = List<BFNUser>();
    var q = await db.collection('bfnUsers').get();
    q.docs.forEach((element) {
      mList.add(BFNUser.fromJson(element.data()));
    });

    p('🌿🌿🌿 BFNUsers found: ${mList.length}');
    return mList;
  }

  static Future<List<InvestorPayment>> getInvestorPayments(
      String identifier) async {
    var mList = List<InvestorPayment>();
    var q = await db
        .collection('bfnInvestorPayments')
        .where('investorProfile.account.identifier', isEqualTo: identifier)
        .get();
    q.docs.forEach((element) {
      mList.add(InvestorPayment.fromJson(element.data()));
    });

    p('🌿🌿🌿 InvestorPayments found: ${mList.length}');
    mList.forEach((element) {
      prettyPrint(element.toJson(), '🍊 🍊 Investor Payment  🍊 🍊');
    });
    return mList;
  }

  static Future<List<SupplierPayment>> getSupplierPayments(
      String identifier) async {
    var mList = List<SupplierPayment>();
    var q = await db
        .collection('bfnSupplierPayments')
        .where('supplierProfile.account.identifier', isEqualTo: identifier)
        .get();
    q.docs.forEach((element) {
      mList.add(SupplierPayment.fromJson(element.data()));
    });

    p('🌿🌿🌿 SupplierPayments found: ${mList.length}');
    mList.forEach((element) {
      prettyPrint(element.toJson(), '🥦 🥦 Supplier Payment  🥦 🥦');
    });
    return mList;
  }

  static Future<BFNUser> getLoggedInUser(String email) async {
    BFNUser user;
    var q =
        await db.collection('bfnUsers').where('email', isEqualTo: email).get();
    if (q.docs.isNotEmpty) {
      user = BFNUser.fromJson(q.docs.elementAt(0).data());
      await Prefs.saveUser(user);
    }
    return user;
  }

  static Future<User> signInAdminUser() async {
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      p('Current user already established ... 🌿 🌿 🌿 ${auth.currentUser.email}');
      return auth.currentUser;
    }
    await DotEnv().load('.env');
    var email = DotEnv().env['email'];
    var password = DotEnv().env['password'];
    if (email == null) {
      throw Exception('👿  👿 Email missing');
    } else {
      p('🌿 🌿 🌿 Email found in .env: $email');
    }
    if (password == null) {
      throw Exception('👿  👿 Password missing');
    } else {
      p('🌿 🌿 🌿 Password found in .env: $password');
    }

    var cred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    p('🌿 🌿 🌿 User signed in: ${cred.user.email} 🌿 🌿 🌿');
    return cred.user;
  }

  static Future<User> signInUser(
      {@required String email, @required String password}) async {
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      p('Current user already established ... 🌿 🌿 🌿 ${auth.currentUser.email}');
      return auth.currentUser;
    }
    var cred =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    p('🌿 🌿 🌿 User signed in cred.user.email: '
        '${cred.user.email} 🌿 🌿 🌿');
    var bfnUser = await getLoggedInUser(email);
    p('🌿 🌿 🌿 BFNUser signed in:  🍎 '
        '${prettyPrint(bfnUser.toJson(), ' 🍎 BFNUser retrieved  🍎')} '
        '🌿 🌿 🌿');
    return cred.user;
  }

  static Future<bool> isUserLoggedIn() async {
    initialize();
    p('🍔 ....... checking that user is authed .......');
    var auth = FirebaseAuth.instance;
    p('🍔🍔🍔 ....... FirebaseAuth.instance done; what now? .......');
    try {
      if (auth.currentUser != null) {
        var token = await auth.currentUser.getIdToken(true);
        p('$PEACH $PEACH $PEACH user is already logged in. Cool, Boss!  🥝'
            ' token is available. We Good! $PEACH $token');

        return true;
      }
    } catch (e) {
      p(e);
      p(' 👿 👿 👿 Current user on device does not exist: ${auth.currentUser.email}  👿 👿 👿');
      return false;
    }
    p('$ERROR $ERROR user is NOT logged in yet! $ERROR');
    return false;
  }

  static Future<User> createAuthUser() async {
    initialize();
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      p('Current user already established ... 🌿  🌿  🌿 ${auth.currentUser.email}');
      return auth.currentUser;
    }
    await DotEnv().load('.env');
    var email = DotEnv().env['email'];
    var password = DotEnv().env['password'];
    if (email == null) {
      throw Exception('👿  👿 Email missing');
    } else {
      p('🌿  🌿  🌿 Email found in .env: $email');
    }
    if (password == null) {
      throw Exception('👿  👿 Password missing');
    } else {
      p('🌿  🌿  🌿 Password found in .env: $password');
    }

    var result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user;
    if (result.user != null) {
      p('$PINK_FLOWER Auth User has been created: ${result.user.uid}');
      // var ok = await auth.signInWithEmailAndPassword(
      //     email: email, password: password);
      // user = ok.user;
      // p('$PINK_FLOWER $PINK_FLOWER $PINK_FLOWER Auth User has been created: ${ok.user.uid}');
      // p(user);
    }
    return user;
  }
}
