import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final Map<String, List<Map<String, String>>> _allFaqData;

  FaqCubit()
    : _allFaqData = {
        'General': [
          {
            'question': 'What is this app?',
            'answer':
                'This app helps you stay hydrated by tracking your water intake.',
          },
          {
            'question': 'Who can use this app?',
            'answer': 'Anyone who wants to monitor hydration levels.',
          },
        ],
        'Usage': [
          {
            'question': 'How do I log a drink?',
            'answer': 'Simply press the "+" button on the home screen.',
          },
        ],
        'App': [
          {
            'question': 'Is the app free?',
            'answer': 'Yes, the basic features are free.',
          },
        ],
        'Tracking': [
          {
            'question': 'How is my progress tracked?',
            'answer': 'The app records your daily intake history.',
          },
        ],
        'Troubleshooting': [
          {
            'question': 'The app is not syncing.',
            'answer':
                'Please restart the app and ensure internet is available.',
          },
        ],
        'Support': [
          {
            'question': 'How do I contact support?',
            'answer': 'You can reach us via the support tab in the app.',
          },
        ],
      },
      super(
        FaqState(
          selectedCategory: 'General',
          faqData: {}, // will be set in init
          isExpandedMap: {},
          searchController: TextEditingController(),
          activeTab: 'Home',
        ),
      ) {
    // Initialize with full FAQ data + expansion map
    _emitWithExpansion(_allFaqData);
  }

  /// Change selected category
  void changeCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  /// Toggle expand/collapse for a question
  void toggleExpansion(String category, int index) {
    final updatedMap = Map<String, List<bool>>.from(state.isExpandedMap);
    final list = List<bool>.from(updatedMap[category]!);
    list[index] = !list[index];
    updatedMap[category] = list;

    emit(state.copyWith(isExpandedMap: updatedMap));
  }

  /// Filter search results
  void filterSearchResults(String query) {
    if (query.isEmpty) {
      _emitWithExpansion(_allFaqData);
      return;
    }

    final filteredData = <String, List<Map<String, String>>>{};
    _allFaqData.forEach((category, faqs) {
      final matches =
          faqs.where((faq) {
            final q = faq['question']!.toLowerCase();
            final a = faq['answer']!.toLowerCase();
            return q.contains(query.toLowerCase()) ||
                a.contains(query.toLowerCase());
          }).toList();

      if (matches.isNotEmpty) {
        filteredData[category] = matches;
      }
    });

    _emitWithExpansion(filteredData);
  }

  /// Update active tab for bottom nav
  void updateTab(String tab) {
    emit(state.copyWith(activeTab: tab));
  }

  /// Emit FAQ data with a properly aligned expansion map
  void _emitWithExpansion(Map<String, List<Map<String, String>>> data) {
    final expansion = <String, List<bool>>{};
    data.forEach((key, list) {
      expansion[key] = List.generate(list.length, (_) => false);
    });

    emit(state.copyWith(faqData: data, isExpandedMap: expansion));
  }
}
