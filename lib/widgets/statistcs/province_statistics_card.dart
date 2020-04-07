import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/notifiers/corona_change_notifier.dart';
import 'package:coronamonitorapps/widgets/statistcs/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvinceStatisticCard extends StatelessWidget {
  final bool isFetching;
  final String odp, pdp;

  ProvinceStatisticCard({this.isFetching, this.odp, this.pdp});

  @override
  Widget build(BuildContext context) {
    final coronaProv = Provider.of<CoronaChangeNotifier>(context);

    return Column(
      children: <Widget>[
        StatisticsCustomCard(
            'ODP',
            coronaProv.coronaDetailProvince?.odp,
            [ColorPalette.blueStart, ColorPalette.blueEnd],
            'assets/images/headhunter.png'),
        SizedBox(
          height: Sizes.height(context) * 0.02,
        ),
        StatisticsCustomCard(
            'PDP',
            coronaProv.coronaDetailProvince?.pdp,
            [ColorPalette.goldStart, ColorPalette.goldEnd],
            'assets/images/look.png'),
        SizedBox(
          height: Sizes.height(context) * 0.02,
        ),
      ],
    );
  }
}
