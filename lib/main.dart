import 'dart:convert';

import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/image_asset.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/const/app_constant.dart';
import 'package:coronamonitorapps/helper/pref_helper.dart';
import 'package:coronamonitorapps/notifiers/corona_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/key_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/news_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/news_filter_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/notification_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/range_change_notifier.dart';
import 'package:coronamonitorapps/ui/map/map_page.dart';
import 'package:coronamonitorapps/ui/news/news_page.dart';
import 'package:coronamonitorapps/ui/statictics/statistics_page.dart';
import 'package:coronamonitorapps/widgets/drawer/custom_drawer.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
//  runApp(DevicePreview(
//    builder: (context) => MyApp()
//  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoronaChangeNotifier>(
            create: (context) => CoronaChangeNotifier()),
        ChangeNotifierProvider<NewsChangeNotifier>(
            create: (context) => NewsChangeNotifier()),
        ChangeNotifierProvider<RangeFilterChangeNotifier>(
            create: (context) => RangeFilterChangeNotifier()),
        ChangeNotifierProvider<NewsFilterChangeNotifier>(
            create: (context) => NewsFilterChangeNotifier()),
        ChangeNotifierProvider<PageInfoChangeNotifier>(
            create: (context) => PageInfoChangeNotifier()),
        ChangeNotifierProvider<NotificationChangeNotifier>(
            create: (context) => NotificationChangeNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConst.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _homePageScafKey = GlobalKey<ScaffoldState>();
  List<Widget> _layout = [StatisticsPage(), MapPage(), NewsPage()];
  NotificationChangeNotifier notificationProv;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifProv = Provider.of<NotificationChangeNotifier>(context);
    if (this.notificationProv != notifProv) {
      this.notificationProv = notifProv;
      Future.microtask(() => notificationProv.getDataNotif().then((result) {
            int notifServer = notificationProv.dataNotif.notification.length;

            int notifOpened = 0;
            String value =
                '{"notif_server":$notifServer,"opened":$notifOpened}';

            PrefHelper.getPref(AppConst.notifPref).then((result) {
              if (result is bool) {
                notifOpened = 0;
                notificationProv.setNotifPref(value);
              } else {
                notifOpened = jsonDecode(result)['opened'];
                if (notifServer > notifOpened) {
                  notificationProv.setNotifPref(value);
                }
              }
            });
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    var pageInfoProv = Provider.of<PageInfoChangeNotifier>(context);
    DateTime date = DateTime.now();

    return Scaffold(
      key: _homePageScafKey,
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                tanggal(date),
                style: GoogleFonts.poppins(
                    color: ColorPalette.grey, fontSize: Sizes.dp12(context)),
              ),
            )
          ],
          leading: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.sort,
                  color: ColorPalette.grey,
                  size: Sizes.dp28(context),
                ),
                onPressed: () {
                  _homePageScafKey.currentState.openDrawer();
                },
              ),
              notificationProv.notifPref != null
                  ? notificationProv.notifPref['notif_server'] >
                          notificationProv.notifPref['opened']
                      ? Positioned(
                          top: Sizes.dp20(context),
                          left: Sizes.dp16(context),
                          child: CircleAvatar(
                            backgroundColor: ColorPalette.goldStart,
                            radius: 4.0,
                          ))
                      : SizedBox()
                  : SizedBox()
            ],
            overflow: Overflow.visible,
          )),
      body: _layout[pageInfoProv.indexBottomNav],
      drawer: CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageInfoProv.indexBottomNav,
        onTap: (index) {
          pageInfoProv.indexBottomNav = index;
        },
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: ColorPalette.grey,
            fontSize: Sizes.dp12(context)),
        unselectedLabelStyle: GoogleFonts.poppins(
            color: ColorPalette.grey, fontSize: Sizes.dp10(context)),
        selectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Image.asset(
                icHome,
                width: Sizes.width(context) * 0.08,
              ),
            ),
            title: Text(
              "Statistik",
            ),
          ),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset(
                  icMap,
                  width: Sizes.width(context) * 0.08,
                ),
              ),
              title: Text(
                "Peta",
              )),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset(
                  icNews,
                  width: Sizes.width(context) * 0.08,
                ),
              ),
              title: Text(
                "Berita",
              ))
        ],
      ),
    );
  }
}
