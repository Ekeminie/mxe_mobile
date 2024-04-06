import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';

class Input extends StatefulWidget {
  final BorderSide? underlineBorderStyle;
  final Color? hintStyleColor;
  final Color? textColor;
  final bool? readOnly;
  final bool? enabled;
  final bool? obscureText;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? helperText;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Widget? suffix;
  final bool? autofocus;
  final String? prefixText;
  final Widget? prefixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? prefixStyle;
  final double borderRadius;
  List<String>? autofillHints;
  String? errorText;

  Input(
      {Key? key,
      this.underlineBorderStyle,
      this.hintStyleColor,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.helperText,
      this.controller,
      this.onSubmit,
      this.suffixIcon,
      this.keyboardType,
      this.prefixWidget,
      this.onTap,
      this.onSaved,
      this.autofocus,
      this.maxLines,
      this.textInputAction,
      this.borderRadius = 8,
      this.autocorrect = false,
      this.enableSuggestions = true,
      this.obscureText = false,
      this.suffix,
      this.prefixText,
      this.readOnly = false,
      this.enabled = true,
      this.inputFormatters,
      this.textColor,
      this.prefixStyle,
      this.autofillHints,
      this.errorText})
      : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late FocusNode _focus;
  bool _isFocus = false;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocus = _focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.symmetric(
                // horizontal: 12.0,
                // vertical: 2.0,
                ),
            decoration: (_isFocus && widget.errorText == null)
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: const Color(0xff7257FF).withOpacity(0.3),
                        width: 4))
                : null,
            child: TextFormField(
              autofillHints: widget.autofillHints,
              onFieldSubmitted: widget.onSubmit,
              style: TextStyle(color: widget.textColor ?? primaryDarkColor),
              enabled: widget.enabled,
              readOnly: widget.readOnly!,
              inputFormatters: widget.inputFormatters ?? [],
              autofocus: widget.autofocus ?? false,
              focusNode: _focus,
              onChanged: widget.onChanged,
              maxLines: widget.maxLines ?? 1,
              controller: widget.controller,
              autocorrect: widget.autocorrect ?? true,
              enableSuggestions: widget.enableSuggestions ?? true,
              obscureText: widget.obscureText ?? false,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              onTap: widget.onTap,
              onSaved: widget.onSaved,
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.errorCode)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: widget.underlineBorderStyle ??
                        const BorderSide(width: 1, color: AppColors.border)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: widget.underlineBorderStyle ??
                        const BorderSide(width: 1, color: AppColors.errorCode)),
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                hintStyle: TextStyle(
                    height: 0,
                    fontSize: 15,
                    color: widget.hintStyleColor ?? AppColors.greyText),
                errorStyle: const TextStyle(
                    height: 1, fontSize: 15, color: AppColors.errorCode),
                labelStyle: TextStyle(
                    height: 1,
                    fontSize: 15,
                    color: widget.hintStyleColor ?? primaryDarkColor),
                errorText: widget.errorText,

                labelText: widget.labelText,
                hintText: "     ${widget.hintText}",
                suffixIcon: widget.suffixIcon,
                prefixText: widget.prefixText,
                prefixStyle: widget.prefixStyle,
                prefixIcon: widget.prefixWidget,
                // suffixIconConstraints: BoxConstraints.tight(Size(30.w, 40.h)),
                suffix: widget.suffix,
              ),
            ),
          ),
        ),
        if (widget.helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.helperText!,
              style: TextStyle(fontSize: 12, color: textDark),
            ),
          )
      ],
    );
  }
}

class TInput extends StatefulWidget {
  final bool? readOnly;
  final bool? enabled;
  final bool? obscureText;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? helperText;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Widget? suffix;
  final bool? autofocus;
  final String? prefixText;
  final Widget? prefixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;

  const TInput(
      {Key? key,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.helperText,
      this.controller,
      this.onSubmit,
      this.suffixIcon,
      this.keyboardType,
      this.prefixWidget,
      this.onTap,
      this.onSaved,
      this.autofocus,
      this.maxLines,
      this.textInputAction,
      this.borderRadius = 8,
      this.autocorrect = false,
      this.enableSuggestions = true,
      this.obscureText = false,
      this.suffix,
      this.prefixText,
      this.readOnly = false,
      this.enabled = true,
      this.inputFormatters})
      : super(key: key);

  @override
  State<TInput> createState() => _TInputState();
}

class _TInputState extends State<TInput> {
  late FocusNode _focus;
  bool _isFocus = false;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocus = _focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 2.0,
          ),
          decoration: BoxDecoration(
            color: _isFocus ? inputFocus : white,
            border: Border.all(
              width: 2,
              color: _isFocus ? primaryColor : textFieldBorder,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: TextFormField(
            onFieldSubmitted: widget.onSubmit,
            style: TextStyle(color: primaryDarkColor),
            enabled: widget.enabled,
            readOnly: widget.readOnly!,
            inputFormatters: widget.inputFormatters ?? [],
            autofocus: widget.autofocus ?? false,
            focusNode: _focus,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            autocorrect: widget.autocorrect ?? true,
            enableSuggestions: widget.enableSuggestions ?? true,
            obscureText: widget.obscureText ?? false,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onTap: widget.onTap,
            onSaved: widget.onSaved,
            decoration: InputDecoration(
              // border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              hintStyle:
                  TextStyle(height: 0, fontSize: 15, color: primaryDarkColor),
              labelStyle:
                  TextStyle(height: 1, fontSize: 15, color: primaryDarkColor),
              border: InputBorder.none,
              labelText: widget.labelText,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              prefixText: widget.prefixText,
              prefixIcon: widget.prefixWidget,
              // suffixIconConstraints: BoxConstraints.tight(Size(30.w, 40.h)),
              suffix: widget.suffix,
            ),
          ),
        ),
        if (widget.helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.helperText!,
              style: TextStyle(fontSize: 12, color: textDark),
            ),
          )
      ],
    );
  }
}
