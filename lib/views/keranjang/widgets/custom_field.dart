import 'package:e_pos/cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextAlign? textAlign;
  final double? borderRadius;
  final SvgPicture? suffixIcon;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatters;

  const CustomField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textAlign,
    this.borderRadius = 4,
    this.suffixIcon,
    this.labelText,
    this.textInputType,
    this.textInputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null && labelText != '') ...[
          Text(
            labelText!,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.grey),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        TextFormField(
          controller: controller,
          keyboardType: textInputType ?? TextInputType.text,
          inputFormatters: textInputFormatters,
          textAlign: textAlign ?? TextAlign.start,
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (value == "")
                return;
              else {
                context.read<CartCubit>().setPay(int.parse(value));
              }
            }
          },
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.grey),
          decoration: InputDecoration(
            prefixIcon: suffixIcon,
            prefixIconConstraints: const BoxConstraints(minWidth: 50),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            isDense: true,
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
