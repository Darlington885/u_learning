
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/pages/sing_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';

import 'application/bloc/app_blocs.dart';

class AppBlocProviders{
  static get allBlocProviders=>[
    BlocProvider(lazy: false, create: (context) => WelcomeBloc()),
    BlocProvider(create: (context) => SignInBloc()),
    BlocProvider(create: (context) => RegisterBlocs()),
    //BlocProvider(create: (context) => AppBlocs()),
  ];
}