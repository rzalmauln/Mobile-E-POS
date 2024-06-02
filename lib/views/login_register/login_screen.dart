import 'package:e_pos/cubits/login/login_cubit.dart';
import 'package:e_pos/cubits/login/login_state.dart';
import 'package:e_pos/views/pin/pin_screen.dart';
import 'package:e_pos/views/transaksi/detail_transaksi_screen.dart';
import 'package:e_pos/views/transaksi/transaksi_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('userLogin', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // toolbarHeight: 76,
        title: const Text(
          "Jaya Makmur POS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            height: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 110, //126
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is ErrorLoginState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Login Error'),
                    content: Text(state.errorMessage),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
              if (state is LoadedLoginState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Login Successful'),
                    content: const Text('Welcome to Jaya Makmur POS!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PinScreen(isCreatingPin: true),
                            ),
                          );
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingLoginState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              check();
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        const Center(
                          child: Text(
                            "Selamat Datang!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Silahkan login menggunakan kredensial anda",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        _buildTextFormField(
                          label: "Username",
                          hintText: "cth: razolmakmur",
                          controller: _usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        _buildTextFormField(
                          label: "Password",
                          hintText: "Kata sandi 8 karakter",
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Pertama kali menggunakan aplikasi? ",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2563EB)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ));
                                },
                                child: const Text(
                                  "Klik disini",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2563EB)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 49,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            check();
                            String username = _usernameController.text;
                            String password = _passwordController.text;
                            try {
                              context
                                  .read<LoginCubit>()
                                  .login(username, password);
                            } catch (e) {
                              Text(e.toString());
                            }
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll(Color(0xFF2563EB)),
                        ),
                        child: const Text(
                          "Selanjutnya",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      {required String label,
      required String hintText,
      bool obscureText = false,
      required TextEditingController controller,
      String? Function(String? value)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 12),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            height: 48,
            child: TextFormField(
              validator: validator,
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: Color(0xFFCBD5E1),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: Color(0xFF2563EB),
                      width: 1.5,
                    ),
                  )),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
