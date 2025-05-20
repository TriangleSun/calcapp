import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hesap Makinesi',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontSize: 20, color: CupertinoColors.black),
          navLargeTitleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: CupertinoColors.black),
        ),
      ),
      home: SafeArea(child: CalculatorPage()),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _input = "";
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      } else if (value == "=") {
        _num2 = double.tryParse(_input) ?? 0;
        switch (_operator) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "x":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            _output = _num2 == 0 ? "Hata" : (_num1 / _num2).toString();
            break;
        }
        _input = "";
        _operator = "";
      } else if (["+", "-", "x", "/"].contains(value)) {
        _num1 = double.tryParse(_input) ?? 0;
        _operator = value;
        _input = "";
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTapDown: (_) => _buttonPressed(value),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              value,
              style: TextStyle(fontSize: 24, color: CupertinoColors.black),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Hesap Makinesi'),
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w300, color: CupertinoColors.black),
              ),
            ),
            Divider(height: 1, color: CupertinoColors.systemGrey4),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("/")
                    ]),
                    Row(children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("x")
                    ]),
                    Row(children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("-")
                    ]),
                    Row(children: [
                      _buildButton("0"),
                      _buildButton("C"),
                      _buildButton("="),
                      _buildButton("+")
                    ])
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
