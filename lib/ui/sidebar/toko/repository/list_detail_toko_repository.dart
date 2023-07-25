import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/list_detail_toko_model.dart';

abstract class ListTokoDetailPageRepository {
  Future<ListDetailTokoModel> listDetailToko(String tokoId);
}

class ListDetailTokoRepository extends ListTokoDetailPageRepository{
  @override
  Future<ListDetailTokoModel> listDetailToko(String tokoId) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responseDetailToko = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/admin/toko/detail?tokoId=$tokoId"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responseDetailToko.body);
    print(responseDetailToko.statusCode);

    if (responseDetailToko.statusCode == 200) {
      ListDetailTokoModel listDetailTokoModel= listDetailTokoModelFromJson(responseDetailToko.body);
      return listDetailTokoModel;
    } else {
      throw Exception('Gagal mendapatkan data');
    }

  }
}