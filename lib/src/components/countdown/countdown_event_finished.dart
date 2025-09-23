import 'package:flutter/material.dart';

class CountdownEventFinished extends StatelessWidget {
  const CountdownEventFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: ShapeDecoration(
        color: const Color(0x198C8C8C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 20,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 2,
        children: [
          SizedBox(
            width: 148,
            child: Text(
              'Felizmente casados',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white /* Text-Labels-labelAlwaysWhite */,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.31,
                letterSpacing: -0.01,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '09',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white /* Text-Labels-labelAlwaysWhite */,
                        fontSize: 23,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.26,
                        letterSpacing: -0.02,
                      ),
                    ),
                    Text(
                      'Años',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white /* Text-Labels-labelAlwaysWhite */,
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.27,
                        letterSpacing: 0.01,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 35,
                      child: Text(
                        '12',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white /* Text-Labels-labelAlwaysWhite */,
                          fontSize: 23,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 1.26,
                          letterSpacing: -0.02,
                        ),
                      ),
                    ),
                    Text(
                      'Meses',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white /* Text-Labels-labelAlwaysWhite */,
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.27,
                        letterSpacing: 0.01,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '19',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white /* Text-Labels-labelAlwaysWhite */,
                        fontSize: 23,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.26,
                        letterSpacing: -0.02,
                      ),
                    ),
                    Text(
                      'Días',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white /* Text-Labels-labelAlwaysWhite */,
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.27,
                        letterSpacing: 0.01,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
