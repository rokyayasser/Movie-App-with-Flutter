import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/features/auth/presentation/views/authscreen.dart';
import 'package:movies_app/features/auth/presentation/views/changepassword.dart';
import 'package:movies_app/features/auth/presentation/views/forget_passwordscreen.dart';
import 'package:movies_app/features/favourites/data/models/fav_model.dart';
import 'package:movies_app/features/favourites/data/repos/favouriterepo_.dart';
import 'package:movies_app/features/favourites/presentation/views_model/cubit/favourite_cubit.dart';
import 'package:movies_app/features/home/presentation/views/homescreen.dart';
import 'package:movies_app/features/splash/presentation/views/splashscreen.dart';
import 'package:movies_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(FavItemModelAdapter());
  await Hive.openBox<FavItemModel>(favbox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit(FavouriteRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const AuthScreen(
                registration: 'login',
              ),
          '/signup': (context) => const AuthScreen(registration: 'signup'),
          '/home': (context) => const HomeScreen(),
          '/forgetpassword': (context) => const ForgetPasswordScreen(),
          '/changepassword': (context) => ChangePassword(),
        },
      ),
    );
  }
}
