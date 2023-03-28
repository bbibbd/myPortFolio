import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String introduction;

  ProfileWidget({
    required this.name,
    required this.imageUrl,
    required this.introduction,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Hero(
              tag: 'profileImage',
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  Text(
                    introduction,
                    style: Theme.of(context).textTheme.subtitle1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profileDetail');
              },
              icon: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Theme.of(context).primaryColor,
                size: 24.0,
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
