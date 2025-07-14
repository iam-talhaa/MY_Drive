import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mydrive/Screens/driverAndRider/driverAndRider.dart';
import 'package:mydrive/res/colors.dart';
import 'package:mydrive/utils/utils.dart';
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
  TextEditingController S_nameController = TextEditingController();

  bool isLoginScreen = true;
  FirebaseAuth auth = FirebaseAuth.instance;

  // Future<User?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //     if (googleUser == null) return null;

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     return userCredential.user;
  //   } catch (e) {
  //     print("Google Sign-In error: $e");
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final S_height = MediaQuery.of(context).size.height * 1;
    final S_width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              //  margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [lightGreen.withOpacity(0.9), Colors.greenAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                // borderRadius: BorderRadius.circular(32),
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
                child: isLoginScreen ? buildLoginUI() : buildSignupUI(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          buildLogo(),
          Text(
            'Login',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 1.5,
            endIndent: 100,
            indent: 100,
          ),
          buildTextField(emailController, 'Enter your Email', Icons.person),
          buildTextField(
            passwordController,
            'Enter your Password',
            Icons.lock,
            isPassword: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don’t have an account?'),
              TextButton(
                onPressed: () => setState(() => isLoginScreen = false),
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
          Custom_button(
            name: "Login",
            B_color: lightGreen.withOpacity(0.9),
            ontap: () {
              auth
                  .signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  )
                  .then((value) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => DriverAndRider()),
                    );
                    UTils().Toastmsg(
                      "SignUp Successfully",
                      Colors.lightBlueAccent,
                    );
                  })
                  .catchError((error) {
                    UTils().Toastmsg("Error: $error", Colors.red);
                  });
            },
            b_Width: 200.0,
            b_height: 45.0,
            textcolor: whiteBackground,
          ),
          SizedBox(height: 20),
          buildSocialButtons(),
        ],
      ),
    );
  }

  Widget buildSignupUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.18),

          buildLogo(),
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 1.5,
            endIndent: 100,
            indent: 100,
          ),

          buildTextField(S_nameController, 'Enter your Name', Icons.person),
          buildTextField(S_emailController, 'Enter your Email', Icons.email),
          buildTextField(
            S_passwordController,
            'Enter your Password',
            Icons.lock,
            isPassword: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?'),
              TextButton(
                onPressed: () => setState(() => isLoginScreen = true),
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
          Custom_button(
            name: "Sign Up",
            B_color: lightGreen.withOpacity(0.9),
            ontap: () {
              auth
                  .createUserWithEmailAndPassword(
                    email: S_emailController.text.trim(),
                    password: S_passwordController.text.trim(),
                  )
                  .then((value) {
                    UTils().Toastmsg("User Created Successfully", Colors.green);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => AuthScreen()),
                    );
                    setState(() {
                      isLoginScreen = true;
                    });
                  })
                  .catchError((error) {
                    UTils().Toastmsg("Error: $error", Colors.red);
                  });
            },
            b_Width: 200.0,
            b_height: 45.0,
            textcolor: whiteBackground,
          ),
        ],
      ),
    );
  }

  Widget buildLogo() {
    return Container(
      height: 150,
      width: 150,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75),
        child: Image.asset('assets/tire.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          icon: Icon(icon),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {},
          child: Image.asset('assets/Google.png', height: 40),
        ),
        SizedBox(width: 10),
        Image.asset('assets/Facebook.png', height: 40),
        SizedBox(width: 10),
        Image.asset('assets/linkedin.png', height: 40),
      ],
    );
  }

  // Future<User?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //     if (googleUser == null) return null; // User canceled

  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     return userCredential.user;
  //   } catch (e) {
  //     print('Google Sign-In Error: $e');
  //     return null;
  //   }
  // }
}
