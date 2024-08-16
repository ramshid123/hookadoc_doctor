import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hookadoc_server/core/routes/route_names.dart';
import 'package:hookadoc_server/core/theme/palette.dart';
import 'package:hookadoc_server/core/widgets/common.dart';

Widget kustomBottomNavBar({
  required int index,
  AnimationController? animationController,
  ScrollController? scrollController,
}) {
  return _KustomBottomNavBar(
    index: index,
    scrollController: scrollController,
    scrollAnimationController: animationController,
  );
}

// Bottom Nav Bar
class _KustomBottomNavBar extends StatefulWidget {
  final int index;
  AnimationController? scrollAnimationController;
  final ScrollController? scrollController;
  _KustomBottomNavBar({
    required this.index,
    this.scrollAnimationController,
    this.scrollController,
  });

  @override
  State<_KustomBottomNavBar> createState() => __KustomBottomNavBarState();
}

class __KustomBottomNavBarState extends State<_KustomBottomNavBar>
    with SingleTickerProviderStateMixin {
  late Animation _scrollAnimation;

  @override
  void initState() {
    // TODO: implement initState

    widget.scrollAnimationController ??= AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _scrollAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.scrollAnimationController!, curve: Curves.easeInOut));

    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_scrollListener);
    }
    super.initState();
  }

  void _scrollListener() async {
    if (widget.scrollController!.position.userScrollDirection ==
        ScrollDirection.reverse) {
      widget.scrollAnimationController!.stop();
      await widget.scrollAnimationController!.forward();
    } else if (widget.scrollController!.position.userScrollDirection ==
        ScrollDirection.forward) {
      widget.scrollAnimationController!.stop();
      await widget.scrollAnimationController!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _scrollAnimation,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Transform.translate(
                offset: Offset(0.0, -10.h),
                child: Transform.translate(
                  offset: Offset(0.0, 100.h * _scrollAnimation.value),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.r, sigmaY: 10.r),
                        child: Container(
                          clipBehavior: Clip.none,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white54,
                                Colors.white24,
                                Colors.white10,
                                // Colors.transparent,
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _BottomNavBarItem(
                                isSelected: widget.index == 0,
                                icon: Icons.home_filled,
                                path: RouteNames.homePage,
                              ),
                              _BottomNavBarItem(
                                isSelected: widget.index == 1,
                                icon: Icons.pending_actions,
                                isDotShown: widget.index != 1,
                                path: RouteNames.schedulesPage,
                              ),
                              kWidth(10.w),
                              GestureDetector(
                                onTap: () => context.go(RouteNames.qrScanPage),
                                child: Container(
                                  margin: EdgeInsets.all(5.r),
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: ColorConstants.redColor
                                        .withOpacity(0.9),
                                  ),
                                  child: Icon(
                                    Icons.qr_code_2,
                                    size: 30.r,
                                  ),
                                ),
                              ),
                              kWidth(10.w),
                              _BottomNavBarItem(
                                isSelected: widget.index == 2,
                                icon: Icons.person_rounded,
                                path: RouteNames.profilePage,
                              ),
                              _BottomNavBarItem(
                                isSelected: widget.index == 3,
                                icon: Icons.settings,
                                path: RouteNames.profilePage,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

// Bottom Nav Bar Item

class _BottomNavBarItem extends StatefulWidget {
  final IconData icon;
  final String path;
  final bool isSelected;
  final bool isDotShown;
  const _BottomNavBarItem({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.isDotShown = false,
    required this.path,
  });

  @override
  State<_BottomNavBarItem> createState() => __BottomNavBarItemState();
}

class __BottomNavBarItemState extends State<_BottomNavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  bool isAnimControllerDisposed = false;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 3.r, end: 7.r).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    animateDot();
    super.initState();
  }

  Future animateDot() async {
    if (widget.isDotShown) {
      while (true) {
        if (!isAnimControllerDisposed) {
          await _animationController.forward();
          await _animationController.reverse();
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isAnimControllerDisposed = true;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => context.go(widget.path),
      child: IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.all(5.r),
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isSelected ? Colors.white : Colors.black38,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                widget.icon,
                size: 25.r,
                color: widget.isSelected ? Colors.black54 : Colors.white70,
              ),
              widget.isDotShown
                  ? Transform.translate(
                      offset: Offset(10.r, -10.r),
                      child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, _) {
                            return CircleAvatar(
                              radius: _animation.value,
                              backgroundColor: Colors.white,
                            );
                          }),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
