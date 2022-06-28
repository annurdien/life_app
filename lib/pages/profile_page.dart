import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/constants.dart';
import 'package:life_app/themes/custom_theme.dart';

import '../core/provider/user_provider.dart';
import '../utils.dart';

class ProfilePage extends StatefulHookConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProvider);
    final textTheme = context.textTheme;
    final colors = context.colors;

    return Scaffold(
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(
          child: Text("Error Loading Profile Data"),
        ),
        data: (user) {
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 25.w),
            children: [
              40.verticalSpace,
              ProfilePicture(
                image: user.image ?? Constants.IMAGE_PLACEHOLDER,
              ),
              20.verticalSpace,
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.name,
                      style: textTheme.title.withColor(colors.snow),
                    ),
                    Text(
                      user.email,
                      style: textTheme.caption.withColor(colors.snow),
                    ),
                    40.verticalSpace,
                    ListButton(
                      title: "Edit Profile",
                      icon: Icons.person,
                      onTap: () {},
                    ),
                    40.verticalSpace,
                    ListButton(
                      title: "Language",
                      icon: Icons.language,
                      onTap: () {},
                    ),
                    35.verticalSpace,
                    ListButton(
                      title: "Reminder",
                      icon: Icons.alarm,
                      onTap: () {},
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class ListButton extends StatelessWidget {
  const ListButton({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Ink(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: colors.snow,
              size: 30.sp,
            ),
            20.horizontalSpace,
            Text(
              title,
              style: GoogleFonts.inter().copyWith(
                fontWeight: FontWeight.w600,
                color: colors.snow,
                fontSize: 16.sp,
              ),
            ),
            const Spacer(),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190.w,
      height: 250.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            top: 0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(image),
              onBackgroundImageError: (e, stack) =>
                  const Text("Error Loading Image Data"),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 50,
            right: 50,
            child: Container(
              height: 40.h,
              width: 40.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
