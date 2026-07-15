import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/auth/presentation/providers/googleauth/bloc/google_auth_bloc.dart';
import 'package:hotel_booking/features/home/presentation/pages/home_section/home_page_section.dart';
import 'package:hotel_booking/features/profile/presentation/pages/main_profile/menu_item.dart';
import 'package:hotel_booking/features/profile/presentation/pages/profile_detail/profile_page/profile_page.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_bloc.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_event.dart';
import 'package:hotel_booking/features/profile/presentation/providers/bloc/userprofile_state.dart';
import 'package:hotel_booking/features/settings/contact_us.dart';
import 'package:hotel_booking/features/settings/settings_page/settings_page.dart';
import 'package:hotel_booking/utils/alertbox/alertbox.dart';
import '../../../../auth/presentation/pages/routepage.dart';

class ProfileUiNew extends StatefulWidget {
  const ProfileUiNew({super.key});

  @override
  State<ProfileUiNew> createState() => _ProfileUiNewState();
}

class _ProfileUiNewState extends State<ProfileUiNew> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(LoadUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildProfileCard(context)),
            SliverToBoxAdapter(child: _buildSectionHeader('Account')),
            SliverToBoxAdapter(child: _buildAccountCard(context)),
            SliverToBoxAdapter(child: _buildSectionHeader('Support')),
            SliverToBoxAdapter(child: _buildSupportCard(context)),
            SliverToBoxAdapter(child: _buildLogoutCard(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  // ---------------- Header ----------------
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account', style: AppTextStyles.greeting),
                SizedBox(height: 4),
                Text('My Profile', style: AppTextStyles.username),
              ],
            ),
          ),
          _AnimatedTapScale(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ));
            },
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.settings_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Profile info card ----------------
  Widget _buildProfileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          final user = state is UserLoaded ? state.user : null;
          final name =
              user != null && user.name.isNotEmpty ? user.name : 'Guest';
          final email = user?.email ?? '';
          final image = user?.profileImage ?? '';

          return _AnimatedTapScale(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PrpageMyProfilePage(),
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 66,
                      height: 66,
                      child: _ProfileAvatar(imageUrl: image),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.hotelName
                              .copyWith(fontSize: 17),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email.isNotEmpty ? email : 'View and edit profile',
                          style: AppTextStyles.hotelLocation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- Section header ----------------
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
        ],
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(children: children),
      ),
    );
  }

  // ---------------- Account section ----------------
  Widget _buildAccountCard(BuildContext context) {
    return _card([
      MenuItemWidget(
        icon: Icons.person_outline_rounded,
        title: "Profile",
        subtitle: "View and edit your profile details",
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PrpageMyProfilePage(),
          ));
        },
      ),
      MenuItemWidget(
        icon: Icons.settings_outlined,
        title: "Settings",
        subtitle: "App preferences and configuration",
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ));
        },
        isLastItem: true,
      ),
    ]);
  }

  // ---------------- Support section ----------------
  Widget _buildSupportCard(BuildContext context) {
    return _card([
      MenuItemWidget(
        icon: Icons.contact_support_outlined,
        title: "Contact Us",
        subtitle: "Get help and support",
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactUsPage(),
          ));
        },
      ),
      MenuItemWidget(
        icon: Icons.question_answer_outlined,
        title: "FAQs",
        subtitle: "Frequently asked questions",
        onTap: () {},
        isLastItem: true,
      ),
    ]);
  }

  // ---------------- Logout ----------------
  Widget _buildLogoutCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: _card([
        MenuItemWidget(
          icon: Icons.logout_rounded,
          title: "Logout",
          subtitle: "Sign out of your account",
          iconBackgroundColor: Colors.redAccent,
          iconColor: Colors.redAccent,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                titleText: 'Logout',
                contentText: 'Are you sure you want to Logout?',
                buttonText1: 'Cancel',
                buttonText2: 'Logout',
                onPressButton1: () {
                  Navigator.of(context).pop();
                },
                onPressButton2: () async {
                  context.read<AuthBloc>().add(SignOutEvent());
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const AuthSelectionPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            );
          },
          isLastItem: true,
        ),
      ]),
    );
  }
}

/// Shows the user's profile image, falling back to a gradient + icon
/// placeholder when no image is set or it fails to load.
class _ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  const _ProfileAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: imageUrl.isEmpty
          ? const Center(
              child: Icon(Icons.person_rounded, size: 32, color: Colors.white),
            )
          : Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child:
                    Icon(Icons.person_rounded, size: 32, color: Colors.white),
              ),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

/// Wraps a child with a subtle scale-down animation on tap for tactile feedback.
class _AnimatedTapScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _AnimatedTapScale({required this.child, required this.onTap});

  @override
  State<_AnimatedTapScale> createState() => _AnimatedTapScaleState();
}

class _AnimatedTapScaleState extends State<_AnimatedTapScale> {
  double _scale = 1.0;

  void _setScale(double value) => setState(() => _scale = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setScale(0.96),
      onTapUp: (_) => _setScale(1.0),
      onTapCancel: () => _setScale(1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
