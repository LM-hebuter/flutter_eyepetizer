import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/pages/author/author_details_page.dart';
import 'package:flutter_eyepetizer/pages/video/video_details_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryListItem extends StatelessWidget {
  final Item item;

  CategoryListItem({Key key, this.item}) : super(key: key);

  String formatDuration(duration) {
    var minute = duration ~/ 60;
    var second = duration % 60;
    var str;
    if (minute <= 9) {
      if (second <= 9) {
        str = "0$minute:0$second";
      } else {
        str = "0$minute:$second";
      }
    } else {
      if (second <= 9) {
        str = "$minute:0$second";
      } else {
        str = "$minute:$second";
      }
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Stack(
              alignment: FractionalOffset(0.95, 0.95),
              children: <Widget>[
                GestureDetector(
                  child: CachedNetworkImage(
                    height: 220,
                    fit: BoxFit.cover,
                    imageUrl: item.data.cover.feed,
                    errorWidget: (context, url, error) =>
                        Image.asset('images/img_load_fail'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoDetailsPage(
                          item: this.item,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Text(
                        formatDuration(item.data.duration),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthorDetailsPage(
                          item: item,
                        ),
                      ),
                    );
                  },
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: item.data.author.icon,
                      width: 40,
                      height: 40,
                      placeholder: (context, url) => CircularProgressIndicator(
                        strokeWidth: 2.5,
                        backgroundColor: Colors.deepPurple[600],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 15, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.data.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Padding(padding: EdgeInsets.only(top: 2, bottom: 2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              item.data.author.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                GestureDetector(
                  child: Image.asset('images/icon_share.png',
                      width: 25, height: 25),

                  /// TODO 从底部弹出分享框
                  onTap: () => Fluttertoast.showToast(
                    msg: '分享',
                    fontSize: 15,
                    textColor: Colors.black38,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
