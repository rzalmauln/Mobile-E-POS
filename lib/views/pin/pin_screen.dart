import 'package:e_pos/core/color_values.dart';
import 'package:e_pos/views/pin/widgets/pin_digit.dart';
import 'package:e_pos/views/store_screen.dart';
import 'package:e_pos/widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key, required this.isCreatingPin});
  final bool isCreatingPin;

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _inputText = '';
  String? _firstPin;
  String? _errorMessage;
  List _actives = [false, false, false, false];
  List _clears = [false, false, false, false];
  List _values = [1, 2, 2, 1];
  int _currentPinIndex = 0;

  void _deletePinDigit() {
    _inputText.isEmpty
        ? null
        : _inputText = _inputText.substring(0, _inputText.length - 1);

    _clears = _clears.map((e) => false).toList();
    _currentPinIndex--;

    if (_currentPinIndex >= 0) {
      setState(() {
        _clears[_currentPinIndex] = true;
        _actives[_currentPinIndex] = false;
      });
    } else {
      _currentPinIndex = 0;
    }
  }

  void _typePinDigit(int index) {
    index == 10 ? _inputText += '0' : _inputText += (index + 1).toString();

    _clears = _clears.map((e) => false).toList();

    setState(() {
      _actives[_currentPinIndex] = true;
      _currentPinIndex++;
    });

    if (_currentPinIndex == 4) {
      _maxedPinDigit();
    }
  }

  void _maxedPinDigit() async {
    final prefs = await SharedPreferences.getInstance();

    if (widget.isCreatingPin) {
      if (_firstPin == null) {
        _firstPin = _inputText;
        _clearPinDigit();
      } else {
        if (_firstPin == _inputText) {
          await prefs.setString('userpin', _inputText);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const StoreScreen()));
        } else {
          _clearPinDigit('Pin Salah');
        }
      }
    } else {
      final savedPin = prefs.getString('userpin');

      if (_inputText == savedPin) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const StoreScreen()));
      } else {
        _clearPinDigit('Pin Salah');
      }
    }
  }

  void _clearPinDigit([String? message]) {
    setState(() {
      if (message != null) {
        _errorMessage = message;
      }
      _clears = _clears.map((e) => true).toList();
      _actives = _actives.map((e) => false).toList();
    });

    _inputText = "";
    _currentPinIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    print('REBUILD');
    return Scaffold(
        appBar: const BasicAppBar(),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      widget.isCreatingPin
                          ? (_firstPin == null ? 'Buat PIN' : 'Konfirmasi PIN')
                          : 'Masukkan PIN',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 28, color: ColorValues.grayscale900),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPinDigits()),
                  ),
                ],
              ),
            ),
            if (_errorMessage != null)
              Text(
                '$_errorMessage',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: ColorValues.danger500),
              ),
            Expanded(
              flex: 2,
              child: _buildNumPad(),
            ),
          ],
        ));
  }

  List<Widget> _buildPinDigits() {
    return List.generate(
        _clears.length,
        (index) => PinDigit(
            clear: _clears[index],
            active: _actives[index],
            value: _values[index]));
  }

  Widget _buildNumPad() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1),
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
                      if (index == 11) {
                        _deletePinDigit();
                      } else {
                        _typePinDigit(index);
                      }
                      print('pin: $_inputText');
                    },
                    child: index == 11
                        ? const Icon(Icons.backspace)
                        : Text(
                            index == 10 ? '0' : '${index + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 28),
                          ),
                  ),
                ),
        );
      },
    );
  }
}
