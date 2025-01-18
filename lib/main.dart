import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/bloc_Observer.dart';
import 'package:social_app/Components/cache_helper.dart';
import 'package:social_app/Home%20Layout/home_cubit.dart';
import 'package:social_app/Home%20Layout/home_layout.dart';
import 'package:social_app/Home%20Layout/home_states.dart';
import 'package:social_app/Login/login_screen.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId') ?? '';

  Widget openScreen = LoginScreen();
  if (uId != '') {
    openScreen = HomeLayout();
  }

  runApp(MyApp(
    openScreen: openScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget openScreen;
  const MyApp({
    super.key,
    required this.openScreen,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getUserData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeLayout(),
      ),
    );
  }
}
