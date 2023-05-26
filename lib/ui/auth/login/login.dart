import 'package:admin_kangsayur/common/color_value.dart';
import 'package:admin_kangsayur/ui/sidebar/sidebar_navigation.dart';
import 'package:admin_kangsayur/ui/widget/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_kangsayur.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              Text(
                'Kang Sayur',
                style: textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: ColorValue.neutralColor
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: textfield(context, "Masukkan Email", _emailController,
                    TextInputType.emailAddress),
              ),
              const SizedBox(height: 10),
              textFieldPassword(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  checkLogin();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorValue.primaryColor,
                  minimumSize: const Size(310, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: textTheme.button!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
                child: Text(
                  "Masuk",
                  style: textTheme.button!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  Widget textFieldPassword() {
    return SizedBox(
      width: 300,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: ColorValue.hintColor,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Masukkan Password",
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(
                color: ColorValue.hintColor,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: ColorValue.hintColor,
                ),
              ),
            ),
            obscureText: _isObscure,
          ),
        ),
      ),
    );
  }

  void checkLogin() {
    if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email dan Password tidak boleh kosong"),
        ),
      );
    } else
    if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email tidak boleh kosong atau tidak valid"),
        ),
      );
    } else if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password tidak boleh kosong"),
        ),
      );
    } else if (_emailController.text == "admin@gmail.com" &&
        _passwordController.text == "password") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SidebarNavigation(),
        ),
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email atau Password salah"),
        ),
      );
    }
  }
}
