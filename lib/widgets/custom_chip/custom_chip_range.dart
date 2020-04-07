import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/notifiers/corona_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/range_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChipRange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RangeFilterChangeNotifier>(context);
    final coronaProv = Provider.of<CoronaChangeNotifier>(context);

    return Container(
      height: Sizes.width(context) / 10,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: provider.listChoice.map((item) {
          return Padding(
            padding: EdgeInsets.only(right: Sizes.dp6(context)),
            child: ChoiceChip(
              avatar: Image.asset(item['image']),
              shape: StadiumBorder(
                  side: BorderSide(
                      width: 0.1,
                      color: provider.selectedRangeChoice == item['name']
                          ? ColorPalette.brownStart
                          : ColorPalette.grey)),
              backgroundColor: ColorPalette.white,
              selectedColor: ColorPalette.brownStart.withOpacity(0.1),
              labelStyle: TextStyle(color: ColorPalette.grey),
              onSelected: (value) {
                provider.changeValue(item['name']);
                if (item['name'] == 'Global') {
                  coronaProv.coronaGlobal ?? coronaProv.getDataGlobal();
                } else if (item['name'] == 'Indonesia') {
                  coronaProv.coronaIndo ??
                      coronaProv.getDataIndo().then((item) {
                        coronaProv.getDataMapIndo();
                      });
                  coronaProv.getDataMapIndo();
                } else {
                  coronaProv.coronaDetailProvince ??
                      coronaProv.getDataDetailProvince(22).then((item) {
                        coronaProv.getDataMapProvince();
                      });
                  coronaProv.getDataMapProvince();
                }
              },
              pressElevation: 0.0,
              label: Text(item['name']),
              selected: provider.selectedRangeChoice == item['name'],
            ),
          );
        }).toList(),
      ),
    );
  }
}
