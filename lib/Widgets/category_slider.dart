import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySlider extends StatelessWidget {
  final String image;
  final String title;
  const CategorySlider({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 245,
      child: Stack(
        children: [
          Image.asset(image),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.black.withOpacity(0.4),
                height: 40,
                //padding: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.antonio(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
