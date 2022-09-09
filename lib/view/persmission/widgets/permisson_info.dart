import 'package:flutter/material.dart';
import 'package:flutter_study/data/color_data.dart';

class PermissionInfo extends StatelessWidget {
  final String kind, description;
  final IconData icon;
  const PermissionInfo(
      {super.key,
      required this.kind,
      required this.icon,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Row(
        children: [
          // Icon
          Icon(icon, size: 30),

          //
          const SizedBox(
            width: 20,
          ),
          // kind of permission
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // permission kind
              Text(
                '$kind (필수)',
                style: const TextStyle(fontSize: 14, color: mainTextColor),
              ),

              //
              const SizedBox(
                height: 10,
              ),

              // description
              Text(description,
                  style: const TextStyle(
                      fontSize: 14, color: placeHolderTextColor)),
            ],
          )
        ],
      ),
    );
  }
}
