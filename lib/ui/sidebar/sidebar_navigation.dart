
import 'package:admin_kangsayur/ui/auth/bloc/logout_bloc.dart';
import 'package:admin_kangsayur/ui/auth/repository/logout_repository.dart';
import 'package:admin_kangsayur/ui/auth/state/logout_state.dart';
import 'package:admin_kangsayur/ui/sidebar/item/chat/chat.dart';
import 'package:admin_kangsayur/ui/sidebar/item/dashboard/dashboard.dart';
import 'package:admin_kangsayur/ui/sidebar/item/laporan_pengguna.dart';
import 'package:admin_kangsayur/ui/sidebar/item/list_toko/list_toko.dart';
import 'package:admin_kangsayur/ui/sidebar/item/pengaturan.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/produk.dart';
import 'package:admin_kangsayur/ui/sidebar/item/verifikasi/toko.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/color_value.dart';
import '../auth/auth/login.dart';
import '../auth/event/logout_event.dart';

class SidebarNavigation extends StatefulWidget {
  const SidebarNavigation({Key? key}) : super(key: key);

  @override
  State<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {

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
    return BlocProvider(
      create: (context) => LogoutPageBloc(logoutRepository: LogoutRepository()),
      child: Scaffold(
        body: BlocConsumer<LogoutPageBloc, LogoutPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is InitialLogoutPageState){
              final mainContext = context;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SideMenu(
                    controller: sideMenu,
                    style: SideMenuStyle(
                      itemOuterPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                      displayMode: SideMenuDisplayMode.auto,
                      hoverColor: Colors.green[100],
                      selectedColor: ColorValue.primaryColor,
                      selectedTitleTextStyle: const TextStyle(color: Colors.white),
                      selectedIconColor: Colors.white,
                    ),
                    title: Column(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 150,
                            maxWidth: 150,
                          ),
                          child: Image.asset(
                            'assets/images/logo_kangsayur.png',
                          ),
                        ),
                        const Divider(
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                      ],
                    ),
                    footer: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Kang Sayur',
                        style: textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: ColorValue.neutralColor,
                        ),
                      ),
                    ),
                    items: [
                      //menu item
                      SideMenuItem(
                        priority: 0,
                        title: 'Dashboard',
                        onTap: (page, _) {
                          sideMenu.changePage(page);
                        },
                        icon: const Icon(Icons.dashboard),
                        tooltipContent: "Dashboard",
                      ),
                      SideMenuItem(
                        priority: 1,
                        title: 'List Toko',
                        onTap: (page, _) {
                          sideMenu.changePage(page);
                        },
                        icon: const Icon(Icons.store),
                      ),
                      // SideMenuItem(
                      //   priority: 2,
                      //   title: 'Verifikasi Toko',
                      //   onTap: (page, _) {
                      //     sideMenu.changePage(page);
                      //   },
                      //   icon: const Icon(Icons.shopping_bag),
                      //   trailing: Container(
                      //       decoration: const BoxDecoration(
                      //           color: Colors.amber,
                      //           borderRadius: BorderRadius.all(Radius.circular(6))),
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 6.0, vertical: 3),
                      //         child: Text(
                      //           'New',
                      //           style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      //         ),
                      //       )),
                      // ),
                      SideMenuItem(
                        priority: 2,
                        title: 'Verifikasi Produk',
                        onTap: (page, _) {
                          sideMenu.changePage(page);
                        },
                        icon: const Icon(Icons.shopping_bag),
                          trailing: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(Radius.circular(6))),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 3),
                                child: Text(
                                  'Penting !',
                                  style: TextStyle(fontSize: 11, color: Colors.white),
                                ),
                              ))
                      ),
                      // SideMenuItem(
                      //   priority: 3,
                      //   title: 'Laporan Pengguna',
                      //   onTap: (page, _) {
                      //     sideMenu.changePage(page);
                      //   },
                      //   icon: const Icon(Icons.report),
                      // ),
                      SideMenuItem(
                        priority: 3,
                        title: 'Chat',
                        onTap: (page, _) {
                          sideMenu.changePage(page);
                        },
                        icon: const Icon(Icons.chat),
                      ),
                      // SideMenuItem(
                      //   priority: 6,
                      //   title: 'Pengaturan',
                      //   onTap: (page, _) {
                      //     sideMenu.changePage(page);
                      //   },
                      //   icon: const Icon(Icons.settings),
                      // ),
                      SideMenuItem(
                        onTap: (page, _) {
                          exitPage(context, mainContext);
                        },
                        priority: 4,
                        title: 'Keluar',
                        icon: const Icon(Icons.exit_to_app_outlined, color: Colors.red),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: page,
                      children: const [
                        //page class
                        DashboardPage(),
                        ListToko(),
                        // TokoAllPage(),
                        ProdukALlPage(),
                        // LaporanPengguna(),
                        ChatPage(),
                        // PengaturanPage(),
                      ],
                    ),
                  ),
                ],
              );
            }else if(state is LogoutPageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LogoutPageLoaded) {
              return const LoginPage();
            } else if (state is LogoutPageError) {
              return const Center(
                child: Text('Terjadi kesalahan'),
              );
            } else {
              return const Center(
                child: Text('Terjadi kesalahan'),
              );
            }
          },
        )
      ),
    );
  }

  void exitPage(BuildContext context, BuildContext context2) {
    final textTheme = Theme.of(context).textTheme;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Image.asset(
              'assets/images/logout.png',
              height: 200,
              width: 200,
            ),
            content: Text(
                'Apakah anda yakin ingin keluar?',
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: ColorValue.neutralColor,
                )
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                    'Tidak',
                    style: textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorValue.primaryColor,
                    )
                ),
              ),
              TextButton(
                onPressed: () {
                  print('logout');
                  BlocProvider.of<LogoutPageBloc>(context2).add(LogoutButtonPressed());
                  Navigator.pop(context);
                },
                child: Text(
                    'Ya, Keluar',
                    style: textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorValue.primaryColor,
                    )
                ),
              ),
            ],
          );
        });
  }
}
