import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black54.withOpacity(.5),
                  size: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   color: Colors.black54.withOpacity(.4),
            //   size: 16,
            // )
          ],
        ),
      ),
    );
  }
}
