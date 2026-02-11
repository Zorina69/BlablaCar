import 'package:flutter/material.dart';

class SeatAmountScreen extends StatefulWidget {
  // final int selectedseat;
  const SeatAmountScreen({super.key,});

  @override
  State<SeatAmountScreen> createState() => _SeatAmountScreenState();
}

class _SeatAmountScreenState extends State<SeatAmountScreen> {
  @override
  Widget build(BuildContext context) {
    int seat = 1;

    void increase() {
      setState(() {
        seat++;
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("Choose amount of Seat: ")),
      body: Row(),
    );
  }
}
