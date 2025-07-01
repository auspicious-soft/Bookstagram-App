// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// Future<UserCredential?> signInWithFacebook() async {
//   try {
//     final LoginResult result = await FacebookAuth.instance.login();
//
//     if (result.status == LoginStatus.success) {
//       final OAuthCredential credential =
//           FacebookAuthProvider.credential(result.accessToken!.tokenString);
//
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } else {
//       print('Facebook login failed: ${result.status}');
//       return null;
//     }
//   } catch (e) {
//     print('Error during Facebook login: $e');
//     return null;
//   }
// }
