import 'dart:async';
import 'dart:convert';
import 'package:caremall/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool _isOtpSent = false;
  bool _isLoading = false;
  String _authMode = "login";

  Timer? _timer;
  int _timerValue = 60;
  bool _canResend = false;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final String _baseUrl = "https://api.caremall.in/api/v1/user/auth";
  final Color _primaryColor = const Color(0xFFFF0000);

  @override
  void dispose() {
    _timer?.cancel();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _timerValue = 60;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerValue == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() => _timerValue--);
      }
    });
  }

  void _resetState() {
    setState(() {
      _isOtpSent = false;
      _otpController.clear();
      _timer?.cancel();
    });
  }

  Future<void> _sendOtp() async {
    final phoneValue = _phoneController.text.trim();
    if (phoneValue.length < 10) {
      _showSnackBar("Please enter a valid 10-digit number");
      return;
    }

    setState(() => _isLoading = true);
    try {
      _authMode = "login";
      var response = await http
          .post(
            Uri.parse("$_baseUrl/send-otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"phone": phoneValue, "mode": _authMode}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        String msg = errorData['message'].toString().toLowerCase();

        if (msg.contains("not registered") || msg.contains("not found")) {
          _authMode = "signup";
          response = await http.post(
            Uri.parse("$_baseUrl/send-otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "phone": phoneValue,
              "mode": _authMode,
              "name": "User",
              "email": "user$phoneValue@caremall.in",
            }),
          );
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() => _isOtpSent = true);
        _startTimer();
        _showSnackBar("OTP sent successfully!");
      } else {
        final errorData = jsonDecode(response.body);
        _showSnackBar(errorData['message'] ?? "Error occurred");
      }
    } catch (e) {
      _showSnackBar("Connection error. Please try again.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _verifyOtp() async {
    if (_canResend) {
      _showSnackBar("OTP expired. Please resend.");
      return;
    }

    final otpValue = _otpController.text.trim();
    if (otpValue.length < 4) {
      _showSnackBar("Please enter a valid OTP");
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phone": _phoneController.text.trim(),
          "otp": otpValue,
          "mode": _authMode,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homescreen()),
        );
      } else {
        final errorData = jsonDecode(response.body);
        _showSnackBar(errorData['message'] ?? "Invalid OTP.");
      }
    } catch (e) {
      _showSnackBar("Verification failed.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.08),
              _buildLogo(size),
              SizedBox(height: size.height * 0.06),
              _buildHeader(size),
              SizedBox(height: size.height * 0.04),
              _buildPhoneField(),
              if (_isOtpSent) _buildOtpSection(size),
              SizedBox(height: size.height * 0.04),
              _buildMainButton(),
              if (_isOtpSent) _buildChangeNumberButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Size size) {
    return Image.asset(
      alignment: Alignment.topLeft,
      "assets/images/caremall.png",
      height: size.height * 0.10,
      errorBuilder:
          (context, _, __) =>
              Icon(Icons.shopping_bag_outlined, size: 80, color: _primaryColor),
    );
  }

  Widget _buildHeader(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isOtpSent ? "Verify OTP" : "Welcome Back",
          style: TextStyle(
            fontSize: size.width * 0.08,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _isOtpSent
              ? "Enter the code sent to ${_phoneController.text}"
              : "Enter your mobile number to continue",
          style: const TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      enabled: !_isOtpSent,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration(
        labelText: "Mobile Number",
        prefixIcon: const Icon(Icons.phone_android),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildOtpSection(Size size) {
    return Column(
      children: [
        const SizedBox(height: 20),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: "OTP Code",
            counterText: "",
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 4, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _canResend
                    ? "OTP Expired"
                    : "Resend in 00:${_timerValue.toString().padLeft(2, '0')}",
                style: TextStyle(
                  color: _canResend ? Colors.red : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (_canResend)
                InkWell(
                  onTap: _isLoading ? null : _sendOtp,
                  child: Text(
                    "Resend Now",
                    style: TextStyle(
                      color: _primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed:
            _isLoading
                ? null
                : () {
                  FocusScope.of(context).unfocus();
                  _isOtpSent ? _verifyOtp() : _sendOtp();
                },
        child:
            _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                  _isOtpSent ? "Verify & Login" : "Get OTP",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }

  Widget _buildChangeNumberButton() {
    return Center(
      child: TextButton(
        onPressed: _isLoading ? null : _resetState,
        child: const Text(
          "Change Number?",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
