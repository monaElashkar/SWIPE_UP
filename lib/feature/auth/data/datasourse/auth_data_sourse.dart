import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSourse {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<AuthResponse> signIn(String email, String password) async {
    return await supabaseClient.auth
        .signInWithPassword(email: email, password: password);
  }
  Future<AuthResponse> signUp(String email, String password) async {
    return await supabaseClient.auth
        .signUp(email: email, password: password);
  }
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }
  Future<Session?> getSession() async {
    return await supabaseClient.auth.currentSession;
  }
  Future<User?> getUser() async {
    return await supabaseClient.auth.currentUser;
  }
  Future<String?> getCurrentUser() async {
    final session = supabaseClient.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }
  
  Future<void> updatePassword(String password) async {
    await supabaseClient.auth.updateUser(UserAttributes(password: password));
  }

}
