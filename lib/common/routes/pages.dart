import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/application/application_page.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/welcome.dart';

import '../../pages/application/bloc/app_blocs.dart';
import '../../pages/home/bloc/home_page_blocs.dart';
import '../../pages/home/home_page.dart';
import '../../pages/profile/settings/bloc/settings_blocs.dart';
import '../../pages/profile/settings/settings_page.dart';
import '../../pages/register/bloc/register_blocs.dart';
import '../../pages/register/register.dart';
import '../../pages/sing_in/bloc/sign_in_blocs.dart';
import '../../pages/sing_in/sign_in.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
          route: AppRoutes.INITIAL,
          page: const Welcome(),
          bloc: BlocProvider(
            create: (_) => WelcomeBloc(),
          )),
      PageEntity(
          route: AppRoutes.SIGN_IN,
          page: const SignIn(),
          bloc: BlocProvider(
            create: (_) => SignInBloc(),
          )),
      PageEntity(
          route: AppRoutes.REGISTER,
          page: const Register(),
          bloc: BlocProvider(
            create: (_) => RegisterBlocs(),
          )),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: const ApplicationPage(),
        bloc: BlocProvider(create: (_)=> AppBlocs(),)
      ),

      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(create: (_)=> HomePageBlocs(),)
      ),
      PageEntity(
          route: AppRoutes.SETTINGS,
          page: const SettingsPage(),
          bloc: BlocProvider(create: (_)=> SettingsBlocs(),)
      ),
    ];
  }

  // Return all the bloc Providers
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  // A model that covers the entire screen as we click on navigator  object
  static  MaterialPageRoute GenerateRouteSettings(RouteSettings settings){
      if(settings.name!=null){

        // check for route name matching when navigator gets triggered.
        var result = routes().where((element) => element.route==settings.name);
        if(result.isNotEmpty){
          print("First log");
          print(result.first.route);
          //print("valid route name ${settings.name}");

          bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
          if(result.first.route==AppRoutes.INITIAL&&deviceFirstOpen==true){

            bool isLoggedIn = Global.storageService.getIsLoggedIn();
            if(isLoggedIn){
              return MaterialPageRoute(builder: (_) => ApplicationPage(), settings: settings);
            }
            print("Second log");
            return MaterialPageRoute(builder: (_) => SignIn(), settings: settings);

          }
          return MaterialPageRoute(builder: (_) =>result.first.page, settings: settings);
        }
      }
      print("Invalid route name ${settings.name}");
      return MaterialPageRoute(builder: (_)=>SignIn(), settings: settings);
  }
}

// Unify  BlocProvider and routes and pages/screen names(These are three items)
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
