import 'package:absensi_qr/cubit/auth/auth_cubit.dart';
import 'package:absensi_qr/cubit/class/class_cubit.dart';
import 'package:absensi_qr/ui/pages/home/content/data_absen_page.dart';
import 'package:absensi_qr/ui/pages/home/content/data_kelas_page.dart';
import 'package:absensi_qr/ui/pages/home/content/generate_qr_page.dart';
import 'package:absensi_qr/ui/pages/home/content/scan_qr_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'content/dashboard_page.dart';
import 'content/data_siswa_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String titleName = '';

  List<Widget> widgetOptions = [
    const DashboardPage(),
    const DataSiswaPage(),
    const DataAbsenPage(),
    const DataKelasPage(),
    const GenerateQrPage(),
    const ScanQrPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setTitleName(int index) {
    setState(() {
      switch (index) {
        case 0:
          titleName = 'Dashboard';
          break;
        case 1:
          titleName = 'Data Siswa';
          break;
        case 2:
          titleName = 'Data Absensi';
          break;
        case 3:
          titleName = 'Data Kelas';
          break;
        case 4:
          titleName = 'Generate QR';
          break;
        case 5:
          titleName = 'Scan QR Absensi';
          break;
        default:
          titleName = 'Dashboard';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void logout() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text('Apakah anda yakin ingin logout?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Tidak')),
              TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    // Toast
                    Fluttertoast.showToast(
                      msg: 'Berhasil logout',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: const Text('Ya')),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(titleName,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            )),
        centerTitle: true,
        toolbarHeight: 100,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red,
            ),
            child: IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        onRefresh: () {
          switch (_selectedIndex) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              context.read<ClassCubit>().getClasses();
              break;
            case 4:
              break;
            case 5:
              break;
            default:
          }
          return Future.delayed(const Duration(seconds: 1));
        },
        child: Center(
          child: widgetOptions[_selectedIndex],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    const Text(
                      'ABSENSI QR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.dashboard,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text('Dashboard'),
                ],
              ),
              selected: _selectedIndex == 0,
              selectedColor: Colors.blue,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                _setTitleName(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.people_alt_rounded,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text('Data Siswa'),
                ],
              ),
              selected: _selectedIndex == 1,
              selectedColor: Colors.blue,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                _setTitleName(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.checklist_rounded,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text('Data Absensi'),
                ],
              ),
              selected: _selectedIndex == 2,
              selectedColor: Colors.blue,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                _setTitleName(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.list_alt_rounded,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text('Data Kelas'),
                ],
              ),
              selected: _selectedIndex == 3,
              selectedColor: Colors.blue,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                _setTitleName(3);
                context.read<ClassCubit>().getClasses();
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.qr_code_rounded,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text('Generate QR'),
                ],
              ),
              selected: _selectedIndex == 4,
              selectedColor: Colors.blue,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                _setTitleName(4);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 32,
                  ),
                  SizedBox(width: 16),
                  Text('Scan QR Absensi'),
                ],
              ),
              selected: _selectedIndex == 5,
              selectedColor: Colors.blue,
              onTap: () {
                // Update the state of the app
                _onItemTapped(5);
                _setTitleName(5);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
