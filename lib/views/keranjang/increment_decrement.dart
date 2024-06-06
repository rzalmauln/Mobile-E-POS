import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncrementDecrement extends StatefulWidget {
  final TextEditingController controller;
  int value;
  final String? labelText;
  final TextAlign? labelTextAlign;

  IncrementDecrement({
    required this.controller,
    required this.value,
    this.labelText,
    this.labelTextAlign,
    Key? key,
  }) : super(key: key);

  @override
  State<IncrementDecrement> createState() => _IncrementDecrementState();
}

class _IncrementDecrementState extends State<IncrementDecrement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            textAlign: widget.labelTextAlign,
          ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildIconButton(
                onPressed: widget.value <= 0
                    ? null
                    : () {
                  setState(() {
                    widget.value = widget.value - 1;
                    widget.controller.text = widget.value.toString();
                  });
                },
                icon: Icons.remove,
              ),
              SizedBox(
                width: 40,
                height: 32,
                child: TextField(
                  controller: widget.controller,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              _buildIconButton(
                onPressed: () {
                  setState(() {
                    widget.value = widget.value + 1;
                    widget.controller.text = widget.value.toString();
                  });
                },
                icon: Icons.add,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton({VoidCallback? onPressed, IconData? icon}) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: onPressed == null ? Colors.grey[300] : Colors.blue[600],
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: IconButton(
        icon: Icon(
          size: 12,
          icon,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
