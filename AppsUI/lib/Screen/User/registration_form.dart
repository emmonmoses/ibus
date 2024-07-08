import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:Weyeyet/Screen/home_page.dart';
import 'package:Weyeyet/model/customer/registeration.dart';
import 'package:Weyeyet/service/customer/registration.dart';
import 'package:Weyeyet/utilities/app_theme.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  String? selectedRoute; // Updated to allow null
  String? selectedTripType; // Updated to allow null

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final UserService userService = UserService();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final user = CustomerRegistration(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: Phone(
          code: '+251',
          number: phoneController.text.trim(),
        ),
        address: Address(
          city: cityController.text.trim(),
          region: regionController.text.trim(),
          country: countryController.text.trim(),
        ),
        roleId: selectedRoute ?? '', // Use selectedRoute or a default value
        tripTypeId: selectedTripType ?? '', // Use selectedTripType or a default value
      );

      bool success = await userService.registerUser(user);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        // Navigate to Homepage after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              detailItemsHeader(),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildTextField(nameController, 'Name', 'Please enter your name'),
                    const SizedBox(height: 20),
                    buildTextField(emailController, 'Email', 'Please enter a valid email',
                        validator: (value) {
                          if (value != null && !value.isEmpty) {
                            return RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value)
                                ? null
                                : 'Please enter a valid email';
                          } else {
                            return 'Please enter your email';
                          }
                        }),
                    const SizedBox(height: 20),
                    buildTextField(passwordController, 'Password', 'Please enter your password'),
                    const SizedBox(height: 20),
                    buildTextField(phoneController, 'Phone Number', 'Please enter your phone number'),
                    const SizedBox(height: 20),
                    buildTextField(cityController, 'City', 'Please enter your city'),
                    const SizedBox(height: 20),
                    buildTextField(regionController, 'Region', 'Please enter your region'),
                    const SizedBox(height: 20),
                    buildTextField(countryController, 'Country', 'Please enter your country'),
                    const SizedBox(height: 20),
                    buildDropdownField(
                      'Route',
                      ['Route A', 'Route B', 'Route C'],
                      selectedRoute,
                          (value) {
                        setState(() {
                          selectedRoute = value;
                        });
                      },
                          (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Please select a route',
                    ),
                    const SizedBox(height: 20),
                    buildTripTypeSelection(),
                    const SizedBox(height: 40),
                    MaterialButton(
                      minWidth: double.infinity,
                      onPressed: _isLoading ? null : _register,
                      color: AppColor.deepBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: _isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('/login');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      String errorText,
      {String? Function(String?)? validator}) {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: validator ?? (value) => value != null && value.isNotEmpty
            ? null
            : errorText,
      ),
    );
  }

  Widget buildDropdownField(String labelText, List<String> items, String? value,
      void Function(String?) onChanged, String? Function(String?)? validator) {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: validator ?? (value) => value != null && value.isNotEmpty
            ? null
            : 'Please select a $labelText',
      ),
    );
  }

  Widget buildTripTypeSelection() {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trip Type',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTripType = 'One Time';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedTripType == 'One Time' ? AppColor.deepBlue : Colors.grey.shade300,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('One Time'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedTripType = 'Round Trip';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedTripType == 'Round Trip' ? AppColor.deepBlue : Colors.grey.shade300,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Round Trip'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding detailItemsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          FadeInDown(
            delay: const Duration(milliseconds: 100),
            child: Material(
              color: AppColor.deepBlue,
              borderRadius: BorderRadius.circular(10),
              child: BackButton(
                color: AppColor.white,
              ),
            ),
          ),
          const Spacer(),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: Text(
              "REGISTER",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColor.deepBlue),
            ),
          ),
          const Spacer(),
          FadeInDown(
            delay: const Duration(milliseconds: 300),
            child: Material(
              color: Colors.white.withOpacity(0.21),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
