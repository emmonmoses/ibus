import 'package:flutter/material.dart';
import 'package:Weyeyet/model/customer/login_request.dart';
import 'package:Weyeyet/model/customer/login_response.dart';
import 'package:Weyeyet/service/customer/login_service.dart';
import 'package:Weyeyet/Screen/home_page.dart';
import 'package:Weyeyet/Screen/User/registration_form.dart';
import 'package:Weyeyet/Screen/User/forgot_password.dart'; // Import your forgot password screen
import 'package:Weyeyet/utilities/app_theme.dart';
import 'package:animate_do/animate_do.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final LoginService _loginService = LoginService();

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please enter both email and password.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final request = LoginRequest(username: email, password: password);
      LoginResponse? response = await _loginService.login(request);

      setState(() {
        _isLoading = false;
      });

      if (response != null && response.token.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        _showSnackBar('Login failed. Please try again.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Handling specific error messages
      if (e.toString().contains('Username Provided is Not Valid')) {
        _showSnackBar('The username provided is not valid.');
      }
      if (e
          .toString()
          .contains('"password" length must be at least 6 characters long')) {
        _showSnackBar('Password length must be at least 6 characters long.');
      }
      if (e.toString().contains('The Password Provided is Not Valid')) {
        _showSnackBar('Incorrect email or password.');
      } else {
        _showSnackBar('An error occurred during login. Please try again.');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/password.jpg',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 50),
              FadeInDown(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20),
                  child: Text(
                    'Sign in and start your journey with us today!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: AppColor.grey),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.deepBlue, width: 2.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                child: TextField(
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.deepBlue, width: 2.0),
                    ),
                    labelStyle: TextStyle(color: AppColor.grey),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColor.deepBlue,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Adjusted spacing
              FadeInDown(
                delay: const Duration(milliseconds: 700),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPasswordScreen()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColor.deepBlue,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60), // Adjusted spacing
              FadeInDown(
                delay: const Duration(milliseconds: 800),
                child: MaterialButton(
                  minWidth: double.infinity,
                  onPressed: _login,
                  color: AppColor.deepBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: _isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            color: AppColor.deepBlue,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: const Duration(milliseconds: 1000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserRegistration()),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: AppColor.deepBlue),
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
