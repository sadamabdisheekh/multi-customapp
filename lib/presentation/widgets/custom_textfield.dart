import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/dimensions.dart';
import '../../constants/styles.dart';

class CustomTextField extends StatefulWidget {
  final String titleText;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixImage;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double prefixSize;
  final TextAlign textAlign;
  final bool isAmount;
  final bool isNumber;
  final bool showTitle;
  final bool showBorder;
  final double iconSize;
  final bool isPhone;

  const CustomTextField({
    super.key,
    this.titleText = 'Write something...',
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSubmit,
    this.onChanged,
    this.prefixImage,
    this.prefixIcon,
    this.suffixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.prefixSize = Dimensions.paddingSizeSmall,
    this.textAlign = TextAlign.start,
    this.isAmount = false,
    this.isNumber = false,
    this.showTitle = false,
    this.showBorder = true,
    this.iconSize = 18,
    this.isPhone = false,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle
            ? Text(widget.titleText,
                style:
                    robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall))
            : const SizedBox(),
        SizedBox(height: widget.showTitle ? Dimensions.paddingSizeSmall : 0),
        TextField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: widget.textAlign,
          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
          textInputAction: widget.inputAction,
          keyboardType:
              widget.isAmount ? TextInputType.number : widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ]
              : widget.isAmount
                  ? [FilteringTextInputFormatter.allow(RegExp(r'\d'))]
                  : widget.isNumber
                      ? [FilteringTextInputFormatter.allow(RegExp(r'\d'))]
                      : null,
          decoration: InputDecoration(
            
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(
                  style:
                      widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                  width: 0.3,
                  color: Theme.of(context).primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(
                  style:
                      widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                  width: 1,
                  color: Theme.of(context).primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(
                  style:
                      widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                  width: 0.3,
                  color: Theme.of(context).primaryColor),
            ),
            isDense: true,
            hintText:
                widget.hintText.isEmpty ? widget.titleText : widget.hintText,
            fillColor: Theme.of(context).cardColor,
            hintStyle: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).hintColor),
            filled: true,
            prefixIcon: widget.prefixImage != null && widget.prefixIcon == null
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: widget.prefixSize),
                    child:
                        Image.asset(widget.prefixImage!, height: 20, width: 20),
                  )
                : widget.prefixImage == null && widget.prefixIcon != null
                    ? Icon(widget.prefixIcon, size: widget.iconSize)
                    : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle,
                  )
                : (widget.suffixIcon != null)
                    ? Icon(widget.suffixIcon,
                        color: Theme.of(context).primaryColor)
                    : null,
          ),
          onSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit!(text)
                  : null,
          onChanged: widget.onChanged as void Function(String)?,
        ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
