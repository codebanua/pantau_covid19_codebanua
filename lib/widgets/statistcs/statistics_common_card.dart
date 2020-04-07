import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/widgets/statistcs/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsCommonCard extends StatelessWidget {
  final String infected, recover, death;

  StatisticsCommonCard({ this.infected, this.recover, this.death});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StatisticsCustomCard(
            'Positif',
            infected,
            [ColorPalette.redStart, ColorPalette.blackEnd],
            'assets/images/biohazard.png'),
        SizedBox(
          height: Sizes.height(context) * 0.02,
        ),
        StatisticsCustomCard(
            'Sembuh',
            recover,
            [ColorPalette.pinkStart, ColorPalette.pinkEnd],
            'assets/images/blood.png'),
        SizedBox(
          height: Sizes.height(context) * 0.02,
        ),
        StatisticsCustomCard(
            'Meninggal',
            death,
            [ColorPalette.brownStart, ColorPalette.brownEnd],
            'assets/images/tengkorak.png'),
      ],
    );
  }


}
