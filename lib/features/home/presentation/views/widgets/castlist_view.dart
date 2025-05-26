import 'package:flutter/material.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';

class CastView extends StatelessWidget {
  const CastView({
    super.key,
    required this.castlist,
  });

  final cast castlist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2)),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage:
                  NetworkImage(baseimageurl + castlist.profile_path),
            ),
          ),
          const SizedBox(height: 5), // Add some spacing
          SizedBox(
            width: 70, // Adjust width as needed
            child: Text(
              castlist.original_name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
