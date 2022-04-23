import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qit_test/features/home/view.dart';
import 'package:qit_test/features/login/bloc/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) {
          return current is LoginLoaded || current is LoginError;
        },
        listener: (context, state) {
          if(state is  LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }else if (state is  LoginLoaded){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Please login to your account",
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<LoginCubit, LoginState>(
                    bloc: BlocProvider.of<LoginCubit>(context),
                    buildWhen: (previous, current) {
                      return current is LoginEmailCorrect ||
                          current is LoginEmailIncorrect ||
                          current is LoginInitial;
                    },
                    builder: (context, state) {
                      return TextField(
                        decoration: InputDecoration(
                          errorText: state is LoginEmailIncorrect
                              ? "E-mail Incorrect"
                              : null,
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36)),
                              borderSide: BorderSide(color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36)),
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: const SizedBox(
                              width: 36,
                              child: Center(
                                  child: FaIcon(FontAwesomeIcons.envelope,
                                      color: Colors.grey))),
                          hintText: 'Email Address',
                        ),
                        onChanged: (value) {
                          BlocProvider.of<LoginCubit>(context).emailToSend =
                              value;
                          BlocProvider.of<LoginCubit>(context).emailValidator();
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          borderSide: BorderSide(color: Colors.grey)),
                      suffixIcon: SizedBox(
                          width: 36,
                          child: Center(
                              child: FaIcon(FontAwesomeIcons.lock,
                                  color: Colors.grey))),
                      hintText: 'Password',
                    ),
                    onChanged: (value) {
                      BlocProvider.of<LoginCubit>(context).password = value;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    bloc: BlocProvider.of<LoginCubit>(context),
                    buildWhen: (previous, current) {
                      return current is LoginLoading ||
                          current is LoginLoaded ||
                          current is LoginError ||
                          current is LoginInitial;
                    },
                    builder: (context, state) {
                      return state is LoginLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => HomePage()));
                                BlocProvider.of<LoginCubit>(context).login();
                              },
                              child: Text("Submit"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.maxFinite, 48),
                                primary: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36)),
                                ),
                              ),
                            );
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Forgot Password?"),
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Or login with",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () {},
                        child: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.black, width: 1)),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.black, width: 1)),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: FaIcon(
                          FontAwesomeIcons.twitter,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.black, width: 1)),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Dont't have an account? ",
                      children: [
                        TextSpan(
                          text: "Create One",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "by Signing up, you are agreeing with our ",
                      style: Theme.of(context).textTheme.caption,
                      children: [
                        TextSpan(
                          text: "Terms and Conditions",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
