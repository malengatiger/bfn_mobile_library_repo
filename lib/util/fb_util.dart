import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'functions.dart';
import 'utils.dart';

class FireBaseUtil {
  static var isAuthed = false;
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

  static Future<User> signIn() async {
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
    var cred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    p('🌿  🌿  🌿 User signed in: ${cred.user.email}');
    return cred.user;
  }

  static Future<bool> isUserLoggedIn() async {
    initialize();
    p('🍔 ....... checking that user is authed .......');
    var auth = FirebaseAuth.instance;
    p('🍔🍔🍔 ....... FirebaseAuth.instance done; what now? .......');
    if (auth.currentUser != null) {
      var token = await auth.currentUser.getIdToken();
      p('$PEACH $PEACH $PEACH user is already logged in. Cool, Boss!  🥝'
          ' token: $token');

      return true;
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
