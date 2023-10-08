import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/profile/profile.dart';

import '../../common/values/colors.dart';
import '../home/home_page.dart';

Widget buildPage(int index){
 List<Widget> _widget = [
  const HomePage(),
  Center(child: Text("Search"),),
  Center(child: Text("Course"),),
  Center(child: Text("Chat"),),
  const ProfilePage(),
];

 return _widget[index];
}

    var bottomTabs = [
     BottomNavigationBarItem(
      label: "Home",
      icon: SizedBox(
       width: 15.w,
       height: 15.h,
       child: Image.asset("assets/images/home.png"),
      ),
      activeIcon: SizedBox(
       width: 15.w,
       height: 15.h,
       child: Image.asset("assets/images/home.png", color: AppColors.primaryElement,),
      ),
     ),
     BottomNavigationBarItem(
      label: "Search",
      icon: SizedBox(
       width: 15.w, height: 15.h, child:Image.asset("assets/images/search.png",),),
      activeIcon: SizedBox(
       width: 15.w,
       height: 15.h,
       child: Image.asset("assets/images/search.png", color: AppColors.primaryElement,),
      ),),
     BottomNavigationBarItem(
      label: "Course",
      icon: SizedBox(
          width: 15.w, height: 15.h, child: Image.asset("assets/images/play-circle1.png")),
      activeIcon: SizedBox(
       width: 15.w,
       height: 15.h,
       child: Image.asset("assets/images/play-circle1.png",
        color: AppColors.primaryElement,
       ),
      ),),
     BottomNavigationBarItem(
      label: "Chat",
      icon: SizedBox(
          width: 15.w, height: 15.h, child: Image.asset("assets/images/message-circle.png")),
      activeIcon: SizedBox(
          width: 15.w,
          height: 15.h,
          child: Image.asset("assets/images/message-circle.png",color: AppColors.primaryElement,)
      ),),
     BottomNavigationBarItem(
      label: "Profile",
      icon: SizedBox(
          width: 15.w, height: 15.h, child: Image.asset("assets/images/person2.png",)),
      activeIcon: SizedBox(
          width: 15.w,
          height: 15.h,
          child:Image.asset("assets/images/person2.png",color: AppColors.primaryElement,)
      ),),
  ];