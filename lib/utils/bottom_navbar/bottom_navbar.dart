// import 'package:flutter/material.dart';
// import 'package:hotel_booking/core/constants/colors.dart';
// import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_list_main_page/bookings.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_page/booking_home.dart';
// import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
// import 'package:hotel_booking/features/profile/presentation/pages/main_profile/profile_main.dart';
// import 'package:hotel_booking/features/wishlist/presentation/page/wish_list.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// class BtBar extends StatefulWidget {
//   const BtBar({super.key});

//   @override
//   BtBarState createState() => BtBarState();
// }

// class BtBarState extends State<BtBar> {
//   final List<Widget> pages = [
//     // const RoomBookingHome(),
//     HomePage(),
//     const UserBookingsPage(),
//     const FavoritesPage(),
//     const ProfileUiNew(),
//   ];

//   var _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: pages[_currentIndex],
//       bottomNavigationBar: SalomonBottomBar(
//         currentIndex: _currentIndex,
//         onTap: (i) => setState(() => _currentIndex = i),
//         items: [
//           /// Home
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.home),
//             title: const Text("Home"),
//             selectedColor: HotelBookingColors.basictextcolor,
//             unselectedColor: Colors.grey,
//           ),

//           /// Likes
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.book),
//             title: const Text("Bookings"),
//             selectedColor: HotelBookingColors.basictextcolor,
//             unselectedColor: Colors.grey,
//           ),

//           /// Search
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.favorite),
//             title: const Text("Favorites"),
//             selectedColor: HotelBookingColors.basictextcolor,
//             unselectedColor: Colors.grey,
//           ),

//           /// Profile
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.person),
//             title: const Text("Profile"),
//             selectedColor: HotelBookingColors.basictextcolor,
//             unselectedColor: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_list_main_page/bookings.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/features/profile/presentation/pages/main_profile/profile_main.dart';
import 'package:hotel_booking/features/wishlist/presentation/page/wish_list.dart';

// Import your pages

class BtBar extends StatefulWidget {
  const BtBar({Key? key}) : super(key: key);

  @override
  State<BtBar> createState() => _BtBarState();
}

class _BtBarState extends State<BtBar> {
  int _currentNavIndex = 0;

  final List<IconData> items = [
    Icons.home_rounded,
    Icons.explore_rounded,
    Icons.bookmark_rounded,
    Icons.person_rounded,
  ];

  // 🔥 Your pages added here
  final List<Widget> pages = [
    HomePage(),
    const UserBookingsPage(),
    const FavoritesPage(),
    const ProfileUiNew(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[_currentNavIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          color: Colors.transparent,
          child: _buildBottomNav(),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (i) {
          final selected = i == _currentNavIndex;

          return GestureDetector(
            onTap: () => setState(() => _currentNavIndex = i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutBack,
              width: selected ? 52 : 44,
              height: selected ? 52 : 44,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Icon(
                items[i],
                color: selected ? Colors.white : AppColors.textGrey,
                size: 24,
              ),
            ),
          );
        }),
      ),
    );
  }
}
