import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/components/BellowTextFieldWidget.dart';
import 'package:flutter_to_do_list/components/ButtonWidget.dart';
import 'package:flutter_to_do_list/components/ImageWidget.dart';
import 'package:flutter_to_do_list/components/TextFieldWidget.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/auth_data.dart';

class SignUp_Screen extends StatefulWidget {
  final VoidCallback show;
  SignUp_Screen(this.show, {super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final PasswordConfirm = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
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
                    return 'Lütfen E-postanizi giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFieldWidget(
                controller: password,
                focusNode: _focusNode2,
                obscureText: true,
                typeName: 'Şifre',
                icon: Icons.password,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Lütfen Şifrenizi giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFieldWidget(
                controller: PasswordConfirm,
                focusNode: _focusNode3,
                obscureText: true,
                typeName: 'Şifre Tekrarı',
                icon: Icons.password,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Lütfen Şifrenizi Tekrarlayiniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              BellowTextFieldWidget(
                  widget: widget.show,
                  textQuest: 'Hesabınız mı var?',
                  clickText: 'Giriş Yap'),
              SizedBox(height: 20),
              ButtonWidget(
                  email: email,
                  password: password,
                  text: 'Hesap Oluştur',
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
                      await AuthenticationRemote().register(
                          email.text, password.text, PasswordConfirm.text);
                      Navigator.of(context).pop();
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.scale,
                        desc: 'Hesabi olusturuldu! Lütfen giriş yapınız.',
                        title: 'Tebrikler',
                        autoHide: const Duration(seconds: 3),
                      ).show();
                      Navigator.of(context).pop();
                    } on FirebaseAuthException catch (e) {
                      Navigator.of(context).pop();
                      if (e.code == 'weak-password') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.scale,
                          desc: 'Lütfen daha karmaşık bir şifre giriniz',
                          title: 'Hata',
                          autoHide: const Duration(seconds: 3),
                        ).show();
                      } else if (e.code == 'email-already-in-use') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.scale,
                          desc: 'Bu E-postaya ait hesap zaten mevcut.',
                          title: 'Hata',
                          autoHide: const Duration(seconds: 3),
                        ).show();
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
