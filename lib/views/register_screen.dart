import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaBisnisController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirmasiPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        centerTitle: true,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                        "Silahkan isi nama bisnis anda terlebih dahulu",
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
                    label: "Nama Bisnis(toko, cafe, dll)",
                    hintText: "cth: Razol Berkah Makmur",
                    controller: _namaBisnisController,
                  ),
                  _buildTextFormField(
                    label: "Username",
                    hintText: "cht: razolmakmur",
                    controller: _usernameController,
                  ),
                  _buildTextFormField(
                    label: "Password",
                    hintText: "Kata sandi 8 karakter",
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  _buildTextFormField(
                    label: "Konfirmasi Password",
                    hintText: "Konfirmasi kata sandi",
                    obscureText: true,
                    controller: _konfirmasiPasswordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sudah pernah menggunakan aplikasi? ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2563EB)),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Klik disini",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2563EB)),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 49,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: FilledButton(
                    onPressed: () {},
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaBisnisController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _konfirmasiPasswordController.dispose();
    super.dispose();
  }

  Widget _buildTextFormField(
      {required String label,
      required String hintText,
      bool obscureText = false,
      required TextEditingController controller}) {
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
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: Color(0xFFCBD5E1),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: Color(0xFF2563EB),
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