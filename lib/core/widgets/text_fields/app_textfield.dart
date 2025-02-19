import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextfield extends StatefulWidget {
  final String? Function(String?)? validator;
  final String labelText;
  final double width;
  final double? hight;
  final String? suffixIcon;
  final String? suffixIcon2;
  final String? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final int maxLines;
  final int minLines;
  final bool buttomMargin;
  final bool readOnly;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final InputDecoration? decoration;
  final int? maxLength;
  final void Function()? onTap;
  final void Function()? onTapSuffix;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSaved;
  final void Function()? onTapPrefix;

  const AppTextfield({
    super.key,
    required this.labelText,
    this.width = double.infinity,
    this.hight,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    this.suffixIcon,
    this.suffixIcon2,
    this.decoration,
    this.prefixIcon,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
    this.buttomMargin = true,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onTapSuffix,
    this.textInputAction,
    this.maxLength,
    this.onSaved,
    this.onTapPrefix,
  });

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: SizedBox(
        width: widget.width,
        height: widget.hight,
        child: Column(
          children: [
            InkWell(
              onTap: widget.onTap,
              child: IgnorePointer(
                ignoring: widget.readOnly,
                child: TextFormField(
                  readOnly: widget.readOnly,
                  obscuringCharacter: '*',
                  obscureText: obscureText,
                  inputFormatters: widget.inputFormatters,
                  validator: widget.validator,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  onSaved: widget.onSaved,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  onEditingComplete: widget.onEditingComplete,
                  maxLength: widget.maxLength,
                  textInputAction: widget.textInputAction,

                  ///----input text style
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                  ),

                  decoration: widget.decoration ??
                      InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),

                        ///----Prefix Icon
                        prefixIconConstraints:
                            const BoxConstraints(maxWidth: 50),
                        prefixIcon: (widget.prefixIcon != null)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: MyIcon(
                                  icon: widget.prefixIcon.toString(),
                                  onTap: widget.onTapPrefix,
                                ),
                              )
                            : null,

                        ///----Suffix Icon
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: 50),

                        suffixIcon: (widget.suffixIcon != null ||
                                widget.suffixIcon2 != null)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: MyIcon(
                                  icon: obscureText
                                      ? widget.suffixIcon2.toString()
                                      : widget.suffixIcon.toString(),
                                  onTap: widget.onTapSuffix ??
                                      (widget.suffixIcon2 == null
                                          ? () {}
                                          : () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            }),
                                ),
                              )
                            : const SizedBox(),

                        ///----Label Text
                        labelText: widget.labelText,
                        labelStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500),

                        ///----Border
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.lightGray,
                            ),
                            borderRadius: BorderRadius.circular(40)),

                        ///----Enabled Border
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.lightGray,
                            ),
                            borderRadius: BorderRadius.circular(40)),

                        ///----Focused Border
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.gray,
                            ),
                            borderRadius: BorderRadius.circular(40)),

                        ///----Error Border
                        errorStyle: const TextStyle(color: AppColors.errorRed),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.errorRed,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
