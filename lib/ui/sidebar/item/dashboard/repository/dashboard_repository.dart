import 'package:admin_kangsayur/ui/sidebar/item/dashboard/model/dashboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class DashboardPageRepository {
  Future<DashboardModel> getDashboard();
}

class DashboardRepository implements DashboardPageRepository {

  @override
  Future<DashboardModel> getDashboard() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final responsePemasukan = await http.get(Uri.parse("https://kangsayur.nitipaja.online/api/admin/dashboard"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(responsePemasukan.body);
    print(responsePemasukan.statusCode);

    if (responsePemasukan.statusCode == 200) {
      DashboardModel dashboard = dashboardModelFromJson(responsePemasukan.body);
      return dashboard;
    } else {
      throw Exception('Gagal mendapatkan data');
    }

  }

}