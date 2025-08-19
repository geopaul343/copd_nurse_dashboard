import 'package:admin_dashboard/app/style_guide/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';


class SubmitButton extends StatefulWidget {
  const SubmitButton(
      this.title, {
        super.key,
        this.onTap,
        this.padding = 9,
        this.backgroundColor = ColorName.buttonBackground,
        this.textColor = Colors.white,
        this.overlayColor = Colors.white,
        this.textStyle,
        this.borderColor,
        this.radius,
        this.suffix,
        this.hasGradient = true,
        this.disabled = false
      });

  const SubmitButton.primary(
      this.title, {
        super.key,
        this.onTap,
        this.padding = 14,
        this.backgroundColor = ColorName.buttonBackground,
        this.textColor = Colors.white,
        this.overlayColor = Colors.white,
        this.textStyle,
        this.borderColor,
        this.radius,
        this.suffix,
        this.hasGradient = true,
        this.disabled = false,
      });

  const SubmitButton.delete({
    this.title = 'Delete',
    super.key,
    this.onTap,
    this.padding = 9,
    this.backgroundColor = ColorName.border,
    this.overlayColor = Colors.red,
    this.textStyle,
    this.textColor = Colors.red,
    this.borderColor,
    this.radius,
    this.suffix,
    this.hasGradient = true,
    this.disabled = false
  });

  final LoadingChanged<VoidCallback>? onTap;
  final String title;
  final double padding;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? radius;
  final Widget? suffix;
  final Color backgroundColor;
  final Color overlayColor;
  final TextStyle? textStyle;
  final bool? hasGradient;
  final bool disabled;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton>
    with TickerProviderStateMixin {
  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap == null
          ? null
          : () => widget.onTap!(() {
        setState(() {
          showLoader = !showLoader;
        });
      }),
      child: Container(
        // padding: EdgeInsets.symmetric(vertical:9),
        height: 52,
        decoration: BoxDecoration(
          color: widget.disabled?ColorName.buttonBackgroundDisable:widget.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          // gradient: widget.hasGradient == true
          //     ? const LinearGradient(
          //         colors: [
          //           ColorName.gradientButtonStart,
          //           ColorName.gradientButtonEnd
          //         ],
          //       )
          //     : null,
        ),
        child: showLoader
            ? SpinKitCircle(
          color: Colors.white,
          size: 25.0 - widget.padding / 2.5,
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.suffix != null) ...[widget.suffix!, gap],
            Expanded(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,

                style: (widget.textStyle ?? button).copyWith(
                  color: widget.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


typedef LoadingChanged<T> = void Function(T loaderSwitch);