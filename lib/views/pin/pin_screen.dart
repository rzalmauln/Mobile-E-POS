import 'package:e_pos/core/color_values.dart';
import 'package:e_pos/widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String inputText = '';
  List actives = [false, false, false, false];
  List clears = [false, false, false, false];
  List values = [1,2,3,4]
  int currentPinIndex = 0;

  List<Widget> _buildPinDigits() {
    return List.generate(clears.length, (index) =>
        PinDigit(
          clear: clears[index],
          active: actives[index],
          value: values[index]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Column(
        children: [
          // Text(
          //   'Buat PIN',
          //   textAlign: TextAlign.center,
          //   style: Theme.of(context).textTheme
          //       .titleLarge!
          //       .copyWith(
          //         fontSize: 28,
          //         color: ColorValues.grayscale900
          //       ),
          // ),
          Expanded(

            flex: 1,
            child:  Center(
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPinDigits()
                ),
              )
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(1),
                  child: index == 9
                      ? const SizedBox()
                      : Center(
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: double.infinity,
                            onPressed: () {
                              setState(() {
                                actives[currentPinIndex] = true;
                                currentPinIndex++;
                              });

                              if(index == 11) {
                                inputText.isEmpty
                                    ? null
                                    : inputText = inputText.substring(
                                      0,
                                      inputText.length - 1
                                      );
                              } else {
                                index == 11
                                    ? inputText += '0'
                                    : inputText += (index + 1).toString();
                              }
                              print('pin: $inputText');
                            },
                            child: index == 11
                                ? const Icon(Icons.backspace)
                                : Text(
                                    index == 10 ? '0' : '${index + 1}',
                                    style: Theme.of(context).textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontSize: 28
                                    ),
                                  ),
                          ),
                      ),
                );
              },
            ),
          )
        ],
      )
    );
  }
}

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
              )
            ],
          ),
        );
      },
    );
  }
}
