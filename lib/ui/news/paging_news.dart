import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/notifiers/news_filter_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/news_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PagingNews extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsChangeNotifier>(context);
    final filterNewsProv = Provider.of<NewsFilterChangeNotifier>(context);

    void getDataNews(String state){
      if (state == 'Hoak') {
        newsProvider.getHoakNews();
      } else if (state == 'Kemenkes') {
        newsProvider.getKemenkesNews();
      } else if (state == 'Detik') {
        newsProvider.getDetikNews();
      } else if (state == 'Liputan6') {
        newsProvider.getLiputan6News();
      } else if (state == 'Kompas') {
        newsProvider.getKompasNews();
      }else if(state == 'Tribun Banjarmasin'){
        newsProvider.getTribunBjmNews();
      }else if(state == 'Kanal Kalimantan'){
        newsProvider.getKanalKlmNews();
      }
    }

    return Container(
      height: Sizes.dp36(context),
      child: Card(
        color: ColorPalette.blueStart.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.keyboard_arrow_left,
                  color: ColorPalette.white, size: Sizes.dp24(context)),
              onPressed: () {
                if (newsProvider.newsPage != 1) {
                  newsProvider.decNewsPage();
                  getDataNews(filterNewsProv.selectedChoice);
                }
              },
            ),
            Text(
              newsProvider.newsPage.toString(),
              style: GoogleFonts.poppins(color: ColorPalette.white),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: ColorPalette.white,
              ),
              onPressed: () {
                newsProvider.incNewsPage();
                getDataNews(filterNewsProv.selectedChoice);
              },
            )
          ],
        ),
      ),
    );
  }
}
