import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? _selectedPaymentMethod;

  void _selectPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment Method", style: GoogleFonts.lato(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Please select your payment method.",
                style: GoogleFonts.lato(fontSize: 16, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildPaymentMethodTile("E-Wallet", [
                      "Ebirr",
                      "CbeBirr",
                      "Telebirr",
                    ]),
                    _buildPaymentMethodTile("Bank Transfer", [
                      "CBE",
                      "Abissinia Bank",
                      "Dashen Bank",
                      "COOP"
                    ]),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _selectedPaymentMethod == null ? null : () {
                  // Implement the proceed to payment functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.deepBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  _selectedPaymentMethod == null
                      ? 'Select Payment Method'
                      : 'Proceed to $_selectedPaymentMethod',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(String title, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        textColor: AppColor.deepBlue,
        iconColor: AppColor.deepBlue,
        title: Text(
          title,
          style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: options.map((option) {
          return ListTile(
            title: Text(option, style: GoogleFonts.lato(fontSize: 16)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.deepBlue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                _selectPaymentMethod(option);
              },
              child: Text('Select', style: TextStyle(color: AppColor.white)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
