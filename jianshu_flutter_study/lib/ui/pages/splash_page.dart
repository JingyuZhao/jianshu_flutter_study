import 'package:flutter/material.dart';
import 'package:jianshu_flutter_study/common/component_index.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;

  List<String> _guideList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4')
  ];

  List<Widget> _bannerList = List();

  int _status = 0;
  int _count = 3;

  SplashModel _splashModel;

  _initAsync() async {
    await SpUtil.getInstance();
    _loadSplashData();
    Observable.just(1).delay(Duration(milliseconds: 500)).listen((onData) {
      if (SpUtil.getBool(Constant.KEY_GUIDE) != true &&
          ObjectUtil.isNotEmpty(_guideList)) {
        SpUtil.putBool(Constant.KEY_GUIDE, true);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  _loadSplashData() {
    _splashModel = SpHelper.getSplashModel();
    if (_splashModel != null) {
      setState(() {});
    }
    HttpUtils httpUtils = HttpUtils();
    httpUtils.getSplash().then((onValue) {
      if (!ObjectUtil.isEmpty(onValue.imgUrl)) {
        if (_splashModel == null || _splashModel.imgUrl != onValue.imgUrl) {
          SpHelper.putObject(Constant.KEY_GUIDE, onValue);
          setState(() {
            _splashModel = onValue;
          });
        } else {
          SpHelper.putObject(Constant.KEY_GUIDE, null);
        }
      }
    });
  }

  _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  _initBannerData() {
    for (var i = 0; i < _guideList.length; i++) {
      if (i == _guideList.length - 1) {
        _bannerList.add(Stack(
          children: <Widget>[
            Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 160),
                child: InkWell(
                  onTap: _goMainPage(),
                  child: CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        "立即体验",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  _initSplash() {
    if (_splashModel == null) {
      _goMainPage();
    } else {
      _doCountDown();
    }
  }

  _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });

      if (_tick == 0) {
        _goMainPage();
      }
      _timerUtil.startCountDown();
    });
  }

  _goMainPage() {
    Navigator.of(context).pushReplacementNamed("/MainPage");
  }

  Widget _buildSplashBg() {
    return Image.asset(
      Utils.getImgPath("splash_bg"),
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  Widget _buildAdWidget() {
    if (_splashModel == null) {
      return Container(
        height: 0.0,
      );
    }
    return Offstage(
      offstage: !(_status == 1),
      child: InkWell(
        onTap: () {
          if (ObjectUtil.isEmpty(_splashModel.url)) {
            return;
          }
          _goMainPage();
          NavigatorUtil.pushWeb(context,
              title: _splashModel.title, url: _splashModel.url);
        },
        child: Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: _splashModel.imgUrl,
            placeholder: (ctx, url) => _buildSplashBg(),
            errorWidget: (ctx, url, error) => _buildSplashBg(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          Offstage(
            offstage: !(_status == 2),
            child: ObjectUtil.isEmpty(_bannerList)
                ? Container()
                : Swiper(
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                        radius: 4.0,
                        padding: EdgeInsets.only(bottom: 30.0),
                        itemColor: Colors.black26),
                    children: _bannerList,
                  ),
          ),
        ],
      ),
    );
  }
}
