import 'package:flutter/material.dart';

class CustomButtonFilter extends StatelessWidget {
  const CustomButtonFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('05/12/2022 - 09/12/2022'),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SizedBox(
                height: 221,
                width: double.infinity,
                child: Column(
                  spacing: 10,
                  children: [
                    const _FilterText(
                      title: 'Filter',
                      fontWeight: FontWeight.bold,
                    ),
                    _FilterText(
                      title: 'Esta Semana',
                      onTap: () {},
                    ),
                    _FilterText(
                      title: 'Este Mes',
                      onTap: () {},
                    ),
                    _FilterText(
                      title: 'Personalizado',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20.0,
          ),
        ),
      ],
    );
  }
}

class _FilterText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const _FilterText({
    required this.title,
    this.fontWeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
