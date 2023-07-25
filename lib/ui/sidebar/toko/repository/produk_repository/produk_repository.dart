import 'package:admin_kangsayur/ui/sidebar/toko/model/produk_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class ProdukTokoPageRepository {
  Future<ProdukModel> produkToko(String tokoId, String kategoriId);
}

class ProdukTokoRepository extends ProdukTokoPageRepository{
  @override
  Future<ProdukModel> produkToko(String tokoId, String kategoriId) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseDetailToko = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/admin/toko/produk?tokoId=$tokoId&kategoriId=$kategoriId"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseDetailToko.body);
    print(responseDetailToko.statusCode);

    if (responseDetailToko.statusCode == 200) {
      ProdukModel produkModel= produkModelFromJson(responseDetailToko.body);
      return produkModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }

  }

}