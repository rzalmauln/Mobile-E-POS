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
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 38, bottom: 38, left: 30, right: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Icon(Icons.account_box),
        Text(
          "Razol Berkah Makmur",
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
      ]),
    );
  }

  _buildMenuItems(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // SvgPicture.asset(""),
                Text(
                  "Kasir",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        color: Color(0xff3B82F6),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // SvgPicture.asset(""),
                Text(
                  "Transaksi",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        color: Color(0xff64748B),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
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
                    textStyle: TextStyle(
                        color: Color(0xff64748B),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // SvgPicture.asset(""),
                Text(
                  "Stok & Inventori",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        color: Color(0xff64748B),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
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
                    textStyle: TextStyle(
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
