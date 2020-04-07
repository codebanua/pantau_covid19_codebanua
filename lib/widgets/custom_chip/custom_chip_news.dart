import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/notifiers/news_filter_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/news_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChipNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsFilterChangeNotifier>(context);
    final newsProvider = Provider.of<NewsChangeNotifier>(context);

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
                      color: provider.selectedChoice == item['name']
                          ? ColorPalette.brownStart
                          : ColorPalette.grey)),
              backgroundColor: ColorPalette.white,
              selectedColor: ColorPalette.brownStart.withOpacity(0.1),
              labelStyle: TextStyle(color: ColorPalette.grey),
              onSelected: (value) {
                provider.changeValue(item['name']);
                newsProvider.resetPage();
                if (item['name'] == 'Hoak') {
                  newsProvider.getHoakNews();
                } else if (item['name'] == 'Kemenkes') {
                  newsProvider.getKemenkesNews();
                } else if (item['name'] == 'Detik') {
                  newsProvider.getDetikNews();
                } else if (item['name'] == 'Liputan6') {
                  newsProvider.getLiputan6News();
                } else if (item['name'] == 'Kompas') {
                  newsProvider.getKompasNews();
                }else if(item['name'] == 'Tribun Banjarmasin'){
                  newsProvider.getTribunBjmNews();
                }else if(item['name'] == 'Kanal Kalimantan'){
                  newsProvider.getKanalKlmNews();
                }
              },
              pressElevation: 0.0,
              label: Text(item['name']),
              selected: provider.selectedChoice == item['name'],
            ),
          );
        }).toList(),
      ),
    );
  }
}
