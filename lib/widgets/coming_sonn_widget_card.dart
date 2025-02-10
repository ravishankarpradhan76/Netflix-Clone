import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComingSonnWidgetCard extends StatelessWidget {
  final String imageUrl;
  final String overview;
  final String logoUrl;
  final String month;
  final String day;

  const ComingSonnWidgetCard(
      {super.key,
      required this.imageUrl,
      required this.overview,
      required this.logoUrl,
      required this.month,
      required this.day});

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return SizedBox(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    month,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    day,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        letterSpacing: 5),
                  ),
                ]),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      CachedNetworkImage(imageUrl: imageUrl),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Size.width * 0.2,
                            height: Size.width * 0.2,
                            child: CachedNetworkImage(
                              imageUrl: logoUrl,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Icon(Icons.notifications_none_rounded,
                                size: 25,
                                color: Colors.white,),
                              SizedBox(height: 5,),
                              Text('Remind Me',style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Icon(Icons.info_outline_rounded,
                                size: 25,
                                color: Colors.white,),
                              SizedBox(height: 5,),
                              Text('Info',style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Coming on $month $day',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.5),),
                              SizedBox(height: 10,),
                              Text(overview,textAlign: TextAlign.left,
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.grey,fontSize: 12.5
                              ),
                              overflow: TextOverflow.ellipsis,)
                            ],
                          )
                    ]))
              ],
            )));
  }
}
