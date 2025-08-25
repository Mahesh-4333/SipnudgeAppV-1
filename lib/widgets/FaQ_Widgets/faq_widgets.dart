import 'package:flutter/material.dart';

/// Search Bar
class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search questions...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

/// Category Chips
class CategoryChipsWidget extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryChipsWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) => onCategorySelected(category),
          );
        },
      ),
    );
  }
}

/// FAQ List
class FaqListWidget extends StatelessWidget {
  final List<Map<String, String>> faqs;
  final List<bool> isExpandedList;
  final Function(int) onToggleExpansion;

  const FaqListWidget({
    super.key,
    required this.faqs,
    required this.isExpandedList,
    required this.onToggleExpansion,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        final isExpanded = isExpandedList[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ExpansionTile(
            title: Text(
              faq['question']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (_) => onToggleExpansion(index),
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(faq['answer']!),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Bottom Nav
class CustomBottomNavBar extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ["Home", "FAQ", "Settings"];

    return BottomNavigationBar(
      currentIndex: tabs.indexOf(activeTab),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: "FAQ"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
      onTap: (index) => onTabSelected(tabs[index]),
    );
  }
}
