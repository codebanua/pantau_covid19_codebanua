import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/ui/news/list_news.dart';
import 'package:coronamonitorapps/ui/news/paging_news.dart';
import 'package:coronamonitorapps/widgets/custom_chip/custom_chip_news.dart';
import 'package:coronamonitorapps/widgets/header_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left:16.0,right: 16.0,bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderApp('Berita Covid-19'),
            SizedBox(
              height: Sizes.height(context) * 0.015,
            ),
            CustomChipNews(),
            SizedBox(
              height: Sizes.height(context) * 0.015,
            ),
            ListNews(),
            SizedBox(
              height: Sizes.height(context) * 0.015,
            ),
            PagingNews()
          ],
        ),
      ),
    );
  }
}

