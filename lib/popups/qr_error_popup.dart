import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto/utils/sized_margins.dart';

showErrorDialog(BuildContext context, {String? error}) => showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: SizedBox(
          width: screenWidth(context, percent: 0.6),
          height: screenHeight(context, percent: 0.3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Error",
                  style: GoogleFonts.nunito(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                const YMargin(10),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    error ?? ' ',
                    style: GoogleFonts.nunito(
                        color: Colors.grey[500],
                        fontSize: 13,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                const YMargin(20),
              ],
            ),
          ),
        ),
      );
    });
showSuccessDialog(BuildContext context, {String? result}) =>
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: SizedBox(
              width: screenWidth(context, percent: 0.6),
              height: screenHeight(context, percent: 0.3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Was Able to scan the following",
                      style: GoogleFonts.nunito(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    const YMargin(10),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "$result",
                        style: GoogleFonts.nunito(
                            color: Colors.grey[500],
                            fontSize: 13,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    const YMargin(20),
                  ],
                ),
              ),
            ),
          );
        });
