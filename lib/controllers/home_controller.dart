import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends GetxController {
  BannerAd? homeBannerAd;
  BannerAd? tableBannerAd;
  bool isHomeAdLoaded = false;
  bool isTableAdLoaded = false;

  @override
  void onInit() {
    super.onInit();
    _loadHomeAd();
    _loadTableAd();
  }


  void _loadHomeAd() {
    homeBannerAd = BannerAd(
      adUnitId: 'ca-app-pub-2045188238772796/7822937705',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isHomeAdLoaded = true;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          print('Home Ad failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  void _loadTableAd() {
    tableBannerAd = BannerAd(
      adUnitId: 'ca-app-pub-2045188238772796/9332519988',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isTableAdLoaded = true;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          print('Table Ad failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }
}
