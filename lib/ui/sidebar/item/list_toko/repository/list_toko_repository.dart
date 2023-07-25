import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/list_toko_model.dart';

abstract class ListTokoPageRepository {
  Future<ListTokoModel> listToko();
}

class ListTokoRepository extends ListTokoPageRepository{
  @override
  Future<ListTokoModel> listToko() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responsePemasukan = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/admin/toko/list"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responsePemasukan.body);
    print(responsePemasukan.statusCode);

    if (responsePemasukan.statusCode == 200) {
      ListTokoModel listToko = listTokoModelFromJson(responsePemasukan.body);
      return listToko;
    } else {
      throw Exception('Gagal mendapatkan data');
    }

  }
}