
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant/home_page/home_page_controller/home_page_controller.dart';
import 'package:plant/view/view_controller/view_controller.dart';

final plantProvider=ChangeNotifierProvider<HomePageController>((ref){
  return HomePageController();
});

final viewProvider=ChangeNotifierProvider<ViewController>((ref){
  return ViewController();
});
