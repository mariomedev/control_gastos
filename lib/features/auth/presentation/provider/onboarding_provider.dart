
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final onboardingControllerProvider = StateProvider.autoDispose<PageController?>((ref) {
  return PageController();
});