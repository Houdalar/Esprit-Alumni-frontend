import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/design/app_colors.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key, required this.message, required this.time})
      : super(key: key);
  final String? message;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 50,
                  top: 7,
                  bottom: 13,
                ),
                child: Text(message ?? '',
                    style: GoogleFonts.poppins(
                      textStyle:
                          const TextStyle(fontSize: 14, color: AppColors.black),
                    )),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  time ?? '',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
