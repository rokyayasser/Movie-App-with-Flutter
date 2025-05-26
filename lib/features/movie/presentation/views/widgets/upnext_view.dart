import 'package:flutter/material.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/home/presentation/views/widgets/overviewscreen.dart';

class UpNextView extends StatelessWidget {
  const UpNextView({
    super.key,
    required this.upnextlist,
  });

  final movies upnextlist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OverViewScreen(
                    movie: upnextlist,
                  ),
                )),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(baseimageurl + upnextlist.poster_path),
                  fit: BoxFit.cover,
                ),
              ),
              height: 150,
              width: 100,
            ),
          ),
          const SizedBox(height: 5), // Add some spacing
          SizedBox(
            width: 70, // Adjust width as needed
            child: Text(
              upnextlist.title,
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
