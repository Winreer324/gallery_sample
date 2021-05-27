import 'package:flutter/material.dart';
import 'package:practice_webant_gallery_app/app/ui/scenes/route/route.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int index) callBack;

  CustomBottomNavigationBar({
    this.currentIndex = 0,
    this.callBack,
  });

  Widget _buildNavigationBar(context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.green),
      currentIndex: currentIndex,
      onTap: (index) {
        if (callBack == null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(
                currentIndex: index,
              ),
            ),
            (route) => false,
          );
          return;
        } else {
          callBack(index);
        }
      },
      items: _buildListNavigationBar,
    );
  }

  List<BottomNavigationBarItem> get _buildListNavigationBar => [
        _buildBottomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        _buildBottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
        ),
      ];

  BottomNavigationBarItem _buildBottomNavigationBarItem({Icon icon, String text}) {
    return BottomNavigationBarItem(icon: icon, title: SizedBox.shrink());
  }

  @override
  build(BuildContext context) {
    return currentIndex == null ? SizedBox() : _buildNavigationBar(context);
  }
}
