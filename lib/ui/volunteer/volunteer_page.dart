import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/image_asset.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.poppins(
        color: ColorPalette.grey, fontSize: Sizes.dp18(context));
    TextStyle textStyleBold = GoogleFonts.poppins(
        color: ColorPalette.grey,
        fontSize: Sizes.dp18(context),
        fontWeight: FontWeight.bold);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              icAppLogo,
              scale: 5.0,
              width: Sizes.width(context) / 2,
              height: Sizes.height(context) / 4,
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(text: 'Tim Relawan Pengambang:', style: textStyleBold),
                  TextSpan(text: '\n\nAhmad Suryani ', style: textStyle),
                  TextSpan(text: '(Backend)', style: textStyleBold),
                  TextSpan(text: '\nM. Yudha ', style: textStyle),
                  TextSpan(text: '(WEB/PWA)', style: textStyleBold),
                  TextSpan(text: '\nDicky ', style: textStyle),
                  TextSpan(text: '(WEB)', style: textStyleBold),
                  TextSpan(text: '\nM. Sulthan Al Ihsan ', style: textStyle),
                  TextSpan(text: '(Mobile)', style: textStyleBold),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
