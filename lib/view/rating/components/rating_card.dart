// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/common/colors.dart';
import 'package:flutter_study/model/restaurant/rating_model.dart';

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

  factory RatingCard.fromModel({required RatingModel model}) {
    return RatingCard(
      avatarImage: NetworkImage(model.user.imageUrl),
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
      rating: model.rating,
      email: model.user.username,
      content: model.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        header(),
        const SizedBox(height: 8),
        body(),
        if (images.isNotEmpty) SizedBox(height: 100, child: imagesWidget()),
        const Divider()
      ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        content,
        style: const TextStyle(
          color: bodyTextColor,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget imagesWidget() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          .mapIndexed(
            (index, element) => Padding(
              padding: EdgeInsets.only(right: index == images.length ? 0 : 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: element,
              ),
            ),
          )
          .toList(),
    );
  }
}
