import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomForm extends StatefulWidget {
  final String? hintText;
  final bool? passwordIsActive;
  const CustomForm({
    super.key,
    this.hintText,
    this.passwordIsActive = false,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    obscureText = widget.passwordIsActive == true ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xFF9A9AB0),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.transparent)),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          suffixIcon: widget.passwordIsActive == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText
                      ? SvgPicture.asset(
                          'assets/svg/icons/Show.svg',
                          colorFilter: const ColorFilter.mode(
                              Color(0xff3366FF), BlendMode.srcIn),
                          height: 24,
                          width: 24,
                        )
                      : SvgPicture.asset(
                          'assets/svg/icons/Hide.svg',
                          colorFilter: const ColorFilter.mode(
                              Color(0xff3366FF), BlendMode.srcIn),
                          height: 24,
                          width: 24,
                        ),
                )
              : null,
        ),
      ),
    );
  }
}
