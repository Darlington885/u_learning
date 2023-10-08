import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/welcome/welcome.dart';

//import 'common/routes/pages.dart';
import 'common/routes/routes.dart';

void main() async{
  await Global.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
        designSize: const Size(375,812), // We use this to get the standard width and height of our app screen
        builder: (context, child) => MaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: AppColors.primaryText),
              elevation: 0,
              backgroundColor: Colors.white
            ),
          ),
          home: const Welcome(),
          onGenerateRoute: AppPages.GenerateRouteSettings,
        ),
      ),
    );
  }
}
