import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/apis/user_api.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/widgets/flutter_toast.dart';

import 'bloc/sign_in_blocs.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});

  void handleSignIn(String type) async {
    try {
      if (type == "email") {
        //BlocProvider.of<SignInBloc>(context).state;
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty) {

          //print("email is empty");

          toastInfo(msg: "You need to fill email address");
          return;
        }
        if (password.isEmpty) {

          toastInfo(msg: "You need to fill password");
          return;
        }

        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
          if(credential.user==null){

            toastInfo(msg: "You don't exist");
            return;
          }
          if(credential.user!.emailVerified){

            toastInfo(msg: "You need to verify your email account");
            return;
          }

          var user = credential.user;
          if(user!=null){
            // We got verified user from Firebase

            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            // type 1 means email login
            loginRequestEntity.type = 1;

            print("user exist");
            asyncPostAllData(loginRequestEntity);

          }else{

            toastInfo(msg: "Currently you are not the user of this app");
            return;
            // Error getting user from Firebase
          }

        } on FirebaseAuthException catch (e) {
          if(e.code == "user-not-found"){
            toastInfo(msg: "No user found for that email");

          }else if(e.code == "wrong-password"){
            toastInfo(msg: "wrong password provided for that user");

          }else if(e.code == "invalid-email"){
            toastInfo(msg: "Your email address format is wrong");
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }


// We calling the server using this method
  void asyncPostAllData(LoginRequestEntity loginRequestEntity)async{
      EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );

      var result = await UserAPI.login(params:loginRequestEntity);

      if(result.code==200){
        try{
          Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
          // used for authorization, that's why we saved it.
          Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
          EasyLoading.dismiss(); // This is used to stop the circularProgressIndicator
          Navigator.of(context).pushNamedAndRemoveUntil('/application', (route) => false);
        }catch(e){
          print("saving local storage error ${e.toString()}");
        }
      }else{
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
  }
}
