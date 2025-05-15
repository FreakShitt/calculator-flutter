import 'dart:io';

void main() {
  print("Temperature Converter");
  print("1. Celsius");
  print("2. Fahrenheit");
  print("3. Kelvin");
  print("4. Reamur");

  stdout.write("Choose the initial temperature unit: ");
  int choice = int.parse(stdin.readLineSync()!);

  stdout.write("Enter the temperature value: ");
  double temperature = double.parse(stdin.readLineSync()!);

  if (choice == 1) {
    print("You chose Celsius");
    print("Celsius: $temperature");
    print("Fahrenheit: ${(temperature * 9 / 5) + 32}");
    print("Kelvin: ${temperature + 273.15}");
    print("Reamur: ${temperature * 0.8}");
  } else if (choice == 2) {
    print("You chose Fahrenheit");
    print("Fahrenheit: $temperature");
    print("Celsius: ${(temperature - 32) * 5 / 9}");
    print("Kelvin: ${(temperature - 32) * 5 / 9 + 273.15}");
    print("Reamur: ${(temperature - 32) * 4 / 9}");
  } else if (choice == 3) {
    print("You chose Kelvin");
    print("Kelvin: $temperature");
    print("Celsius: ${temperature - 273.15}");
    print("Fahrenheit: ${(temperature - 273.15) * 9 / 5 + 32}");
    print("Reamur: ${(temperature - 273.15) * 0.8}");
  } else if (choice == 4) {
    print("You chose Reamur");
    print("Reamur: $temperature");
    print("Celsius: ${temperature / 0.8}");
    print("Fahrenheit: ${temperature / 0.8 * 9 / 5 + 32}");
    print("Kelvin: ${temperature / 0.8 + 273.15}");
  } else {
    print("Invalid choice");
  }
}
