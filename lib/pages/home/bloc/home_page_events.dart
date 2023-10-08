abstract class HomePageEvents{

  const HomePageEvents();
}

class HomePageDots extends HomePageEvents{
  final int index;
  HomePageDots(this.index);
}

class HomePageCourseItem extends HomePageEvents{
  final int courseItem;
  HomePageCourseItem(this.courseItem);
}