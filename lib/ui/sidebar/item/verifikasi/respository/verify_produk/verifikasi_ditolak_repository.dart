import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/confirm/verifikasi_ditolak_model.dart';

abstract class VerifikasiDitolakPageRepository {
  Future<VerifikasiDitolakModel> verifikasiDitolak(
      String idProduk,
      String idToko,
      String alasanDitolak,
      );
}

class VerifikasiDitolakRepository extends VerifikasiDitolakPageRepository{
  @override
  Future<VerifikasiDitolakModel> verifikasiDitolak(String idProduk, String idToko, String alasanDitolak,) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responsePemasukan = await http.post(Uri.parse("https://kangsayur.nitipaja.online/api/admin/produk/verifikasi/ditolak"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },body: {
        'produkId': idProduk,
        'toko_id': idToko,
        'alasan': alasanDitolak,
        }
    );

    print(responsePemasukan.body);
    print(responsePemasukan.statusCode);

    if (responsePemasukan.statusCode == 200) {
      VerifikasiDitolakModel verifikasiDitolakModel = verifikasiDitolakModelFromJson(responsePemasukan.body);
      return verifikasiDitolakModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

}