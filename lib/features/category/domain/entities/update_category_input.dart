class UpdateCategoryInput {
  UpdateCategoryInput({
    required this.categoryId,
    this.name,
    this.icon,
    this.color,
  });

  final String categoryId;
  final String? name;
  final String? icon;
  final String? color;

  Map<String, dynamic> toMap() {
    return {
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
    };
  }

  bool get hasChanges =>
      (name != null && name!.isNotEmpty) ||
      (icon != null && icon!.isNotEmpty) ||
      (color != null && color!.isNotEmpty);
}
