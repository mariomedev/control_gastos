import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';

class CustomForm extends StatefulWidget {
  final String? hintText;
  final bool? passwordIsActive;
  final Function(String value)? onChanged;
  final String? errorText;
  final TextInputType? keyboardType;
  const CustomForm({
    super.key,
    this.hintText,
    this.passwordIsActive = false,
    this.keyboardType,
    this.onChanged,
    this.errorText,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool obscureText = false;
  @override
  void initState() {
    obscureText = widget.passwordIsActive == true ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFF9A9AB0),
      ),
      borderRadius: BorderRadius.circular(AppDimensions.kBorderRadius8),
    );

    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(AppDimensions.kBorderRadius8),
    );

    return TextField(
      obscureText: obscureText,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        focusedBorder: border.copyWith(borderSide: BorderSide(width: 2)),
        enabledBorder: border,
        errorBorder: errorBorder.copyWith(borderSide: BorderSide(width: 2)),
        focusedErrorBorder: errorBorder,
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        errorText: widget.errorText,
        suffixIcon: (widget.passwordIsActive == true)
            ? _AnimateEye(
                isVisible: obscureText,
                onChanged: (value) => setState(() {
                  obscureText = value;
                }),
              )
            : null,
      ),
    );
  }
}

class _AnimateEye extends StatefulWidget {
  final bool isVisible;
  final Function(bool value) onChanged;

  const _AnimateEye({
    required this.isVisible,
    required this.onChanged,
  });

  @override
  State<_AnimateEye> createState() => _AnimateEyeState();
}

class _AnimateEyeState extends State<_AnimateEye> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: widget.isVisible
          ? SizedBox(
              child: IconButton(
                onPressed: () => widget.onChanged(!widget.isVisible),
                icon: SizedBox(
                  child: _IconSvg(iconPath: AppAssets.eyeShow),
                ),
              ),
            )
          : IconButton(
              onPressed: () => widget.onChanged(!widget.isVisible),
              icon: _IconSvg(iconPath: AppAssets.eyeHide),
            ),
    );
  }
}

class _IconSvg extends StatelessWidget {
  final String iconPath;
  const _IconSvg({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(
        colors.primary,
        BlendMode.srcIn,
      ),
      height: 24,
      width: 24,
    );
  }
}
