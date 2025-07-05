import 'package:flutter/material.dart';
import 'package:multi/constants/dimensions.dart';
import 'package:multi/constants/styles.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  final String? hintText;
  final String? errorText;
  final bool isExpanded;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isDense;
  final bool filled;
  final Color? fillColor;
  final double? dropdownElevation;
  final BorderRadius? borderRadius;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool showTitle;

  const CustomDropdown({
    super.key,
    this.label = '',
    required this.value,
    required this.onChanged,
    required this.items,
    this.hintText,
    this.errorText,
    this.isExpanded = false,
    this.border,
    this.contentPadding,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense = false,
    this.filled = false,
    this.fillColor,
    this.dropdownElevation,
    this.borderRadius,
    this.focusNode,
    this.autofocus = false,
    this.showTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         showTitle
            ? Text(label,
                style:
                    robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall))
            : const SizedBox(),
        SizedBox(height: showTitle ? Dimensions.paddingSizeSmall : 0),
        DropdownButtonFormField<T>(
          value: value,
          focusNode: focusNode,
          autofocus: autofocus,
          dropdownColor: theme.cardColor,
          elevation: dropdownElevation?.toInt() ?? 8,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          decoration: InputDecoration(
            hintText: hintText,
            
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isDense: isDense,
            filled: filled,
            fillColor: Theme.of(context).cardColor,
            border: border ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 1.0,
              ),
            ),
            enabledBorder: border ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 0.3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width:  0.3,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1,
              ),
            ),
            contentPadding: contentPadding ?? const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            labelStyle: theme.inputDecorationTheme.labelStyle?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            hintStyle: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).hintColor),
          ),
          style: style ?? theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
          isExpanded: isExpanded,
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}