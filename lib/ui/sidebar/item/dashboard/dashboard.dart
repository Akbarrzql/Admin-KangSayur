import 'package:admin_kangsayur/common/color_value.dart';
import 'package:admin_kangsayur/ui/sidebar/item/dashboard/event/dashboard_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/dashboard/repository/dashboard_repository.dart';
import 'package:admin_kangsayur/ui/sidebar/item/dashboard/state/dashboard_state.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../laporan_pengguna.dart';
import 'bloc/dashboard_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final int jumlahToko = 10; // Jumlah toko yang harus ditampilkan
  final int jumlahProdukVerifikasi = 5; // Jumlah produk yang harus diverifikasi
  final int jumlahPengguna = 25; // Jumlah pengguna yang terdaftar
  final int jumlahPengiriman = 8; // Jumlah pengiriman yang sedang berlangsung

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            DashboardPageBloc(dashboardRepository: DashboardRepository())..add(GetDashboard()),
        child: BlocBuilder<DashboardPageBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Loading...")
                  ],
                ),
              );
            } else if (state is DashboardLoaded) {
              final dashboardModel = state.dashboardModel;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _welcomeCard(),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 4;
                        double cardWidth =
                            (constraints.maxWidth - 20 * (crossAxisCount - 1)) /
                                crossAxisCount;

                        if (constraints.maxWidth <= 1024) {
                          crossAxisCount = 2;
                          cardWidth = (constraints.maxWidth -
                                  20 * (crossAxisCount - 1)) /
                              crossAxisCount;
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                  childAspectRatio: 1.8),
                          itemCount: 4,
                          // Ubah sesuai dengan jumlah card yang ingin ditampilkan
                          itemBuilder: (context, index) {
                            return _buildInfoCard(
                              index,
                              cardWidth,
                              dashboardModel.topDashboard.jumlahToko,
                              dashboardModel.topDashboard.produkVerifikasi,
                              dashboardModel.topDashboard.jumlahPengguna,
                              dashboardModel.topDashboard.pengirimanBerlangsung,
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Data Statistik Total Pendaftaran Toko (Setiap Bulan)',
                      style: textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    //bar chart
                    SizedBox(
                      height: 300,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          LineSeries<SalesData, String>(
                            dataSource: [
                              for(int i = 0; i < dashboardModel.pendaftaranToko.length; i++)
                                SalesData(dashboardModel.pendaftaranToko[i].bulan, dashboardModel.pendaftaranToko[i].jumlahPendaftaran.toDouble()),
                            ],
                            markerSettings:
                                const MarkerSettings(isVisible: true),
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            enableTooltip: true,
                            color: ColorValue.primaryColor,
                            animationDuration: 5000,
                            yAxisName: 'Jumlah Toko',
                            xAxisName: 'Bulan',
                            xValueMapper: (SalesData sales, _) => sales.month,
                            yValueMapper: (SalesData sales, _) => sales.register,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DashboardError) {
              return const Center(
                child: Text("Terdapat kesalahan saat memuat data"),
              );
            } else {
              return const Center(
                child: Text("Terdapat kesalahan saat memuat data"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(int index, double cardWidth, int toko, int produk,
      int pengguna, int pengiriman) {
    final textTheme = Theme.of(context).textTheme;

    final List<String> cardTitles = [
      'Jumlah Toko',
      'Produk yang harus diverifikasi',
      'Jumlah Pengguna',
      'Pengiriman Berlangsung',
    ];

    final List<int> cardValues = [
      toko,
      produk,
      pengguna,
      pengiriman,
    ];

    final List<IconData> cardIcons = [
      Icons.store,
      Icons.pending,
      Icons.person,
      Icons.delivery_dining,
    ];

    final List<Color> cardColors = [
      Colors.orange,
      Colors.red,
      Colors.blue,
      Colors.teal,
    ];

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColors[index].withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: cardColors[index].withOpacity(0.1),
            radius: 25,
            child: Icon(
              size: 24,
              cardIcons[index],
              color: cardColors[index],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            cardTitles[index],
            style: textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            cardValues[index].toString(),
            style: textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: cardColors[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    final List<Map<String, dynamic>> tasks = [
      {
        'title': 'Verifikasi produk yang diunggah',
        'icon': Icons.check_circle,
        'color': Colors.green,
      },
      {
        'title': 'Kelola data pengguna',
        'icon': Icons.people,
        'color': Colors.blue,
      },
      {
        'title': 'Pantau stok produk',
        'icon': Icons.storage,
        'color': Colors.teal,
      },
      {
        'title': 'Tambahkan promosi khusus',
        'icon': Icons.local_offer,
        'color': Colors.red,
      },
    ];

    return Column(
      children: tasks.map((task) {
        return _buildTaskItem(task['title'], task['icon'], task['color']);
      }).toList(),
    );
  }

  Widget _buildTaskItem(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _welcomeCard() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorValue.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang, Admin!',
              style: textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Anda memiliki kontrol penuh atas data marketplace sayur. Selamat bekerja dan semoga sukses! 🎉',
              style: textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  final String month;
  final double register;

  SalesData(this.month, this.register);
}
