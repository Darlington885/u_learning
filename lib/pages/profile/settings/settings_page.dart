
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/pages/application/bloc/app_blocs.dart';
import 'package:ulearning_app/pages/application/bloc/app_events.dart';
// import 'package:ulearning_app/pages/home/widgets/home_page_widgets.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_states.dart';
import 'package:ulearning_app/pages/profile/settings/widgets/settings_widgets.dart';

import '../../../common/routes/names.dart';
import '../../../global.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void removeUserData(){
    context.read<AppBlocs>().add(const TriggerAppEvent(0));

    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SIGN_IN, (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Column(children: [
        SingleChildScrollView(
          child: BlocBuilder<SettingsBlocs, SettingsStates>(builder: (context, state){
            return Container(
                child:Column(
                  children: [
                    settingsButton(context, removeUserData),
            ],
                ),
            );
          },
          ),
        ),
      ],),
    );
  }
}
