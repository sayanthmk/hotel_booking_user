import 'package:flutter/material.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/home_search_bar.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/hotels_gridview.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/hotellistview/hotels_list_view.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/location_notification_bar.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_page/sort_hotels_by_location.dart';
import 'package:hotel_booking/features/home/presentation/widgets/section_header.dart';

class RoomBookingHome extends StatelessWidget {
  const RoomBookingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HotelBookingColors.pagebackgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const LocationWithNotificationBar(),
                const SizedBox(height: 20),
                const HomeSearchBar(),
                const SizedBox(
                  height: 10,
                ),
                SectionHeader(
                  title: 'Hotel Near You',
                  actionText: 'View All',
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HotelsGridView(),
                    ));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // MyHorizontalListView(),

                //==================================
                const HotelsListView(),
                // TestListView(),
                SectionHeader(
                  title: 'Explore By City',
                  actionText: 'View All',
                  ontap: () {},
                ),
                const SortHotelsByLocation(),
                SectionHeader(
                  title: 'Suggested Hotels',
                  actionText: 'View All',
                  ontap: () {},
                ),
                const HotelsListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
