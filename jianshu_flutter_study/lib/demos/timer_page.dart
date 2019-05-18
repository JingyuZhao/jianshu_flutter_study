import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  TimerPage(this.title, {Key key}) : super(key: key);
  final String title;

  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  TimerUtil mTimerUtil;
  TimerUtil mCountDownTimerUtil;

  int mTick = 0;
  String timerBtnTxt = 'Start';

  int mCountDownBtnTick = 0;
  String mCountDownBtnTxt = "Start";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mTimerUtil.setOnTimerTickCallback((int tick) {
      setState(() {
        mTick = tick;
      });
    });

    mCountDownTimerUtil = TimerUtil(mInterval: 1000, mTotalTime: 6 * 1000);
    //等价于下面两行代码
    //  mCountDownTimerUtil.setInterval(1000);
    //  mCountDownTimerUtil.setTotalTime(6 * 1000);

    mCountDownTimerUtil.setOnTimerTickCallback((int countDownTick) {
      double _tick = countDownTick / 1000;
      if (_tick.toInt() == 0) {
        mCountDownBtnTxt = "Start";
        mCountDownTimerUtil.setTotalTime(6 * 1000);
      }
      setState(() {
        mCountDownBtnTick = countDownTick.toInt();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (mCountDownTimerUtil != null) mCountDownTimerUtil.cancel();
    if (mTimerUtil != null) mTimerUtil.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 4.0,
            margin: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.grey[50],
                    height: 100.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          height: 100.0,
                          color: Colors.grey[100],
                          alignment: Alignment.center,
                          child: Text("Timer"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('$mTick'),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Text('$timerBtnTxt'),
                          ),
                          onTap: () {
                            if (mTimerUtil.isActive()) {
                              mTick = 0;
                              mTimerUtil.cancel();
                              timerBtnTxt = "Start";
                            } else {
                              mTimerUtil.cancel();
                              timerBtnTxt = "Stop";
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    color: Colors.grey[50],
                    height: 100.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          height: 100.0,
                          color: Colors.grey[100],
                          alignment: Alignment.center,
                          child: Text("CountDown"),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('$mCountDownBtnTick'),
                          ),
                          flex: 1,
                        ),
                        InkWell(
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: Text('$mCountDownBtnTxt'),
                          ),
                          onTap: () {
                            if (mCountDownTimerUtil.isActive()) {
                              mCountDownTimerUtil.cancel();
                              mCountDownBtnTxt = 'Start';
                            } else {
                              mCountDownTimerUtil.startCountDown();
                              mCountDownBtnTxt = 'Stop';
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
