import 'package:dinar/features/presentation/modules/bottom_bar/bottom_bar_controller.dart';
import 'package:get/get.dart';
import 'package:dinar/config/routes/app_routes.dart';
import 'package:dinar/core/utils/check_time_date.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../di/injection_container.dart';
import '../../../domain/entities/nhagiare/blog/blog.dart';
import '../../../domain/usecases/blog/remote/get_all_blogs.dart';

class HomeController extends GetxController {
  String nameUser = "Saminas Hagos";

  RxInt unreadMessCount = 1.obs;
  RxInt unreadNotiCount = 1.obs;

  final BottomBarController _bottomBarController =
      Get.put(BottomBarController());

  // appbar
  Greeting getGreeting() {
    return CheckTimeOfDate.getGreeting();
  }

  void goToPostScreen() {
    _bottomBarController.changeTabIndex(1);
    // changeIndexTab(1);
  }

  // loan limit
  RxInt lendLimit = 100000.obs;
  RxInt borrowLimit = 10000000.obs;

  RxInt lendedUsed = 100000.obs;
  RxInt borrowedUsed = 5000000.obs;

  RxInt currentIndexTab = 0.obs;
  changeIndexTab(int index) {
    currentIndexTab.value = index;
  }

  // image ad
  final List<String> imgList = [
    'https://prod.cdn-medias.theafricareport.com/cdn-cgi/image/q=auto,f=auto,metadata=none,width=1280,height=720,fit=cover/https://prod.cdn-medias.theafricareport.com/medias/2024/06/19/birrcount.jpg',
    'https://furtherafrica.com/content-files/uploads/2022/10/ethiopia_dollar_tech.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJgUgH77SOBmyqFPy0jJcFnfMMEO5Qfxx36g&s',
    'https://myviewsonnews.net/wp-content/uploads/2024/04/ethiopian-banks.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_7KmSJ2j-tEy-lVZ0HoK7PNmRgcIzePFRxw&s',
  ];
  final String fakeUrl = 'https://flutter.dev';

  void launchWebURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  // get blog
  final GetBlogsUseCase getBlogsUseCase = sl.get<GetBlogsUseCase>();
  Future<List<BlogEntity>> getBlogs() async {
    final result = await getBlogsUseCase.call();
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return [];
    }
  }

  // navigate to notification screen
  void navigateToNotificationScreen() {
    Get.toNamed(AppRoutes.notifications);
  }

  void navigateToChatScreen() {
    Get.toNamed(AppRoutes.chat);
  }
}
