import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/image_asset.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/notifiers/notification_change_notifier.dart';
import 'package:coronamonitorapps/ui/about/about_page.dart';
import 'package:coronamonitorapps/ui/notification/notification_page.dart';
import 'package:coronamonitorapps/ui/volunteer/volunteer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Map notifPref;
  NotificationChangeNotifier notificationProv;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifProv = Provider.of<NotificationChangeNotifier>(context);
    if (this.notificationProv != notifProv) {
      this.notificationProv = notifProv;
      Future.microtask(() => notifProv.getNotifPref().then((result) {
            notifPref = notifProv.notifPref;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: ColorPalette.grey.withOpacity(0.2),
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                icAppLogo,
                scale: 4.0,
              ),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  leading: Stack(
                    children: <Widget>[
                      Icon(Icons.notifications),
                      notifPref != null
                          ? notifPref['notif_server'] > notifPref['opened']
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundColor: ColorPalette.goldStart,
                                    radius: 6.0,
                                  ))
                              : SizedBox()
                          : SizedBox()
                    ],
                  ),
                  onTap: () {
                    String value =
                        '{"notif_server":${notifPref['notif_server']},"opened":${notifPref['notif_server']}}';
                    notificationProv.setNotifPref(value);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => NotificationPage()));
                  },
                  title: Text(
                    'Notifikasi',
                    style: TextStyle(
                        color: ColorPalette.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dp18(context)),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => VolunteerPage()));
                  },
                  title: Text(
                    'Daftar Volunteer',
                    style: TextStyle(
                        color: ColorPalette.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dp18(context)),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.all_inclusive),
                  onTap: () {
                    Navigator.pop(context);
                    launch('https://gist.github.com/codebanua/31f5cf8d6aebb08c0ed95f645722ab34');
                  },
                  title: Text(
                    'Berkontribusi',
                    style: TextStyle(
                        color: ColorPalette.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dp18(context)),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.dashboard),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => AboutPage()));
                  },
                  title: Text(
                    'Tentang Proyek Ini',
                    style: TextStyle(
                        color: ColorPalette.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dp18(context)),
                  ),
                ),
              ],
            ),
//            Spacer(),
//            Padding(
//              padding: const EdgeInsets.all(16.0),
//              child: Align(
//                alignment: Alignment.bottomRight,
//                child: Image.asset(
//                  'assets/images/codebanua.png',
//                  scale: 6.5,
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
