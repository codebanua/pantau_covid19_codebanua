import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/image_asset.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/const/app_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.poppins(
        color: ColorPalette.grey, fontSize: Sizes.dp14(context));
    TextStyle textStyleSmall = GoogleFonts.poppins(
        color: ColorPalette.grey, fontSize: Sizes.dp12(context),fontStyle: FontStyle.italic);
    TextStyle textStyleBold = GoogleFonts.poppins(
        color: ColorPalette.grey,
        fontSize: Sizes.dp16(context),
        fontWeight: FontWeight.bold);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NotificationListener(
            // ignore: missing_return
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              child: Container(
                height: Sizes.height(context),
                width: Sizes.width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: Image.asset(icCodebanua, scale: 3.0)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        '${AppConst.appName} Version ${AppConst.appVersion}',
                        style: textStyleBold,
                      ),
                    ),
                    Text(
                      '\nAplikasi "${AppConst.appName}" adalah salah satu bagian dari proyek sukarelawan/volunteering yang digagas Komunitas Codebanua dengan tujuan agar masyarakat bisa mendapatkan informasi terkini terkait Covid-19 dengan mudah, data yang dimuat pada aplikasi ini dapat dipertanggung jawabkan karena diambil dari sumber yang terpercaya, proyek ini juga bersifat terbuka (open source) sehingga semua orang dapat mengakses codenya dan dapat berkontribusi untuk pengembangan selanjutnya.\n.\nTerimakasih telah menggunakan aplikasi ini.\nSemoga badai ini cepat berlalu🤲😇\n#codebanua #codeuntukbanua\n.',
                      textAlign: TextAlign.justify,
                      style: textStyle,
                    ),
                    RichText(
                      text: TextSpan(style: textStyle, children: [
                        TextSpan(text: 'Kunjungi juga versi webnya ya, '),
                        TextSpan(
                            text: 'DISINI',
                            style: textStyleBold,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://covid19.codebanua.tech/indo');
                              })
                      ]),
                    ),
                    Divider(),
                    Text(
                      'Follow us:',
                      style: textStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Image.network(
                              'https://cdn2.iconfinder.com/data/icons/social-icons-33/128/Instagram-512.png',
                              scale: 12.0),
                          onTap: () => launch('https://www.instagram.com/codebanua'),
                        ),
                        GestureDetector(
                          child: Image.network(
                            'https://cdn3.iconfinder.com/data/icons/popular-services-brands-vol-2/512/telegram-512.png',
                            scale: 12.0,
                          ),
                          onTap: () => launch('https://www.t.me/codebanua'),
                        ),
                      ],
                    ),
                    Divider(),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'This Apps Made in Banua with',
                            style: textStyle,
                          ),
                          FlutterLogo(),
                          Text(
                            'And',
                            style: textStyle,
                          ),
                          Image.asset(icLove, scale: 7.0),
                        ],
                      ),
                    ),
                    Text(
                      'All Icon on this Apps by Freepik from flaticon.com',
                      style: textStyleSmall,
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
