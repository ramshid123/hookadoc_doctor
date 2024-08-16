import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hookadoc_server/core/theme/palette.dart';
import 'package:hookadoc_server/core/widgets/bottom_nav_bar.dart';
import 'package:hookadoc_server/core/widgets/common.dart';
import 'package:hookadoc_server/features/presentation/profile%20page/view/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _scrollAnimationController;
  late Animation _scrollAnimation;

  final scrollController = ScrollController();

  var isReadMore = ValueNotifier(false);

  @override
  void initState() {
    // TODO: implement initState
    _scrollAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _scrollAnimation = ColorTween(
            begin: Colors.transparent,
            end: ColorConstants.backgroundColor.withOpacity(0.9))
        .animate(CurvedAnimation(
            parent: _scrollAnimationController, curve: Curves.easeInOut));
    // Tween<Color>(begin: ColorConstants.redColor, end: ColorConstants.backgroundColor)
    //     .animate(CurvedAnimation(
    //         parent: _scrollAnimationController, curve: Curves.easeInOut));

    scrollController.addListener(scrollListen);
    super.initState();
  }

  void scrollListen() {
    log(scrollController.offset.toString());
    if (scrollController.offset > 25.h &&
        _scrollAnimationController.isDismissed) {
      _scrollAnimationController.forward();
    } else if (scrollController.offset < 25.h &&
        _scrollAnimationController.isCompleted) {
      _scrollAnimationController.reverse();
    }
  }

  Future showEditprofileSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => ProfilePageWidgets.editProfileSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 200.h),
        child: AnimatedBuilder(
            animation: _scrollAnimation,
            builder: (context, _) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                color: _scrollAnimation.value,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.transparent,
                        size: 25.r,
                      ),
                      kText(
                        'My Profile',
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(
                        Icons.settings,
                        color: ColorConstants.liteWhiteColor,
                        size: 25.r,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  color: ColorConstants.redColor,
                ),
                Transform.translate(
                  offset: Offset(0.0, -25.h),
                  child: Transform.scale(
                    scale: 1.01,
                    child: Container(
                      constraints: BoxConstraints(minHeight: size.height - 0.h),
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstants.backgroundColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.r)),
                      ),
                      child: Transform.translate(
                        offset: Offset(0.0, -35.h),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundColor: Colors.white,
                            ),
                            kHeight(15.h),
                            kText(
                              'Dr. Ramshid Dilhan',
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                            kText(
                              'Heart Specialist',
                              color: Colors.white60,
                              fontSize: 17,
                            ),
                            kHeight(30.h),
                            ProfilePageWidgets.countDataContainer(
                              patients: 3323,
                              experience: const Duration(days: 10 * 365),
                              rating: 4.5,
                            ),
                            kHeight(30.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: kText(
                                'About Doctor',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            kHeight(10.h),
                            GestureDetector(
                              onTap: () => isReadMore.value = !isReadMore.value,
                              child: ValueListenableBuilder(
                                  valueListenable: isReadMore,
                                  builder: (context, value, _) {
                                    return value
                                        ? Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim, libero ut vestibulum consequat, nunc augue dignissim mauris, ut pretium metus quam ac libero. Integer ullamcorper lorem lorem, ut condimentum nisi vulputate at. Aenean id mollis lorem. Nulla sagittis nisl nisl, sed elementum eros ullamcorper ac. Etiam lacinia ac nulla et elementum. Nullam dignissim mi nec felis convallis dictum. Mauris nec felis eu neque faucibus tincidunt. Sed ut elementum velit, nec gravida augue. Proin ac laoreet quam. Cras augue ipsum, vehicula laoreet maximus at, eleifend in arcu.',
                                            style: GoogleFonts.openSans(
                                              fontSize: 15.sp,
                                              color: Colors.white60,
                                            ),
                                          )
                                        : kText(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim, libero ut vestibulum consequat, nunc augue dignissim mauris, ut pretium metus quam ac libero. Integer ullamcorper lorem lorem, ut condimentum nisi vulputate at. Aenean id mollis lorem. Nulla sagittis nisl nisl, sed elementum eros ullamcorper ac. Etiam lacinia ac nulla et elementum. Nullam dignissim mi nec felis convallis dictum. Mauris nec felis eu neque faucibus tincidunt. Sed ut elementum velit, nec gravida augue. Proin ac laoreet quam. Cras augue ipsum, vehicula laoreet maximus at, eleifend in arcu.',
                                            fontSize: 15,
                                            color: Colors.white60,
                                            maxLines: 5,
                                          );
                                  }),
                            ),
                            kHeight(40.h),
                            GestureDetector(
                              onTap: () async => await showEditprofileSheet(),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: ColorConstants.redColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    kText(
                                      'Edit Profile',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    kWidth(10.w),
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20.r,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          kustomBottomNavBar(
            index: 2,
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }
}
