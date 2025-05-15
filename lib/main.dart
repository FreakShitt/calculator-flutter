import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const CalculatorHome(),
    const BiodataPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Biodata',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class BiodataPage extends StatelessWidget {
  const BiodataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Biodata'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Satrio Parikesit',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildInfoRow(Icons.school, 'Studying at', 'SMKN 1 BANTUL'),
              _buildInfoRow(Icons.location_on, 'Living in', 'Yogyakarta'),
              _buildInfoRow(Icons.cake, 'Born in', '2007'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.amber),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({Key? key}) : super(key: key);

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  String _operand = "";
  bool _operandClicked = false;
  String _currentOperation = "";
  List<String> _history = [];

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _operand = "";
        _operandClicked = false;
        _currentOperation = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        if (_currentInput.isNotEmpty) {
          _num1 = double.parse(_currentInput);
          _operand = buttonText;
          _operandClicked = true;
          _currentInput = "";
          _output = _num1.toString();
          _currentOperation = "$_num1 $_operand";
        }
      } else if (buttonText == "=") {
        double _num2 =
            _currentInput.isNotEmpty ? double.parse(_currentInput) : 0;
        String result = "";

        if (_operand == "+") {
          result = (_num1 + _num2).toString();
        } else if (_operand == "-") {
          result = (_num1 - _num2).toString();
        } else if (_operand == "×") {
          result = (_num1 * _num2).toString();
        } else if (_operand == "÷") {
          result = _num2 != 0 ? (_num1 / _num2).toString() : "Error";
        }

        // Format the result
        if (result.contains(".")) {
          result = result.replaceAll(RegExp(r"\.0+$"), "");
          result = result.replaceAll(RegExp(r"(\.\d+?)0+$"), r"$1");
        }

        // Add to history
        String historyItem = "$_currentOperation $_num2 = $result";
        _history.add(historyItem);

        _output = result;
        _currentInput = result;
        _operandClicked = false;
        _operand = "";
        _currentOperation = "";
      } else if (buttonText == ".") {
        if (!_currentInput.contains(".")) {
          _currentInput = _currentInput.isEmpty ? "0." : _currentInput + ".";
          _output = _currentInput;
        }
      } else {
        if (_operandClicked) {
          _currentInput = buttonText;
          _operandClicked = false;
        } else {
          _currentInput = _currentInput + buttonText;
        }
        _output = _currentInput;
      }

      // Remove trailing zeros after decimal point
      if (_output.contains(".")) {
        _output = _output.replaceAll(RegExp(r"\.0+$"), "");
        _output = _output.replaceAll(RegExp(r"(\.\d+?)0+$"), r"$1");
      }
    });
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Calculation History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _history.isEmpty
                    ? const Center(child: Text('No history yet'))
                    : ListView.builder(
                        itemCount: _history.length,
                        itemBuilder: (context, index) {
                          // Display history in reverse (newest first)
                          int reverseIndex = _history.length - 1 - index;
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              title: Text(_history[reverseIndex]),
                              trailing: const Icon(Icons.calculate),
                            ),
                          );
                        },
                      ),
              ),
              if (_history.isNotEmpty)
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        _history.clear();
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Clear History'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton(String buttonText, {Color color = Colors.blueGrey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showHistory,
          )
        ],
      ),
      body: Center(
        child: Container(
          width: 400, // Fixed width
          height: 600, // Fixed height
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              // Operation display
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                child: Text(
                  _currentOperation,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[400],
                  ),
                ),
              ),

              // Result display
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                child: Text(
                  _output,
                  style: const TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Divider
              const Divider(height: 1.0),

              // Buttons
              Expanded(
                child: Column(
                  children: <Widget>[
                    // Row 1
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton("7"),
                          _buildButton("8"),
                          _buildButton("9"),
                          _buildButton("÷",
                              color: const Color.fromARGB(255, 230, 138, 0)),
                        ],
                      ),
                    ),

                    // Row 2
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton("4"),
                          _buildButton("5"),
                          _buildButton("6"),
                          _buildButton("×",
                              color: const Color.fromARGB(255, 230, 138, 0)),
                        ],
                      ),
                    ),

                    // Row 3
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton("1"),
                          _buildButton("2"),
                          _buildButton("3"),
                          _buildButton("-",
                              color: const Color.fromARGB(255, 230, 138, 0)),
                        ],
                      ),
                    ),

                    // Row 4
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton("0"),
                          _buildButton("."),
                          _buildButton("C", color: Colors.red),
                          _buildButton("+",
                              color: const Color.fromARGB(255, 230, 138, 0)),
                        ],
                      ),
                    ),

                    // Row 5
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildButton("=", color: Colors.green),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
