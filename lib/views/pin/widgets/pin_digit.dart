import 'package:flutter/material.dart';
import 'package:e_pos/core/color_values.dart';

class PinDigit extends StatefulWidget {
  const PinDigit({
    super.key,
    this.clear = false,
    this.active = false,
    required this.value
  });

  final bool clear;
  final bool active;
  final int value;

  @override
  State<PinDigit> createState() => _PinDigitState();
}

class _PinDigitState extends State<PinDigit> with TickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600)
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget.clear) {
      animationController.forward(from: 0);
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Container(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.active
                        ? ColorValues.primary600
                        : ColorValues.grayscale200
                ),
              ),
              Align(
                alignment: Alignment(
                    0,
                    animationController.value / widget.value - 1
                ),
                child: Opacity(
                  opacity: 1 - animationController.value,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.active
                            ? ColorValues.primary600
                            : ColorValues.grayscale200
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}