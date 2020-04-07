import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/notifiers/corona_change_notifier.dart';
import 'package:coronamonitorapps/ui/statictics/detail_statistics_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/line_scale_party_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class StatisticsCustomCard extends StatelessWidget {
  String title, data, iconImage;
  List<Color> color;

  StatisticsCustomCard(this.title, this.data, this.color, this.iconImage);

  @override
  Widget build(BuildContext context) {
    final coronaProv = Provider.of<CoronaChangeNotifier>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    DetailStatisticsPage(title, iconImage, color)));
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: Sizes.height(context) * 0.17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: color,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: GoogleFonts.poppins(
                        color: ColorPalette.white,
                        fontSize: Sizes.dp16(context),
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: Sizes.height(context) * 0.018,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    coronaProv.isFetching
                        ? Loading(
                            indicator: LineScalePartyIndicator(),
                            size: (Sizes.height(context) * 0.17) / 3,
                            color: ColorPalette.white,
                          )
                        : Text(
                            data,
                            style: GoogleFonts.poppins(
                                color: ColorPalette.white,
                                fontSize: Sizes.dp28(context),
                                fontWeight: FontWeight.w400),
                          ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('Orang',
                        style: GoogleFonts.poppins(
                            color: ColorPalette.white,
                            fontSize: Sizes.dp20(context),
                            fontWeight: FontWeight.w400))
                  ],
                )
              ],
            ),
            Image.asset(iconImage,scale: 7.0)
          ],
        ),
      ),
    );

//    return Widget customCard(context, type, title, data, color, iconImage) {
//      return
//    }
  }
}
