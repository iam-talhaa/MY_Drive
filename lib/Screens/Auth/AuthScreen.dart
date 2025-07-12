import 'package:flutter/material.dart';
import 'package:mydrive/Screens/Auth/LoginScreenWidget.dart';
import 'package:mydrive/Screens/Auth/signUpScreen.dart';
import 'package:mydrive/res/colors.dart';
import 'package:mydrive/widgets/custom_Button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController S_emailController = TextEditingController();
  TextEditingController S_passwordController = TextEditingController();
  bool isLoginScreen = true;
  @override
  Widget build(BuildContext context) {
    final Screen_Height = MediaQuery.of(context).size.height * 1;
    final Screen_Width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 20.0,
            ),
            child: Container(
              width: double.infinity,
              height: Screen_Height / 1.07,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [lightGreen.withOpacity(0.9), Colors.greenAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    isLoginScreen
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(16),
                                // border: Border.all(color: Colors.green, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/tire.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your Email',
                                  icon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: 16,
                                left: 16,
                                top: 8,
                                bottom: 0,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your Password',
                                  icon: Icon(Icons.email),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Dont have an account?'),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLoginScreen = false;
                                      });
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: accentBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Custom_button(
                              name: "Login",
                              B_color: lightGreen.withOpacity(0.9),
                              ontap: () {},
                              b_Width: 200.0,
                              b_height: 45.0,
                              textcolor: whiteBackground,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Handle Google Sign In
                                  },
                                  child: Image(
                                    height: 40,
                                    image: AssetImage('assets/Google.png'),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Image(
                                  height: 40,
                                  image: AssetImage('assets/Facebook.png'),
                                ),
                                SizedBox(width: 10),

                                Image(
                                  height: 40,
                                  image: AssetImage('assets/linkedin.png'),
                                ),
                              ],
                            ),
                          ],
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(16),
                                // border: Border.all(color: Colors.green, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/tire.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: S_emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your Name',
                                  icon: Icon(Icons.person),
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: S_emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your Email',
                                  icon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: 16,
                                left: 16,
                                top: 8,
                                bottom: 0,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                obscureText: true,
                                controller: S_passwordController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your Password',
                                  icon: Icon(Icons.email),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account?'),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLoginScreen = true;
                                      });
                                    },
                                    child: Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: accentBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Custom_button(
                              name: "Sign Up",
                              B_color: lightGreen.withOpacity(0.9),
                              ontap: () {},
                              b_Width: 200.0,
                              b_height: 45.0,
                              textcolor: whiteBackground,
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
