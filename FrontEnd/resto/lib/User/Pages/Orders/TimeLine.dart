import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeline extends StatelessWidget {
  bool isLast;
  bool isFirst;
  bool IsPast;
   String Track_data;
  MyTimeline(
      {required this.Track_data,

        required this.isFirst, required this.isLast, required this.IsPast});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
            color: IsPast ? Colors.green : Colors.red),
        indicatorStyle: IndicatorStyle(
            width: 40,
            color: IsPast ? Colors.green : Colors.red,
            iconStyle: IconStyle(iconData: Icons.done, color: Colors.white)),
        endChild: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
              color: IsPast ? Colors.green.shade100 : Colors.red.shade100,),
            height: 75,
              width: 300,
              child: Center(child:  Text(
                  "$Track_data",
                  style: GoogleFonts.aladin(
                    color: Colors.black,
                    fontSize: 30,
                  )
              ),)),
        ),

      ),
    );
  }
}