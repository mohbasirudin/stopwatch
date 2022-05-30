import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stopwatch/base/colors.dart';
import 'package:stopwatch/base/global.dart';

class ButtonCircle extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final Color activeColor;
  final Color inactiveColor;
  final Color? hoverColor;
  final bool enable;

  ButtonCircle({
    required this.onTap,
    required this.icon,
    required this.activeColor,
    required this.inactiveColor,
    required this.enable,
    this.hoverColor,
    Key? key,
  }) : super(key: key);

  final _isHovering = false.obs;
  final _size = 56.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: DataGlobal.isDark.value
                    ? AppColor.itemDark.withOpacity(0.1)
                    : AppColor.itemLight.withOpacity(0.1),
                offset: const Offset(1, 1),
                spreadRadius: 2,
              ),
            ],
          ),
          child: MouseRegion(
            onEnter: enable
                ? (event) => _hovering(
                      value: true,
                    )
                : null,
            onExit: enable
                ? (event) => _hovering(
                      value: false,
                    )
                : null,
            child: ClipOval(
              child: Obx(
                () => Material(
                  color: _isHovering.value
                      ? (hoverColor ??
                          (DataGlobal.isDark.value
                              ? AppColor.itemDark
                              : AppColor.itemLight))
                      : (DataGlobal.isDark.value
                          ? AppColor.dark
                          : AppColor.light),
                  child: InkWell(
                    onTap: enable ? () => onTap() : null,
                    splashColor: DataGlobal.isDark.value
                        ? AppColor.dark
                        : AppColor.light,
                    highlightColor: DataGlobal.isDark.value
                        ? AppColor.dark
                        : AppColor.light,
                    focusColor: DataGlobal.isDark.value
                        ? AppColor.dark
                        : AppColor.light,
                    child: SizedBox(
                      width: _size,
                      height: _size,
                      child: Icon(
                        icon,
                        color: _isHovering.value
                            ? (DataGlobal.isDark.value
                                ? AppColor.itemLight
                                : AppColor.itemDark)
                            : (enable ? activeColor : inactiveColor),
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _hovering({required bool value}) {
    _isHovering.value = value;
  }
}
