import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/model/confirm/konfirmasi_verifikasi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class VerifyProdukPageRepository {
  Future<KonfirmasiVerifikasiModel> verifyProduk(String idProduk);
}

class VerifyProdukRepository implements VerifyProdukPageRepository {
  @override
  Future<KonfirmasiVerifikasiModel> verifyProduk(String idProduk) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responsePemasukan = await http.post(Uri.parse("https://kangsayur.nitipaja.online/api/admin/produk/verifikasi?produkId=$idProduk"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responsePemasukan.body);
    print(responsePemasukan.statusCode);

    if (responsePemasukan.statusCode == 200) {
      KonfirmasiVerifikasiModel konfirmasiVerifikasi = konfirmasiVerifikasiModelFromJson(responsePemasukan.body);
      return konfirmasiVerifikasi;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }


}