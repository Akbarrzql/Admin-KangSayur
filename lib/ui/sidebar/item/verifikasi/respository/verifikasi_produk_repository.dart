import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/verifikasi_produk_model.dart';

abstract class VerifikasiProdukPageRepository {
  Future<VerifikasiProdukModel> getVerifikasiProduk();
}

class VerifikasiProdukRepository extends VerifikasiProdukPageRepository{
  @override
  Future<VerifikasiProdukModel> getVerifikasiProduk() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responsePemasukan = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/admin/produk/verifikasi/list"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responsePemasukan.body);
    print(responsePemasukan.statusCode);

    if (responsePemasukan.statusCode == 200) {
      VerifikasiProdukModel verifikasiProduk = verifikasiProdukModelFromJson(responsePemasukan.body);
      return verifikasiProduk;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

}