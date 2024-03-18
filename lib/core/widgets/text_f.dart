import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/dimens.dart';
import '../resources/palette.dart';
import '../resources/styles.dart';

class TextF extends StatefulWidget {
  const TextF({
    super.key,
    this.curFocusNode,
    this.nextFocusNode,
    this.hint,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.suffixIcon,
    this.controller,
    this.onTap,
    this.textAlign,
    this.enable,
    this.inputFormatter,
    this.minLine,
    this.maxLine,
    required this.prefixIcon,
    this.isHintVisible = true,
    this.prefixText,
    this.hintText,
    this.autofillHints,
  });

  final FocusNode? curFocusNode;
  final FocusNode? nextFocusNode;
  final String? hint;
  final Function(String)? validator;
  final Function(String)? onChanged;
  final Function? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? obscureText;
  final int? minLine;
  final int? maxLine;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatter;
  final bool isHintVisible;
  final Widget prefixIcon;
  final String? prefixText;
  final String? hintText;
  final Iterable<String>? autofillHints;

  @override
  _TextFState createState() => _TextFState();
}

class _TextFState extends State<TextF> {
  bool isFocus = false;
  String currentVal = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: Dimens.space8),
      child: TextFormField(
        style: Theme
            .of(context)
            .textTheme
            .bodySmall,
        key: widget.key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: widget.autofillHints,
        enabled: widget.enable,
        obscureText: widget.obscureText ?? false,
        focusNode: widget.curFocusNode,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign ?? TextAlign.start,
        minLines: widget.minLine ?? 1,
        maxLines: widget.maxLine ?? 10,
        inputFormatters: widget.inputFormatter,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Palette.text,
        decoration: InputDecoration(
          prefixText: widget.prefixText,
          alignLabelWithHint: true,
          isDense: true,
          hintText: widget.hintText,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.space12),
            child: widget.prefixIcon,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.space12),
            child: widget.suffixIcon,
          ),
          prefixIconConstraints: BoxConstraints(
            minHeight: Dimens.space24,
            maxHeight: Dimens.space24,
          ),
          suffixIconConstraints: BoxConstraints(
            minHeight: Dimens.space24,
            maxHeight: Dimens.space24,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: Dimens.space16,
            horizontal: Dimens.space22,
          ),
        ),
        validator: widget.validator as String? Function(String?)?,
        onChanged: widget.onChanged,
        onTap: widget.onTap as void Function()?,
        onFieldSubmitted: (value) {
          setState(
                () {
              fieldFocusChange(
                context,
                widget.curFocusNode ?? FocusNode(),
                widget.nextFocusNode,
              );
            },
          );
        },
      ),
    );
  }

  void fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode? nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
