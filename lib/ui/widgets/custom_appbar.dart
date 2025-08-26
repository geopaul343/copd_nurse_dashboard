import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final List<Color>? gradientColors;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final Color titleColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final double titleLetterSpacing;
  final Color iconColor;
  final double iconSize; final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.elevation = 0,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.titleColor = Colors.white, // #FFFFFF
    this.titleFontSize = 22,
    this.titleFontWeight = FontWeight.w600,
    this.titleLetterSpacing = 0.5,
    this.iconColor = Colors.white, // #FFFFFF
    this.iconSize = 28,this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors ??
                [
                  const Color(0xFF1565C0), // darkBackgroundColor
                  const Color(0xFF0995C8), // darkPrimary
                ],
            begin: gradientBegin,
            end: gradientEnd,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: titleFontSize,
          fontWeight: titleFontWeight,
          letterSpacing: titleLetterSpacing,
        ),
      ),
      iconTheme: IconThemeData(
        color: iconColor,
        size: iconSize,
      ),  actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
// Example usage:
/*
CustomAppBar(
  title: nurse.userName ?? "Nurse Details",
  // Optional overrides:
  elevation: 2,
  gradientColors: [Colors.blue, Colors.purple],
  titleColor: Colors.black,
  titleFontSize: 20,
  iconColor: Colors.grey,
  iconSize: 24,
  actions: [
    IconButton(
      icon: const Icon(
        Icons.add_circle_outline_rounded,
        color: Colors.white, // #FFFFFF
        size: 28,
      ),
      tooltip: 'Add Patient',
      onPressed: () async {
        final result = await Navigator.pushNamed(
          context,
          PatientListToAddNurseScreen.path,
          arguments: nurse,
        );
        if (result == true) {
          callApi();
        }
      },
    ),
  ],
)
*/