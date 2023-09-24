import 'package:flutter/material.dart';


class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  
  String num1 = "";
  String num2 = "";
  String operand = "";
  
  int currentIndex = 1;
  String output = "";
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              'Calculator',
            ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 12,
              ),
              child: Text(
                "$num1$operand$num2".isEmpty
                  ? "0"
                  : "$num1$operand$num2",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('AC', 4),
                buildButton('+-', 4),
                buildButton('%', 4),
                buildButton('/', 4),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('7', 4),
                buildButton('8', 4),
                buildButton('9', 4),
                buildButton('X', 4),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('4', 4),
                buildButton('5', 4),
                buildButton('6', 4),
                buildButton('-', 4),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('1', 4),
                buildButton('2', 4),
                buildButton('3', 4),
                buildButton('+', 4),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('0', 3),
                buildButton('.', 3),
                buildButton('=', 3),
                
              ],
            ),
          ],),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.sunny), label: 'Weather'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: 'Calculator'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context,);
          }
        },
      ),
      

      

    );
  }

  void calculate() {
    double n1 = double.parse(num1);
    double n2 = double.parse(num2);
    double result = 0;

    switch (operand) {
      case '+':
        result = n1 + n2;
        break;
      case '-':
        result = n1 - n2;
        break;
      case 'X':
        result = n1 * n2;
        break;
      case '/':
        if (n2 != 0) {
          result = n1 / n2;
        } else {
          output = "Error";
          return;
        }
        break;
      case '%':
        result = n1 / 100;
        break;
      default:
        return;
    }

    output = result.toString();
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        num1 = "";
        num2 = "";
        operand = "";
        output = "0";
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == 'X' ||
          buttonText == '/' ) {

        if (num1.isNotEmpty) {
          operand = buttonText;
        } 
        
      } else if (buttonText == '=') {
        calculate();
        num1 = output;
        num2 = "";
        operand = "";
      } else if(buttonText == '%'){
        num1 = (double.parse(num1) / 100).toString();
      }else if(buttonText == '+-'){
        num1 = (double.parse(num1)*-1).toString();
      } else {
        if (operand.isEmpty) {
          num1 += buttonText;
        } else {
          num2 += buttonText;
        }
      }
      output = "$num1$operand$num2";
    });
    
  }

  Widget buildButton(String buttonText, int divBy) {
      final screenSize=MediaQuery.of(context).size;
     
    return  SizedBox(
      
       width: screenSize.width/divBy,
       height: screenSize.width/5,
       
  
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          shape: const LinearBorder(),
          padding: const EdgeInsets.all(5),
          backgroundColor: Colors.grey,
          
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            
          ),
        ),
      ),
    );
  }
}