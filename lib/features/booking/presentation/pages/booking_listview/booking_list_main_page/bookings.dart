import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/booking/data/model/booking_model.dart';
import 'package:hotel_booking/features/booking/presentation/pages/booking_listview/booking_list_main_page/booking_show_card.dart';
import 'package:hotel_booking/features/booking/presentation/providers/bloc/user_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';

class UserBookingsPage extends StatefulWidget {
  const UserBookingsPage({super.key});

  @override
  State<UserBookingsPage> createState() => _UserBookingsPageState();
}

class _UserBookingsPageState extends State<UserBookingsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<UserBloc>().add(GetUserDataEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final bloc = context.read<UserBloc>();
    bloc.add(GetUserDataEvent());
    await bloc.stream.firstWhere((state) => state is! UserLoadingState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Bookings', style: AppTextStyles.username),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: AppColors.cardShadow,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textGrey,
          labelStyle: AppTextStyles.chip,
          unselectedLabelStyle:
              AppTextStyles.chip.copyWith(fontWeight: FontWeight.w500),
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const _LoadingView();
          }

          if (state is UserErrorState) {
            return _ErrorView(
              message: state.message,
              onRetry: () =>
                  context.read<UserBloc>().add(GetUserDataEvent()),
            );
          }

          if (state is UserDataLoadedState) {
            final now = DateTime.now();
            final upcoming = state.userData
                .where((b) => !b.enddate!.isBefore(now))
                .toList()
              ..sort((a, b) => a.startdate!.compareTo(b.startdate!));
            final past = state.userData
                .where((b) => b.enddate!.isBefore(now))
                .toList()
              ..sort((a, b) => b.startdate!.compareTo(a.startdate!));

            return TabBarView(
              controller: _tabController,
              children: [
                _BookingsList(
                  bookings: upcoming,
                  emptyMessage: 'No upcoming bookings',
                  onRefresh: _refresh,
                ),
                _BookingsList(
                  bookings: past,
                  emptyMessage: 'No past bookings',
                  onRefresh: _refresh,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _BookingsList extends StatelessWidget {
  const _BookingsList({
    required this.bookings,
    required this.emptyMessage,
    required this.onRefresh,
  });

  final List<UserDataModel> bookings;
  final String emptyMessage;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: onRefresh,
      child: bookings.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                Center(
                  child: Icon(
                    Icons.bookmark_border_rounded,
                    size: 80,
                    color: AppColors.textGrey,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      emptyMessage,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.hotelName
                          .copyWith(color: AppColors.textGrey),
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) =>
                  BookingShowCard(booking: bookings[index]),
            ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'Loading your bookings...',
            style: AppTextStyles.hotelLocation.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              style: TextStyle(color: Colors.red.shade300),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text('Retry', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
