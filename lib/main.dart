import 'package:movie_app_task/core/apis/dio_client.dart';
import 'package:movie_app_task/core/config/package_info.dart';
import 'package:movie_app_task/core/config/shared_db.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/utils/bloc_observer.dart';
import 'package:movie_app_task/features/favorites/bloc/favorite_bloc.dart';
import 'package:movie_app_task/features/favorites/repository/favorite_repository.dart';
import 'package:movie_app_task/features/show_movie/bloc/show_movie_bloc.dart';
import 'package:movie_app_task/features/show_movie/repository/show_movie_repository.dart';
import 'package:movie_app_task/features/splash/presentation/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SPDB.shPref = await SharedPreferences.getInstance();
  Bloc.observer = MyBlocObserver();
  MyPackage.getInfo();
  await dioClient.initcert();

  runApp(
    DevicePreview(
        enabled: kReleaseMode,
        builder: (context) {
          return const MyApp();
        }),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Sizes.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FavoriteBloc(repository: FavoriteRepository())
              ..add(GetFavoriteEvent())),
        BlocProvider(
            create: (context) =>
                ShowMovieBloc(repository: ShowMovieRepository())),
      ],
      child: const MaterialApp(
        scrollBehavior: ScrollBehavior(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
