import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp1/cubit/FaQ/faq_cubit.dart';
import 'package:flutterapp1/cubit/FaQ/faq_state.dart';
import 'package:flutterapp1/widgets/FaQ_Widgets/faq_widgets.dart'
    hide CustomBottomNavBar;
import 'package:flutterapp1/widgets/level_widgets/bottom_nav_bar.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FaqCubit(),
      child: BlocBuilder<FaqCubit, FaqState>(
        builder: (context, state) {
          final cubit = context.read<FaqCubit>();

          return Scaffold(
            appBar: AppBar(title: const Text("FAQ"), centerTitle: true),
            body: Column(
              children: [
                /// Search Bar
                SearchBarWidget(
                  controller: state.searchController,
                  onChanged: cubit.filterSearchResults,
                ),

                /// Category Chips
                CategoryChipsWidget(
                  categories: state.faqData.keys.toList(),
                  selectedCategory: state.selectedCategory,
                  onCategorySelected: cubit.changeCategory,
                ),

                /// FAQ List
                Expanded(
                  child: FaqListWidget(
                    faqs: state.faqData[state.selectedCategory] ?? [],
                    isExpandedList:
                        state.isExpandedMap[state.selectedCategory] ?? [],
                    onToggleExpansion:
                        (index) => cubit.toggleExpansion(
                          state.selectedCategory,
                          index,
                        ),
                  ),
                ),
              ],
            ),

            /// Bottom Nav
            bottomNavigationBar: CustomBottomNavBar(
              activeTab: 'Home',
              onTabSelected: cubit.updateTab,
            ),
          );
        },
      ),
    );
  }
}
