import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikking_admin/screens/auth/login.dart';
import 'package:hikking_admin/utils/app_styles.dart';
import 'package:hikking_admin/utils/buttons.dart';
import 'package:hikking_admin/utils/colors.dart';
import 'package:hikking_admin/widgets/input_text_form.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                _FormSection(),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FormSection extends StatefulWidget {
  const _FormSection({Key? key}) : super(key: key);

  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  // Toggles the password show status
  TextEditingController emailControler = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral,
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            width: 120,
            height: 150.5,
          ),
          const SizedBox(height: 30),
          const Text(
            "Log in",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.63),
          ),
          const SizedBox(height: 41),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email Address",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            controller: emailControler,
            labelText: "example@gmail.com",
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: false,
            enabled: true,
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 40),
          WonsButton(
            height: 50,
            width: 348,
            verticalPadding: 0,
            color: AppColors.primary,
            child: const Text(
              "Reset Password",
              style: TextStyle(
                  color: AppColors.neutral,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            onPressed: () async {
              await FirebaseAuth.instance
                  .sendPasswordResetEmail(email: emailControler.text)
                  .then((value) => {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Reset Password Link send to email"))),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => LoginPage()))
                      });
            },
          ),
          const SizedBox(height: 30),
          TextButton(
            child: Text("Login Page"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => LoginPage()));
            },
          )
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/logo.png",
            height: 600,
          ))
        ],
      ),
    );
  }
}
