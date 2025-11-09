import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

enum InputState { normal, focus, error, success }

/// Champ de saisie personnalisé avec validation
class CustomInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final bool enabled;

  const CustomInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final FocusNode _focusNode = FocusNode();
  InputState _state = InputState.normal;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      if (_focusNode.hasFocus) {
        _state = InputState.focus;
      } else {
        _state = widget.errorText != null
            ? InputState.error
            : InputState.normal;
      }
    });
  }

  @override
  void didUpdateWidget(CustomInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != null && widget.errorText != oldWidget.errorText) {
      setState(() {
        _state = InputState.error;
      });
    }
  }

  Color _getBorderColor() {
    switch (_state) {
      case InputState.normal:
        return AppColors.grey300;
      case InputState.focus:
        return AppColors.amoureuxPrimary;
      case InputState.error:
        return AppColors.error;
      case InputState.success:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppStyles.body(
              fontweight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppStyles.space2),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppStyles.borderMd,
            border: Border.all(
              color: _getBorderColor(),
              width: _state == InputState.focus ? 2 : 1.5,
            ),
            boxShadow: _state == InputState.focus
                ? [
                    BoxShadow(
                      color: _getBorderColor().withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            enabled: widget.enabled,
            style: AppStyles.body(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppStyles.body(
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppStyles.space4,
                vertical: AppStyles.space3,
              ),
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: AppStyles.space1),
          Row(
            children: [
              Icon(Icons.error_outline, size: 16, color: AppColors.error),
              const SizedBox(width: AppStyles.space1),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: AppStyles.bodySmall(color: AppColors.error),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
