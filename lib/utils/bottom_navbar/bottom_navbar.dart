import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_list_main_page/bookings.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/booking_home.dart';
import 'package:hotel_booking/features/profile/presentation/pages/main_profile/profile_main.dart';
import 'package:hotel_booking/features/wishlist/presentation/page/wish_list.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BtBar extends StatefulWidget {
  const BtBar({super.key});

  @override
  BtBarState createState() => BtBarState();
}

class BtBarState extends State<BtBar> {
  final List<Widget> pages = [
    const RoomBookingHome(),
    const UserBookingsPage(),
    const FavoritesPage(),
    const ProfileUiNew(),
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: HotelBookingColors.basictextcolor,
            unselectedColor: Colors.grey,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.book),
            title: const Text("Bookings"),
            selectedColor: HotelBookingColors.basictextcolor,
            unselectedColor: Colors.grey,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            selectedColor: HotelBookingColors.basictextcolor,
            unselectedColor: Colors.grey,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: HotelBookingColors.basictextcolor,
            unselectedColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
