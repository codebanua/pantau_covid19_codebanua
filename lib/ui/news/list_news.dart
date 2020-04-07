import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/models/response_news.dart';
import 'package:coronamonitorapps/notifiers/news_change_notifier.dart';
import 'package:coronamonitorapps/ui/detailnews/detail_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class ListNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsChangeNotifier>(context);

    return Expanded(
      child: newsProvider.isFetching
          ? Center(
              child: Loading(
                indicator: BallSpinFadeLoaderIndicator(),
                size: (Sizes.height(context) * 0.17) / 3,
                color: ColorPalette.grey,
              ),
            )
          : newsProvider.dataNews.results.length == 0
              ? Center(
                  child: Text(
                  'Maaf data tidak ada',
                  style: GoogleFonts.poppins(color: ColorPalette.grey),
                ))
              : NotificationListener(
                  // ignore: missing_return
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                  },
                  child: ListView.builder(
                      itemCount: newsProvider.dataNews.results.length,
                      itemBuilder: (context, index) {
                        ItemBerita result =
                            newsProvider.dataNews.results[index];
                        return Container(
                          height: Sizes.height(context) / 10,
                          child: Card(
                            elevation: 3.0,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (index) =>
                                            DetailNews(result.link)));
                              },
                              leading: Image.network(
                                result.gambar,
                                height: Sizes.dp36(context),
                                width: Sizes.dp36(context),
                                fit: BoxFit.fill,
                              ),
                              title: Text(
                                result.judul,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.grey),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
    );
  }
}
