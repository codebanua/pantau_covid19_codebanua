import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/models/corona_global.dart';
import 'package:coronamonitorapps/network/service_corona.dart';
import 'package:coronamonitorapps/notifiers/corona_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/range_change_notifier.dart';
import 'package:coronamonitorapps/ui/statictics/detail_province_page.dart';
import 'package:coronamonitorapps/widgets/custom_chip/custom_chip_range.dart';
import 'package:coronamonitorapps/widgets/header_app.dart';
import 'package:coronamonitorapps/widgets/statistcs/province_statistics_card.dart';
import 'package:coronamonitorapps/widgets/statistcs/statistics_common_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coronaProv = Provider.of<CoronaChangeNotifier>(context);
    final filterProv = Provider.of<RangeFilterChangeNotifier>(context);

    Global result = Global();
    String source;

    if (!coronaProv.isFetching) {
      if (filterProv.selectedRangeChoice == 'Global') {
        result = Global(
          kasus: coronaProv.coronaGlobal?.kasus,
          meninggal: coronaProv.coronaGlobal?.meninggal,
          sembuh: coronaProv.coronaGlobal?.sembuh,
        );
        source = coronaProv.coronaGlobal?.source;
      } else if (filterProv.selectedRangeChoice == 'Indonesia') {
        result = Global(
            kasus: coronaProv.coronaIndo?.kasus,
            meninggal: coronaProv.coronaIndo?.meninggal,
            sembuh: coronaProv.coronaIndo?.sembuh);
        source = coronaProv.coronaIndo?.source;
      } else {
        result = Global(
            kasus: coronaProv.coronaDetailProvince?.kasus,
            meninggal: coronaProv.coronaDetailProvince?.meninggal,
            sembuh: coronaProv.coronaDetailProvince?.sembuh);
        source = coronaProv.coronaDetailProvince?.source;
      }
    }
    return RefreshIndicator(
      color: ColorPalette.redStart,
      backgroundColor: ColorPalette.blackEnd,
      onRefresh: () {
        if (filterProv.selectedRangeChoice == 'Global') {
          return coronaProv.getDataGlobal();
        } else if (filterProv.selectedRangeChoice == 'Indonesia') {
          return coronaProv.getDataIndo();
        } else {
          return coronaProv.getDataDetailProvince(ServiceCorona.idKalsel);
        }
      },
      child: NotificationListener(
        // ignore: missing_return
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
        },
        child: ListView(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          children: <Widget>[
            HeaderApp('Statistik'),
            SizedBox(
              height: Sizes.height(context) * 0.015,
            ),
            CustomChipRange(),
            SizedBox(
              height: Sizes.height(context) * 0.015,
            ),
            filterProv.selectedRangeChoice == 'Kalsel'
                ? ProvinceStatisticCard()
                : SizedBox(),
            StatisticsCommonCard(
              infected: result?.kasus,
              recover: result?.sembuh,
              death: result?.meninggal,
            ),
            SizedBox(
              height: Sizes.height(context) * 0.015,
            ),
            filterProv.selectedRangeChoice == 'Kalsel'
                ? FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => DetailProvincePage()));
                    },
                    shape: StadiumBorder(),
                    color: ColorPalette.orangeStart.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lihat detail',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(color: ColorPalette.white),
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: Sizes.height(context) * 0.015,
              child: Divider(
                thickness: 0.3,
              ),
            ),
            GestureDetector(
              onTap: () {
                launch(source);
              },
              child: Text(
                'Source Data : $source',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    color: ColorPalette.grey,
                    fontSize: Sizes.dp10(context)),
              ),
            ),
            SizedBox(
              height: Sizes.height(context) * 0.015,
              child: Divider(
                thickness: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
