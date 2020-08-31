import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

/*  await Firebase.initializeApp(
    name: "Kommando",
    options: FirebaseOptions(
        projectId: "flutterapp-cff50",
        apiKey: "AIzaSyAQ-Zfp5MY-tKXijwG5S4gQECMz89jki-s",
        appId: "1:341570973345:android:3279eef39a6e938c830ae0",
        messagingSenderId: "341570973345"),
  ).catchError((onError) => print(onError));*/

  test("auth instance", () async {
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      name: "Kommando",
      options: FirebaseOptions(
          projectId: "flutterapp-cff50",
          apiKey: "AIzaSyAQ-Zfp5MY-tKXijwG5S4gQECMz89jki-s",
          appId: "1:341570973345:android:3279eef39a6e938c830ae0",
          messagingSenderId: "341570973345"),
    ).catchError((onError) => print(onError));
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    print(firebaseAuth.currentUser.displayName);
    // print(firebaseAuth);
  });
}
