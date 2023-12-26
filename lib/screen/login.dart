import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/data/auth_data.dart';

import '../components/BellowTextFieldWidget.dart';
import '../components/ButtonWidget.dart';
import '../components/ImageWidget.dart';
import '../components/TextFieldWidget.dart';
import 'package:flutter_to_do_list/const/colors.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    super.initState();
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              ImageWidget(),
              SizedBox(height: 50),
              TextFieldWidget(
                controller: email,
                focusNode: _focusNode1,
                typeName: 'E-mail',
                icon: Icons.email,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Lütfen e-postanızı giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFieldWidget(
                controller: password,
                focusNode: _focusNode2,
                typeName: 'Şifre',
                obscureText: true,
                icon: Icons.password,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Lütfen Şifrenizi giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              BellowTextFieldWidget(
                widget: widget.show,
                textQuest: 'Hesabınız yok mu?',
                clickText: 'Hesap Oluştur',
              ),
              SizedBox(height: 20),
              ButtonWidget(
                email: email,
                password: password,
                text: 'Giriş',
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.green,
                        ));
                      }));
                  try {
                    await AuthenticationRemote()
                        .login(email.text, password.text);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed("mainPage");
                  } on FirebaseAuthException catch (e) {
                    Navigator.of(context).pop();
                    print(e);
                    if (e.code == 'user-not-found') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        title: 'Hata',
                        desc: 'Kullanıcı Bulunmadı!',
                        autoHide: const Duration(seconds: 3),
                      ).show();
                    } else if (e.code == 'wrong-password') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        desc: 'Şifre Hatalı!',
                        title: 'Hata',
                        autoHide: const Duration(seconds: 3),
                      ).show();
                    } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        desc: 'Hatalı giriş bilgileri!',
                        title: 'Hata',
                        autoHide: const Duration(seconds: 3),
                      ).show();
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        desc:
                            'Çok fazla deneme yaptınız,Lütfen daha sonra tekrar deneyiniz',
                        title: 'Hata',
                        autoHide: const Duration(seconds: 3),
                      ).show();
                    }
                  }
                  ;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
