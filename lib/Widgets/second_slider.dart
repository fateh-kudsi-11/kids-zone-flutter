import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/filtering_options.dart';

class SecondSlider extends StatelessWidget {
  const SecondSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final gender = Provider.of<FilteringManger>(context).gender;
    return GestureDetector(
      onTap: () => print('seconad slider taped'),
      child: Container(
        width: double.infinity,
        height: 190,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xffFCE7CC),
              Color(0xffF9DCCD),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(gender == 'boys' ? 'assets/92.png' : 'assets/33.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      gender == 'boys' ? 'BOYS' : 'GIRLS',
                      style: GoogleFonts.antonio(fontSize: 32),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Activewear',
                      style: GoogleFonts.antonio(
                        fontSize: 32,
                        color: const Color(0xffFF9000),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                  gender == 'boys' ? 'assets/223.png' : 'assets/34.png'),
            ],
          ),
        ),
      ),
    );
  }
}
