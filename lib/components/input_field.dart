import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.trailing,
    this.enabled,
    this.onChanged,
    this.textInputType,
    this.multiline,
    this.validator,
  });
  final TextEditingController controller;
  final Widget? icon;
  final String hintText;
  final Widget? trailing;
  final bool? enabled;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final bool? multiline;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: multiline ?? false ? null : 55,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 15.0),
        child: Center(
          child: TextFormField(
            maxLines: multiline ?? false ? 5 : 1,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              icon: icon,
              suffixIcon: trailing,
              enabled: enabled ?? true,
              errorStyle: const TextStyle(
                height: 0.4,
              ),
            ),
            validator: validator,
            inputFormatters: textInputType == TextInputType.emailAddress
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(
                      RegExp('\n'),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(r'[-]'),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(r' '),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(r','),
                    ),
                  ]
                : textInputType == TextInputType.phone ||
                        textInputType == TextInputType.number
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ]
                    : <TextInputFormatter>[],
            onChanged: onChanged,
            keyboardType: textInputType,
          ),
        ),
      ),
    );
  }
}
