import 'package:flutter/material.dart';
import 'package:practice_webant_gallery_app/app/ui/scenes/gallery/bloc/gallery_bloc.dart';
import 'package:practice_webant_gallery_app/app/ui/scenes/gallery/gallery_screen.dart';
import 'package:practice_webant_gallery_app/gateway/http/new_photo_gateway.dart';
import 'package:practice_webant_gallery_app/gateway/http/popular_photo_gateway.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  final int currentIndex;

  const MainScreen({
    Key key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static double _mainContainerHeight = 80;

  final _listPages = [
    BlocProvider(
      create: (_) => GalleryBloc(NewPhotoGateway())..add(GalleryFetch()),
      child: GalleryScreen(),
    ),
    BlocProvider(
      create: (_) => GalleryBloc(PopularPhotoGateway())..add(GalleryFetch()),
      child: GalleryScreen(),
    ),
  ];

  int _selectedTab = 0;
  Map<int, GlobalKey<NavigatorState>> _navKeys = {};

  @override
  void initState() {
    _initNavigationKeys();

    super.initState();
  }

  void _initNavigationKeys() {
    _listPages.asMap().forEach((i, element) {
      _navKeys.putIfAbsent(i, () => GlobalKey<NavigatorState>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => !await _navKeys[_selectedTab].currentState.maybePop(),
          child: IndexedStack(
            index: _selectedTab,
            children: List.generate(
                _listPages.length, (index) => _buildItemNavigation(key: _navKeys[index], page: _listPages[index])),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        callBack: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        currentIndex: _selectedTab,
      ),
    );
  }

  Navigator _buildItemNavigation({GlobalKey<NavigatorState> key, dynamic page}) {
    return Navigator(
      key: key,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => page,
      ),
    );
  }
}
