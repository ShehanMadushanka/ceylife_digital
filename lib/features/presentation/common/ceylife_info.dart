import 'package:flutter/material.dart';

class CeylifeInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const CeylifeInfo({Key key, this.icon, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: Color(0xDE10111F).withOpacity(0.36),
          border: Border.all(color: Color(0xFF9A6A69), width: 1),
        ),
        child: Wrap(
          runSpacing: 5,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(
                color: Color(0xffE9D2D3),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
