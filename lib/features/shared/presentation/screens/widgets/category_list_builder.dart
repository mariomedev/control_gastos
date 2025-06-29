import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import 'widgets.dart';

class CategoryListBuilder extends StatelessWidget {
  const CategoryListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CardCategory(category: category);
        },
      ),
    );
  }
}

List<CategoryEntity> categories = [
  CategoryEntity(id: 1, title: 'Casa'),
  CategoryEntity(id: 2, title: 'Trabajo'),
  CategoryEntity(id: 3, title: 'Hobbies'),
];
