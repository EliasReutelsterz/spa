import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/auth/auth_bloc/auth_bloc.dart';
import 'package:improsso/application/theme_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'theme.dart';
import 'package:improsso/injection.dart' as di;
import 'package:improsso/routes/router.gr.dart' as r;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeService(), child: StudyProgressApp()));
}

class StudyProgressApp extends StatelessWidget {
  final _appRouter = r.AppRouter();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                di.sl<AuthBloc>()..add(AuthCheckRequestedEvent()),
          ),
        ],
        child: MaterialApp.router(
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate(),
          theme: themeService.isDarkModeOn
              ? AppTheme.lightTheme
              : AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
        ),
      );
    });
  }
}
