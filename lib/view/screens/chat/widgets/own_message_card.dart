import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key, required this.message, required this.time})
      : super(key: key);
  final String? message;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          color: const Color.fromARGB(255, 216, 216, 216),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(message ?? '',
                    style: GoogleFonts.poppins(
                      textStyle:
                          const TextStyle(fontSize: 14, color: AppColors.black),
                    )),
              ),
              Positioned(
                bottom: 4,
                right: 8,
                child: Text(
                  time ?? '',
                  style: const TextStyle(
                      fontSize: 11.5,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
