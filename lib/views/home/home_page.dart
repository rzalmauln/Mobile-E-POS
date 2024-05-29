import 'package:e_pos/views/widgets/custom_text_field.dart';
import 'package:e_pos/views/widgets/navigator_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigatorDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xffb2563eb),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: SvgPicture.asset(
        //     'assets/icons/textalign-left.svg',
        //   ),
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bisnis:",
                style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                )),
            Text(
              "Razol Berkah Makmur",
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/filter.svg',
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/notification.svg',
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextField(
                controller: _controller,
                hintText: 'Cari Produk',
                suffixIcon: SvgPicture.asset('assets/icons/search-normal.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
              ),
            ),
            // ListView.builder(
            // itemBuilder: (context, index) {},
            // )
          ],
        ),
      ),
    );
  }
}
