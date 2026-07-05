import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/utils/popups/full_screen_loader.dart';
import 'package:ui_temarlije/utils/popups/loaders.dart';

abstract class TemarLijeBaseDataTableController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  RxBool sortAscending = true.obs;

  final searchController = TextEditingController();

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  // Abstract Metheod TO implemte by Subclasse for Featcing items
  Future<List<T>> fetchItems();
  // Abstract Metheod TO implemte by Subclasse for delating Items
  Future<void> deleteItems(T item);
  // Abstract Metheod TO implemte if item contains the serch query
  bool containSearchQuery(T item, String query);

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(fetchedItems);
      selectedRows.assignAll(List.generate(allItems.length, (idx) => false));
    } catch (err) {
      isLoading.value = false;
      TemarLijeFullScreenLoader.stopLoading();
      TemarLijeLoaders.errorSnackBar(title: "Opps ", message: err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where((items) => containSearchQuery(items, query)),
    );
  }

  void sortByProperty(
    int sortColumnIndex,
    bool ascending,
    Function(T) property,
  ) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  void addItemsToList(T element) {
    allItems.add(element);
    filteredItems.add(element);
    selectedRows.assignAll(List.generate(allItems.length, (idx) => false));
  }

  void updateItemsFromList(T items) {
    final itemIdex = allItems.indexWhere((i) => i == items);
    final filteredItemsIdex = filteredItems.indexWhere((i) => i == items);

    if (itemIdex != -1) allItems[itemIdex] = items;
    if (filteredItemsIdex != -1) filteredItems[itemIdex] = items;
    filteredItems.refresh();
  }
}
