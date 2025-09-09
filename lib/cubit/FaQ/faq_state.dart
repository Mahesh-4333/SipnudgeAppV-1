import 'package:equatable/equatable.dart';

class FaqState extends Equatable {
  final String selectedCategory;
  final Map<String, List<bool>> isExpandedMap;
  final String searchQuery;
  final List<String> filteredFAQs;

  const FaqState({
    this.selectedCategory = 'General',
    this.isExpandedMap = const {},
    this.searchQuery = '',
    this.filteredFAQs = const [],
  });

  FaqState copyWith({
    String? selectedCategory,
    Map<String, List<bool>>? isExpandedMap,
    String? searchQuery,
    List<String>? filteredFAQs,
  }) {
    return FaqState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isExpandedMap: isExpandedMap ?? this.isExpandedMap,
      searchQuery: searchQuery ?? this.searchQuery,
      filteredFAQs: filteredFAQs ?? this.filteredFAQs,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategory,
    isExpandedMap,
    searchQuery,
    filteredFAQs,
  ];
}
