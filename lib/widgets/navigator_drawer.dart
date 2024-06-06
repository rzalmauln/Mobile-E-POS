import 'package:e_pos/views/home/home_screen.dart';
import 'package:e_pos/views/stock/stock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 290,
      shape: Border.all(strokeAlign: Checkbox.width),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(context),
            const Divider(
              color: Color(0xffCBD5E1),
            ),
            _buildMenuItems(context)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      },
      child: Container(
        alignment: Alignment.center,
        padding:
            const EdgeInsets.only(top: 38, bottom: 38, left: 30, right: 30),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.account_box),
              Text(
                "E - POS",
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox()
            ]),
      ),
    );
  }

  _buildMenuItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // SvgPicture.asset(""),
                  Text(
                    "Kasir",
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          color: Color(0xff3B82F6),
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StockScreen(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // SvgPicture.asset(""),
                  Text(
                    "Transaksi",
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          color: Color(0xff64748B),
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // SvgPicture.asset(""),
                Text(
                  "Laporan",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                        color: Color(0xff64748B),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StockScreen(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // SvgPicture.asset(""),
                  Text(
                    "Stok & Inventori",
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          color: Color(0xff64748B),
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // SvgPicture.asset(""),
                Text(
                  "Sinkronisasi Data",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                        color: Color(0xff64748B),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
