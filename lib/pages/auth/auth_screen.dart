import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jgarden/services/auth_service.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/custom_button.dart';
import 'package:jgarden/widgets/custom_textfield.dart';
import 'package:jgarden/widgets/xl_text.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AuthScreen(),
    );
  }

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Column(
              children: [
                SizedBox(
                  height: Dimensions.height10,
                ),
                XlText(text: 'Welcome!'),
                SizedBox(
                  height: Dimensions.height30,
                ),
                ListTile(
                  title: const Text(
                    'Create an account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: AppColors.mainColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Form(
                      key: _signUpFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            CustomTextFeild(
                              controller: _nameController,
                              hintText: 'Name',
                              icon: Icon(
                                CupertinoIcons.person,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextFeild(
                              controller: _emailController,
                              hintText: 'Email',
                              icon: Icon(
                                CupertinoIcons.at,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextFeild(
                              controller: _passwordController,
                              hintText: 'Password',
                              icon: Icon(
                                CupertinoIcons.lock,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomButton(
                                text: 'Register',
                                onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                  setState(() {
                                    _auth = Auth.signin;
                                  });
                                })
                          ],
                        ),
                      )),
                ListTile(
                  title: const Text(
                    'Login to your account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: AppColors.mainColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Form(
                      key: _signInFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            CustomTextFeild(
                              controller: _emailController,
                              hintText: 'Email',
                              icon: Icon(
                                CupertinoIcons.at,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomTextFeild(
                              controller: _passwordController,
                              hintText: 'Password',
                              icon: Icon(
                                CupertinoIcons.lock,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            CustomButton(
                                text: 'Login',
                                onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                })
                          ],
                        ),
                      )),
              ],
            ),
          //   ElevatedButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.transparent,
          //     foregroundColor: Colors.black,
          //     elevation: 0,
          //     shape: const CircleBorder(),
          //   ),
          //   child: const Icon(CupertinoIcons.chevron_back),
          // ),
            ]
          ),
        ),
      ),
    );
  }
}
