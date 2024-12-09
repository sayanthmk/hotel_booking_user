import 'package:flutter/material.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_list/bookings.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/booking_home.dart';
import 'package:hotel_booking/features/profile/profile.dart';
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
    const MyProfile(),
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.book_online),
            title: const Text("Bookings"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
