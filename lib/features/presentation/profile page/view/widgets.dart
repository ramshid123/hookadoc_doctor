import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hookadoc_server/core/theme/palette.dart';
import 'package:hookadoc_server/core/widgets/common.dart';

class ProfilePageWidgets {
  static Widget countDataContainer(
      {required int patients,
      required Duration experience,
      required double rating}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorConstants.redColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              kText(
                'Patients',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              kHeight(5.h),
              kText(
                patients.toString(),
                fontSize: 20,
              ),
            ],
          ),
          Container(
            height: 50.h,
            width: 1.w,
            color: Colors.black45,
          ),
          Column(
            children: [
              kText(
                'Experience',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              kHeight(5.h),
              RichText(
                text: TextSpan(
                  text: '${experience.inDays ~/ 365} ',
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: 'yrs',
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              // kText(
              //   '${experience.inDays ~/ 365} yrs',
              //   fontSize: 20,
              // ),
            ],
          ),
          Container(
            height: 50.h,
            width: 1.w,
            color: Colors.black45,
          ),
          Column(
            children: [
              kText(
                'Rating',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              kHeight(5.h),
              kText(
                rating.toString(),
                fontSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget editProfileSheet() {
    return const _EditProfileSheet();
  }

  static Widget _editProfileTextField({
    required String title,
    required String hintText,
    int minLines = 1,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kText(
            ' ${title}',
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          kHeight(15.h),
          TextField(
            style: GoogleFonts.robotoMono(
              fontSize: 15.sp,
              color: Colors.white70,
            ),
            minLines: minLines,
            maxLines: minLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.whiteColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditProfileSheet extends StatelessWidget {
  const _EditProfileSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: ColorConstants.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: ()=>Navigator.pop(context),
                    child: Container(
                        padding: EdgeInsets.all(5.r),
                        child: Icon(
                          Icons.navigate_before,
                          color: Colors.white,
                          size: 30.r,
                        )),
                  ),
                  kText(
                    'Edit your profile',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  Container(
                      padding: EdgeInsets.all(5.r),
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.transparent,
                        size: 30.r,
                      ))
                ],
              ),
              kHeight(40.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.white,
                  ),
                  Transform.translate(
                      offset: Offset(30.r, 30.r),
                      child: CircleAvatar(
                        backgroundColor: ColorConstants.redColor,
                        child: Padding(
                          padding: EdgeInsets.all(5.r),
                          child: Icon(
                            Icons.edit,
                            size: 25.r,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
              kHeight(50.h),
              ProfilePageWidgets._editProfileTextField(
                title: 'Name',
                hintText: 'Your name',
              ),
              kHeight(20.h),
              ProfilePageWidgets._editProfileTextField(
                title: 'specialization',
                hintText: 'Area of expertise',
              ),
              kHeight(20.h),
              ProfilePageWidgets._editProfileTextField(
                title: 'Email',
                hintText: 'Your email',
              ),
              kHeight(20.h),
              ProfilePageWidgets._editProfileTextField(
                title: 'Mobile No',
                hintText: '+91 9876543210',
              ),
              kHeight(20.h),
              ProfilePageWidgets._editProfileTextField(
                title: 'About',
                hintText: 'About yourself',
                minLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
