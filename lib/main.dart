import 'package:flutter/material.dart';
//import 'package:expressions/expressions.dart';
void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        // Evaluate the expression
        try {
          _result = _evaluateExpression(_input);
        } catch (e) {
          _result = 'Error';
        }
        _input = '';
      } else if (value == 'C') {
        _input = '';
        _result = '';
      } else {
        _input += value;
      }
    });
  }

  String _evaluateExpression(String expression) {
    // Replace with a more robust evaluation if necessary
    // This is a very basic evaluation
    // For now, let's just use the built-in eval-like method (using Dart's native capabilities)
    // Note: This is a very basic implementation. For complex expressions, consider using an external package.
    var finalResult = double.parse(expression);
    return finalResult.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                alignment: Alignment.centerRight,
                child: Text(
                  _input,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                alignment: Alignment.centerRight,
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ...['7', '8', '9', '/'].map((value) {
                    return CalculatorButton(
                      value: value,
                      onPressed: _onButtonPressed,
                    );
                  }),
                  ...['4', '5', '6', '*'].map((value) {
                    return CalculatorButton(
                      value: value,
                      onPressed: _onButtonPressed,
                    );
                  }),
                  ...['1', '2', '3', '-'].map((value) {
                    return CalculatorButton(
                      value: value,
                      onPressed: _onButtonPressed,
                    );
                  }),
                  ...['C', '0', '=', '+'].map((value) {
                    return CalculatorButton(
                      value: value,
                      onPressed: _onButtonPressed,
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String value;
  final Function(String) onPressed;

  const CalculatorButton({
    Key? key,
    required this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(value),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
