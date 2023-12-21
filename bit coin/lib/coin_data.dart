// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;

List<String> currency = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> source = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String url;
  CoinData(this.url);

  Future getCoinData() async {
    http.Response response = await http.get(Uri.parse(url));
    //https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=8CDAFBAF-0D4F-48EB-AAE9-6E6BA77F17A1.
    String data = response.body;
    print('data $data');
    if (response.statusCode == 200) {
      return data;
    } else {
      print(response.statusCode);
      // throw an error if our request fails.
      throw 'Problem with the get request';
    }
  }
}
