import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/message_provider.dart';
import 'package:inkino/ui/events/events_page.dart';
import 'package:inkino/ui/inkino_app_bar.dart';
import 'package:inkino/ui/inkino_bottom_bar.dart';
import 'package:inkino/ui/showtimes/showtimes_page.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildTabContent() {
    return Positioned.fill(
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          EventsPage(EventListType.nowInTheaters),
          const ShowtimesPage(),
          EventsPage(EventListType.comingSoon),
        ],
      ),
    );
  }

  void _tabSelected(int newIndex) {
    setState(() {
      _selectedTab = newIndex;
      _tabController.index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImage = Image.asset(
      ImageAssets.backgroundImage,
      fit: BoxFit.cover,
    );

    final content = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: InkinoAppBar(),
      ),
      body: Stack(
        children: [
          _buildTabContent(),
          _BottomTabs(
            selectedTab: _selectedTab,
            onTap: _tabSelected,
          ),
        ],
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        backgroundImage,
        content,
      ],
    );
  }
}

class _BottomTabs extends StatelessWidget {
  _BottomTabs({
    @required this.selectedTab,
    @required this.onTap,
  });

  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: InkinoBottomBar(
        currentIndex: selectedTab,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            title: Text(messages.nowInTheaters),
            icon: const Icon(Icons.theaters),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            title: Text(messages.showtimes),
            icon: const Icon(Icons.schedule),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            title: Text(messages.comingSoon),
            icon: const Icon(Icons.whatshot),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
