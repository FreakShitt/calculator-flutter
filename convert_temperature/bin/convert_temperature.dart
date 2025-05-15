import 'dart:io';

void main() {
  print("Temperature Converter");
  print("---------------------");
  print("1. Celsius to Fahrenheit");
  print("2. Fahrenheit to Celsius");

  stdout.write("Enter your choice (1/2): ");
  int choice = int.parse(stdin.readLineSync()!);

  stdout.write("Enter temperature value: ");
  double temperature = double.parse(stdin.readLineSync()!);

  if (choice == 1) {
    double fahrenheit = celsiusToFahrenheit(temperature);
    print("$temperature°C is equal to $fahrenheit°F");
  } else if (choice == 2) {
    double celsius = fahrenheitToCelsius(temperature);
    print("$temperature°F is equal to $celsius°C");
  } else {
    print("Invalid choice");
  }
}

double celsiusToFahrenheit(double celsius) {
  return (celsius * 9 / 5) + 32;
}

double fahrenheitToCelsius(double fahrenheit) {
  return (fahrenheit - 32) * 5 / 9;
}
