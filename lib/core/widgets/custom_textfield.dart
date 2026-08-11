import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.backgroundColor = Colora.primaryColor,
    this.keyboardType = TextInputType.name,
    required this.text,
    this.maxLine = 1,
    this.maxLength,
    this.color = Colora.scaffold,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.hintStyle = const TextStyle(color: Colora.borderTag, fontSize: 13),
    this.style,
    this.align = TextAlign.start,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
    this.isRequired = false,
    this.labelText,
    this.prefixText,
    this.prefixStyle,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.onChanged,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final int maxLine;
  final int? maxLength;
  final Color color;
  final bool isRequired;
  final Color? borderColor;
  final Color backgroundColor;
  final TextStyle hintStyle;
  final TextStyle? style;
  final TextAlign align;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  final ValueNotifier<Color> borderColorNotifier = ValueNotifier(
    Colora.borderTag,
  );

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      borderColorNotifier.value = Colora.borderTag;
    } else {
      borderColorNotifier.value =
          widget.controller.text.isEmpty && widget.isRequired
              ? Colors.red
              : Colora.borderTag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding!,
      child: ValueListenableBuilder<Color>(
        valueListenable: borderColorNotifier,
        builder: (context, borderColor, child) {
          return TextFormField(
            maxLength: widget.maxLength,
            textDirection: TextDirection.rtl,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: TextInputAction.next,
            focusNode: _focusNode,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            style:
                widget.style ??
                TextStyle(
                  color:
                      widget.color != Colora.scaffold
                          ? Colors.white
                          : Colora.borderTag,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
            maxLines: widget.maxLine,
            textAlign: widget.align,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                right: Dimensions.ten,
                left: Dimensions.ten,
                top: Dimensions.ten,
              ),
              counterText: "",
              filled: true,
              fillColor: widget.color,
              hintText: widget.text,
              hintTextDirection: TextDirection.rtl,
              hintStyle: widget.hintStyle,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(Dimensions.twenty),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? borderColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(Dimensions.twenty),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? borderColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(Dimensions.twenty),
              ),
              labelText: widget.labelText,
              prefixText: widget.prefixText,
              prefixStyle: widget.prefixStyle,
            ),
            onFieldSubmitted: (value) {
              if (widget.isRequired) {
                setState(() {
                  widget.controller.text.isEmpty
                      ? borderColorNotifier.value = Colors.red
                      : borderColorNotifier.value = Colora.borderTag;
                });
              }
            },
          );
        },
      ),
    );
  }
}
