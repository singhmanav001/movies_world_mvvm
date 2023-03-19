import '../values/app_dimen.dart';

class PagingController<T> {
  List<T> listItems = [];
  int pageNumber = defaultPageNumber;
  bool isLoadingPage = false;
  bool endOfList = false;

  initRefresh() {
    listItems = [];
    pageNumber = defaultPageNumber;
    isLoadingPage = false;
    endOfList = false;
  }

  bool canLoadNextPage() {
    return !isLoadingPage && !endOfList;
  }

  appendPage(List<T> items) {
    listItems.addAll(items);
    pageNumber++;
  }

  appendLastPage(List<T> items) {
    listItems.addAll(items);
    endOfList = true;
  }
}
