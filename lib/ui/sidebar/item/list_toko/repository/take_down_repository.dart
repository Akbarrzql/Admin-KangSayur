import 'package:admin_kangsayur/ui/sidebar/item/list_toko/model/take_down_produk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class TakeDownPageRepository {
  Future<TakeDownModel> postTakeDownProduk(
      String tokoId,
      String produkId,
      String alasan
      );
}

class TekaDownRepository extends TakeDownPageRepository{
  @override
  Future<TakeDownModel> postTakeDownProduk(String tokoId, String produkId, String alasan) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responsePemasukan = await http.post(Uri.parse("https://kangsayur.nitipaja.online/api/admin/produk/take/down"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },body: {
          'toko_id': tokoId,
          'produk_id': produkId,
          'alasan': alasan,
        }
    );

    print(responsePemasukan.body);
    print(responsePemasukan.statusCode);

    if (responsePemasukan.statusCode == 200) {
      TakeDownModel takeDownModel = takeDownModelFromJson(responsePemasukan.body);
      return takeDownModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

}