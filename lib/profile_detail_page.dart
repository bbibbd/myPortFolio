import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'utility.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Detail'),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return buildNarrowLayout(context);
        },
      ),
    );
  }

  Widget buildNarrowLayout(BuildContext context) {
    double paddingValue = 12;
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    paddingValue = getPaddingValue(screenWidth);

    return Padding(
      padding: EdgeInsets.only(
          top: 12, bottom: 12, left: paddingValue, right: paddingValue),
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users')
            .doc('profile')
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('에러가 발생했습니다.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;

          return ListView.builder(
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              switch (index) {
                case 0:
                  return Column(
                    children: [
                      SizedBox(height: 16),
                      buildProfileCard(context, data),
                    ],
                  );
                case 1:
                  return buildIntroduction(context, data);
                case 2:
                  return buildSkills(context, data);
                case 3:
                  return buildAwardList(context, data);
                case 4:
                  return buildExperience(context, data);
                case 5:
                  return buildLabExperience(context, data);
                default:
                  return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }

  void _showProfileImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.black54,
                ),
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.7,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: PhotoView(
                    imageProvider: NetworkImage(
                      imageUrl,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildProfileImage(BuildContext context, String profileImageUrl) {
    return GestureDetector(
      onTap: () {
        _showProfileImage(context, profileImageUrl);
      },
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
          profileImageUrl,
        ),
      ),
    );
  }

  Widget buildProfileCard(BuildContext context, Map<String, dynamic> data) {
    return Card(
      elevation: 8.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 16.0),
          buildProfileImage(context, data['profileImageUrl']),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  data['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  data['email'],
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  data['phone'],
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  data['address'],
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIntroduction(BuildContext context, Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubtitle("자기소개"),
          const SizedBox(height: 8),
          Text(
            data['introduction'],
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
        ],
      ),
    );
  }

  Widget buildSkills(BuildContext context, Map<String, dynamic> data) {
    List<String> skills = List<String>.from(data['skills']);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubtitle('스킬'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (String skill in skills) Chip(label: Text(skill)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildExperience(BuildContext context, Map<String, dynamic> data) {
    List<String> experiences = List<String>.from(data['experiences']);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubtitle('경력'),
          const SizedBox(height: 8),
          for (String experience in experiences) ...[
            Row(
              children: [
                SizedBox(width: 10,),
                Text(
                  "• ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    experience,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }


  Widget buildLabExperience(BuildContext context, Map<String, dynamic> data) {
    List<String> experiences = List<String>.from(data['조교활동']);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubtitle('조교활동'),
          const SizedBox(height: 8),
          for (String experience in experiences) ...[
            Row(
              children: [
                SizedBox(width: 10,),
                Text(
                  "• ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    experience,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }


  Widget buildAwardList(BuildContext context, Map<String, dynamic> data) {
    List<String> experiences = List<String>.from(data['수상내역']);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubtitle('주요성과'),
          const SizedBox(height: 8),
          for (String experience in experiences) ...[
            Row(
              children: [
                SizedBox(width: 10,),
                Text(
                  "• ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    experience,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }

  Text buildSubtitle(String string) {
    return  Text(
        string,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )
    );

  }
}
