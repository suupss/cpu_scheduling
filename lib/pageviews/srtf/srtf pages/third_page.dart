import 'package:scheduling_new/pageviews/fcfs/fcfs_page_view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../model/color_model.dart';
import '../../../model/srtf_model.dart';
import '../../../widget/help_in_responsive_widgets.dart';

class SRTFPageViewThirdPage extends StatefulWidget {
  int pageNumber = 0;
  SRTFPageViewThirdPage(this.pageNumber);

  @override
  State<SRTFPageViewThirdPage> createState() => _SRTFPageViewThirdPageState();
}

class _SRTFPageViewThirdPageState extends State<SRTFPageViewThirdPage> {
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      VxToast.show(context,
          msg: "${widget.pageNumber}/4", textSize: forHeight(16));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !isNextPageVisible
          ? Text(
              "No Calculation",
              style: TextStyle(color: Vx.white, fontSize: forHeight(28)),
            ).centered().pOnly(bottom: forHeight(21))
          : ListView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              children: [
                sizedBoxForHeight(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Average Waiting Time",
                      style:
                          TextStyle(color: Vx.white, fontSize: forHeight(20)),
                    ),
                    Text(
                      "${averageWaitingTime.toStringAsFixed(2)} Sec",
                      style:
                          TextStyle(color: Vx.white, fontSize: forHeight(30)),
                    ),
                    sizedBoxForHeight(10),
                    Text(
                      "Total CPU Idle Time",
                      style:
                          TextStyle(color: Vx.white, fontSize: forHeight(20)),
                    ),
                    Text(
                      "$totalCpuIdleTime Sec",
                      style:
                          TextStyle(color: Vx.white, fontSize: forHeight(30)),
                    ),
                  ],
                ).pOnly(left: forWidth(10)),
                Container(
                  width: forWidth(310),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => sizedBoxForHeight(13),
                    itemCount: SRTFModel.tableListValue.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      SRTFModel item = SRTFModel.tableListValue[index];
                      int wt = waitingTime["P-${item.id}"].toInt() < 0
                          ? 0
                          : waitingTime["P-${item.id}"].toInt();
                      return Container(
                        height: forHeight(280),
                        width: forHeight(175),
                        decoration: BoxDecoration(
                          color: ColorModel().yellow,
                          borderRadius: BorderRadius.circular(
                            forHeight(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            rowForValueDisplay(
                                "Process-ID", item.id.toString()),
                            rowForValueDisplay(
                                "Arrival Time", item.oldAtValue.toString()),
                            rowForValueDisplay("CPU Burst Time",
                                item.oldcpuBurstValue.toString()),
                            rowForValueDisplay(
                                "Turn Around Time",
                                turnAroundTime["P-${item.id}"]
                                    .toInt()
                                    .toString()),
                            rowForValueDisplay("Waiting Time", wt.toString()),
                            rowForValueDisplay(
                                "Completion Time",
                                completionTimeMap["P-${item.id}"]
                                    .toInt()
                                    .toString()),
                          ],
                        ).pSymmetric(h: forWidth(12), v: forHeight(14)),
                      ).pSymmetric(h: forWidth(10)).pOnly(
                          top: index == 0 ? forHeight(15) : 0,
                          bottom: index == SRTFModel.tableListValue.length - 1
                              ? forHeight(20)
                              : 0);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
