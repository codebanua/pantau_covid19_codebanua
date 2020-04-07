import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/const/app_constant.dart';
import 'package:coronamonitorapps/notifiers/notification_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProv = Provider.of<NotificationChangeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorPalette.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Notifikasi',
                      style: GoogleFonts.poppins(
                          color: ColorPalette.grey,
                          fontSize: Sizes.dp36(context),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      AppConst.appName,
                      style: GoogleFonts.poppins(
                          color: ColorPalette.grey,
                          fontSize: Sizes.dp16(context)),
                    ),
                  ],
                ),
                Icon(
                  Icons.notifications,
                  size: Sizes.width(context) * 0.2,
                  color: ColorPalette.goldStart,
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: RefreshIndicator(
                color: ColorPalette.redStart,
                backgroundColor: ColorPalette.blackEnd,
                onRefresh: notificationProv.getDataNotif,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: notificationProv.dataNotif.notification.length,
                    itemBuilder: (context, index) {
                      var dataItem =
                          notificationProv.dataNotif.notification[index];
                      return ListTile(
                        selected: false,
                        dense: true,
                        contentPadding: EdgeInsets.only(
                            left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
                        leading: CircleAvatar(
                          backgroundColor: ColorPalette.grey,
                          child: Text(dataItem.id.toString(),
                              style: TextStyle(color: ColorPalette.white)),
                        ),
                        title: Text(
                          dataItem.message,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.grey),
                        ),
                        subtitle: Text(dataItem.date),
                        onTap: () {
                          if(dataItem.link.isNotEmpty){
                            launch(dataItem.link);
                          }
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
