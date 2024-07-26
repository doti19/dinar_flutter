import 'package:dinar/features/domain/entities/credit/post.dart';
import 'package:get/get.dart';
import 'package:dinar/core/extensions/string_ex.dart';
import 'package:dinar/features/domain/usecases/address/get_province_names.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../di/injection_container.dart';
import '../../../domain/usecases/post/remote/get_posts.dart';

class MySearchController extends GetxController {
// data in search screen
  // voice controller
  RxBool isListening = false.obs;

  void toggleListening(bool check) {
    isListening.value = check;
  }

  /// query of search bar
  String query = "";

  void changeQuery(String newQuery) {
    query = newQuery;
  }

  /// list dummy data
  final List<String> dummydata = [
    "3 funeral home",
    "----------",
    "-------",
    "Industrial land",
  ];

  /// data in search delegate
  final List<String> history = <String>[
    'ash house',
    'family',
    '---',
    '---',
  ];

  /// list suggestions in search
  RxList<String> suggestions = <String>[].obs;

  /// Name of screen
  String sreenName = 'search';

  /// hint text int textField
  final String hintText = "Buy and sell office";

  RxList<PostEntity> searchPosts = <PostEntity>[].obs;
  final GetPostsUseCase _getPostsUseCase = sl<GetPostsUseCase>();
  Future<Pair<int, List<PostEntity>>> getAllPosts({int? page = 1}) async {
    final dataState = await _getPostsUseCase(
      params: Pair(null, page),
    );

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else if (dataState is DataFailed) {
      return Pair(1, []);
    } else {
      return Pair(1, []);
    }
  }

  final RxList<String> searchStrings = <String>[].obs;

  Future<RxList<String>> getSearchString() async {
    Pair<int, List<PostEntity>> datas = await getAllPosts();
    searchStrings.clear();
    for (var data in datas.second) {
      searchStrings.add(data.title!);
    }
    return searchStrings;
  }

  /// add new query to history
  void addToHistory(String newQuery) {
    if (newQuery.trim() == "") return; // should not be null
    // check in history has newQuery, if had => delete and add in the top
    if (checkIsInHistory(newQuery)) deleteHistory(newQuery);
    // add to history
    history.insert(0, newQuery);
  }

  /// check is in history has newQuery
  bool checkIsInHistory(String query) {
    for (String q in history) {
      if (q == query) return true;
    }
    return false;
  }

  /// delete a query in history
  void deleteHistory(String query) {
    history.remove(query);
    // update suggestion to sync
    updateSuggestions("");
  }

  /// get list Suggestions
  List<String> getSuggestions(String query) {
    // xu ly in hoa, in thuong, co dau, khong dau
    List<String> results = [];
    if (query.isEmpty) {
      results = [...history];
    } else {
      for (String value in searchStrings) {
        if (value
            .noAccentVietnamese()
            .toLowerCase()
            .startsWith(query.noAccentVietnamese().toLowerCase())) {
          results.add(value);
        }
      }
    }
    return results;
  }

  /// update suggestions
  void updateSuggestions(String query) async {
    suggestions.value = getSuggestions(query);
  }

  /// navigator to filter screen
  void navigateToFilterScreen() {
    //Get.to(() => FilterScreen());
  }

  void popScreen() {
    Get.back();
  }

  void navigateToDetailSceen(PostEntity post) {
    Get.toNamed(AppRoutes.postDetail, arguments: post);
  }

// data in result screen

  /// value in dropdown menu item
  // getAll Names of cities
  List<String> provinceNames = <String>[];

  List<String> getProvinceNames() {
    final GetProvinceNamesUseCase getProvinceNamesUseCase =
        sl<GetProvinceNamesUseCase>();
    final dataState = getProvinceNamesUseCase(
      params: this,
    );

    if (dataState is DataSuccess) {
      provinceNames = dataState.data!;
      return dataState.data!;
    } else {
      provinceNames = [];
      return [];
    }
  }

  RxString? selectedTypeItem;

  /// change new value to selectedTypeItem
  void changeSelectedItem(String newValue) async {
    if (selectedTypeItem == null) {
      selectedTypeItem = newValue.obs;
    } else {
      selectedTypeItem!.value = newValue;
    }
    // add filter
    // if (newValue == FilterValues.instance.provinces[0]) {
    //   if (SearchService.instance.typeResult == TypeNavigate.search) {
    //     searchPosts.value =
    //         await getAllPostsInitWithQuery(SearchService.instance.orderBy);
    //   } else {
    //     searchPosts.value =
    //         await getAllPostsInit(SearchService.instance.orderBy);
    //   }
    // } else {
    //   searchPosts.value = await getPostByProvince(
    //       newValue, typeResult, SearchService.instance.orderBy);
    // }
  }
}
