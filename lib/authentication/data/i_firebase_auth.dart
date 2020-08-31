abstract class IFirebaseAuth {
  createUserWithEmailAndPassword(String email, String password);
  loginWithEmailAndPassword(String email, String password);
}