
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utill/Text.base.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class ExceptionAlert extends StatelessWidget {
  static bool isDialogOpen = false;
  final String text;
  final String image;
  String? textBtn;

  ExceptionAlert(
      {Key? key, required this.image, required this.text, this.textBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlurryContainer(
        blur: 2.5,
        width: double.infinity,
        height: double.infinity,
        elevation: 0,
        color: ColorResources.overlay_gray.withOpacity(.1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Center(
          child: Container(
            height: 400,
            width: 400,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          SvgPicture.asset(
                            image,
                            width: 150,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "Oops ...",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextBase(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorResources.black.withOpacity(.3)),
                          ),
                        ],
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonBase.defaultBtn("Submit", onTap: () {
                            backNested(
                              id: 0,
                            );
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    backNested(id: 0, result: {"event": "close"});
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.white,
                    ),
                    child: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

backNested<T>(
    {T? result,
      bool closeOverlays = true,
      bool canPop = true,
      int? id,
      bool? backAll = false}) {
  if (backAll == false) {
    Get.back(
      result: result,
      closeOverlays: closeOverlays,
      canPop: canPop,
      id: id,
    );
  } else {
    while (Get.global(id).currentState?.canPop() == true) {
      Get.back(
        result: result,
        closeOverlays: closeOverlays,
        canPop: canPop,
        id: id,
      );
    }
  }
}

class ButtonBase {
  static Widget defaultBtn(
      String title, {
        double? width,
        double? height,
        String? icon,
        Color? colorBtn,
        Color? colorText,
        void Function()? onTap,
        BoxBorder? border,
      }) {
    Color color1 = colorText ?? ColorResources.gray_1;
    Color color2 = colorBtn ?? ColorResources.colorPrimary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
          horizontal: Dimensions.PADDING_SIZE_SMALL,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color2,
          border: border,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              SizedBox(
                width: 15,
                height: 15,
                child: SvgPicture.asset(
                  icon,
                  matchTextDirection: true,
                  color: color1,
                ),
              ),
            if (icon != null)
              const SizedBox(
                width: Dimensions.PADDING_SIZE_SMALL,
              ),
            TextBase(
              title,
              style: TextStyle(color: color1),
            ),
          ],
        ),
      ),
    );
  }
}
