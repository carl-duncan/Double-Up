import 'package:dio/dio.dart';
import 'package:double_up/models/gift_card.dart';

class BlinkSkyRepository {
  static String apiKey = "";
  static Dio dio = Dio();
  static String url = "https://api.blinksky.com/api/v1/";

  static getCatalog() async {
    Response response = await dio.post(url + "catalog", data: {
      "service": {"apikey": apiKey}
    });
    List<GiftCard> cards = [];
    for (dynamic obj in response.data["d"]) {
      GiftCard card = GiftCard.fromJson(obj);
      cards.add(card);
    }
    return cards;
  }
}
