// import 'package:flutter/material.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   bool _isObscure = true;

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: height * .15),

//                 Row(
//                   children: [
//                     Image.asset(
//                       "assets/images/caremall.png",
//                       height: height * 0.1,
//                       width: width * 0.3,
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: height * 0.05),

//                 Text(
//                   "Create an Account",
//                   style: TextStyle(
//                     fontSize: width * 0.07,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 SizedBox(height: height * 0.01),

//                 Text(
//                   "Welcome! please enter your details.",
//                   style: TextStyle(color: Colors.grey, fontSize: width * 0.04),
//                 ),

//                 SizedBox(height: height * 0.04),

//                 Text("Full Name", style: TextStyle(fontSize: width * 0.045)),
//                 SizedBox(height: height * 0.01),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Enter Name here",
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontSize: width * 0.04,
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.person_outline,
//                       color: Colors.grey,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: height * 0.02),

//                 Text("Phone Number", style: TextStyle(fontSize: width * 0.045)),
//                 SizedBox(height: height * 0.01),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Enter Email or Phone Number here",
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontSize: width * 0.04,
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.email_outlined,
//                       color: Colors.grey,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: height * 0.02),

//                 Text("Password", style: TextStyle(fontSize: width * 0.045)),
//                 SizedBox(height: height * 0.01),
//                 TextField(
//                   obscureText: _isObscure,
//                   decoration: InputDecoration(
//                     hintText: "Enter Password here",
//                     hintStyle: TextStyle(
//                       color: Colors.grey,
//                       fontSize: width * 0.04,
//                     ),
//                     prefixIcon: const Icon(
//                       Icons.lock_outline,
//                       color: Colors.grey,
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isObscure ? Icons.visibility_off : Icons.visibility,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isObscure = !_isObscure;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: height * 0.03),

//                 SizedBox(
//                   width: double.infinity,
//                   height: height * 0.065,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       "SignUp",
//                       style: TextStyle(
//                         fontSize: width * 0.045,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: height * 0.03),

//                 Row(
//                   children: [
//                     Expanded(child: Divider(color: Colors.grey[400])),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Text(
//                         "Or",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: width * 0.04,
//                         ),
//                       ),
//                     ),
//                     Expanded(child: Divider(color: Colors.grey[400])),
//                   ],
//                 ),

//                 SizedBox(height: height * 0.03),

//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.g_mobiledata,
//                           color: Colors.red,
//                           size: 30,
//                         ),
//                         label: const Text(
//                           "Google",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: width * 0.03),
//                     Expanded(
//                       child: OutlinedButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.facebook,
//                           color: Colors.blue,
//                           size: 25,
//                         ),
//                         label: const Text(
//                           "Facebook",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: height * 0.05),

//                 Center(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text("Already have an account? "),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Login",
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: height * 0.03),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
