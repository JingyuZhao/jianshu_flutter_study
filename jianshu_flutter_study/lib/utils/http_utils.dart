import 'package:jianshu_flutter_study/common/common.dart';
import 'package:jianshu_flutter_study/models/models.dart';
class HttpUtils {
  Future<SplashModel> getSplash(){
    return Future.delayed(Duration(minutes: 3000),(){
      return SplashModel(
         title: 'Flutter 常用工具类库',
        content: 'Flutter 常用工具类库',
        url: 'https://www.jianshu.com/p/425a7ff9d66e',
        imgUrl:
            'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_common_utils_a.png',
      );
    });
  }

  //版本接口
  Future<VersionModel> getVersion() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new VersionModel(
        title: '有新版本v0.1.2，去更新吧！',
        content: '',
        url:
            'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppStore/flutter_wanandroid_new.apk',
        version: AppConfig.version,
      );
    });
  }
  //
  Future<ComModel> getRecItem() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return null;
    });
  }

  Future<List<ComModel>> getRecList() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new List();
    });
  }


}