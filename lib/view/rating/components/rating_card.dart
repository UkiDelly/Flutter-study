import 'package:flutter/material.dart';
import 'package:flutter_study/common/colors.dart';

class RatingCard extends StatelessWidget {
  // Network Image
  // Asset Image
  final ImageProvider avatarImage;
  final List<Image> images;
  final int rating;
  final String email;
  final String content;

  const RatingCard({
    super.key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [header(), body(), imagesWidget()],
    );
  }

  Widget header() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: avatarImage,
          radius: 12,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style:
                const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_outline,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget body() {
    return Container();
  }

  Widget imagesWidget() {
    return Container();
  }
}
