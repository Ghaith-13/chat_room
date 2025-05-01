import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../core/styles/radius.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? hintText;

  const SearchTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText = 'Search models',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.gray500,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Icon(
            Icons.search,
            color: AppColors.gray500,
            size: 20,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),
        filled: true,
        fillColor: AppColors.white,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      style: TextStyle(
        color: AppColors.gray900,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
