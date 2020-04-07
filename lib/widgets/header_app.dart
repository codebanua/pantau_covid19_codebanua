import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/const/app_constant.dart';
import 'package:coronamonitorapps/notifiers/key_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/range_change_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HeaderApp extends StatelessWidget {
  final String title;

  HeaderApp(this.title);

  @override
  Widget build(BuildContext context) {
    final filterProv = Provider.of<RangeFilterChangeNotifier>(context);
    final pageInfoProv = Provider.of<PageInfoChangeNotifier>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$title ${pageInfoProv.indexBottomNav != 2 ? filterProv.selectedRangeChoice : ''}',
          style: GoogleFonts.poppins(
              color: ColorPalette.grey,
              fontSize: Sizes.headerTitle(context),
              fontWeight: FontWeight.w600),
        ),
        Text(
          AppConst.appName,
          style: GoogleFonts.poppins(
              color: ColorPalette.grey, fontSize: Sizes.dp16(context)),
        ),
      ],
    );
  }
}
