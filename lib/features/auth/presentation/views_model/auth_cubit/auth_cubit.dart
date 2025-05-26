import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:meta/meta.dart';
import 'package:movies_app/features/auth/data/repos/authrepo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  User? userr;
  AuthCubit(this._authRepository) : super(AuthInitial()) {
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userr = user;
        emit(AuthUserLoaded(user: user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(errorMessage: 'Failed to fetch user.'));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _authRepository.signIn(email: email, password: password);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'invalid-credential':
          errorMessage =
              'The supplied auth credential is incorrect, malformed, or has expired.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      emit(AuthLoading());
      await _authRepository.signUp(email: email, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'An account already exists with this email.';
          break;
        case 'weak-password':
          errorMessage = 'Password should be at least 6 characters.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      emit(AuthLoading());
      await _authRepository.sendPasswordResetEmail(email: email);
      emit(AuthPasswordResetSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _authRepository
          .signOut(); // Assuming your AuthRepository has a signOut method
      emit(AuthSignOutSuccess());
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      emit(AuthLoading());
      // Fetch the current user
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Re-authenticate the user with the old password
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(newPassword);
        emit(AuthPasswordChangeSuccess());
      } else {
        emit(AuthFailure(errorMessage: 'No user is currently logged in.'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The new password is too weak.';
          break;
        case 'requires-recent-login':
          errorMessage = 'Please log in again to update your password.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }
}
