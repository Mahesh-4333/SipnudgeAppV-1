import 'package:flutter/material.dart';

class FaqState {
  final String selectedCategory;
  final Map<String, List<Map<String, String>>> faqData;
  final Map<String, List<bool>> isExpandedMap;
  final TextEditingController searchController;
  final String activeTab;

  FaqState({
    required this.selectedCategory,
    required this.faqData,
    required this.isExpandedMap,
    required this.searchController,
    required this.activeTab,
  });

  FaqState copyWith({
    String? selectedCategory,
    Map<String, List<Map<String, String>>>? faqData,
    Map<String, List<bool>>? isExpandedMap,
    TextEditingController? searchController,
    String? activeTab,
  }) {
    return FaqState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      faqData: faqData ?? this.faqData,
      isExpandedMap: isExpandedMap ?? this.isExpandedMap,
      searchController: searchController ?? this.searchController,
      activeTab: activeTab ?? this.activeTab,
    );
  }
}
