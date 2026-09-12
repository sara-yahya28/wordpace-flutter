import 'package:flutter/material.dart';
import 'package:wordspace/core/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  // ⚠️ تم إهمال هذه الخاصية — كل حقل يتحكم بنفسه الآن
  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    required this.hint,
    this.icon,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.autovalidateMode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // ✅ نراقب التركيز على هذا الحقل
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      // ✅ التحقق الفوري فقط لما الحقل يكون مركز
      autovalidateMode: _hasFocus
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      builder: (FormFieldState<String> state) {
        return TextField(
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: TextInputAction.next,
          onChanged: state.didChange,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: AppTheme.primaryMedium)
                : null,
            suffixIcon: widget.suffixIcon,
            // ✅ نعرض الخطأ فقط لو الحقل مركز
            errorText: _hasFocus ? state.errorText : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.primaryMedium, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}