import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:portfolio/project.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;

    paddingValue = getPaddingValue(screenWidth);

    return Padding(
      padding: EdgeInsets.only(
          top: 12, bottom: 12, left: paddingValue, right: paddingValue),
      child: FutureBuilder<DocumentSnapshot>(
        future:
        FirebaseFirestore.instance.collection('users').doc('profile').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
            itemCount: 7,
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
                case 6:
                  return buildProjectList(context, data);
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
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.8,
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
            style: Theme.of(context).textTheme.titleMedium,
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
          const SizedBox(height: 12),
          for (String experience in experiences) ...[
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
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
            const SizedBox(height: 8),
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
          const SizedBox(height: 12),
          for (String experience in experiences) ...[
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
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
            const SizedBox(height: 8),
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
          const SizedBox(height: 12),
          for (String experience in experiences) ...[
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
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
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Text buildSubtitle(String string) {
    return Text(string,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  }

  String getProjectDurationString(Project project) {
    final startYear = project.startDate.year;
    final endYear = project.endDate.year;
    final startMonth = project.startDate.month;
    final endMonth = project.endDate.month;

    if (startYear == endYear) {
      if (startMonth == endMonth) {
        return '$startYear년 $startMonth월';
      } else {
        return '$startYear년 $startMonth월 ~ $endMonth월';
      }
    } else {
      return '$startYear년 $startMonth월 ~ $endYear년 $endMonth월';
    }
  }

  Widget buildProjectList(BuildContext context, Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubtitle("프로젝트 연혁"),
          SizedBox(height: 8),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Projects')
                .orderBy('startDate', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('에러가 발생했습니다.'),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final projects = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final List<String> imageUrls =
                (data['imageUrls'] as List<dynamic>)
                    .map((url) => url as String)
                    .toList();
                final List<String> skills = (data['주요기술'] as List<dynamic>)
                    .map((skill) => skill as String)
                    .toList();
                final bool isCurrent = data['endDate'] == null;

                return Project(
                    name: data['projectName'] as String,
                    description: data['description'] as String,
                    imageUrl: data['imageUrl'] as String,
                    startDate: (data['startDate'] as Timestamp).toDate(),
                    endDate: isCurrent
                        ? DateTime.now()
                        : (data['endDate'] as Timestamp).toDate(),
                    imageUrls: imageUrls,
                    skills: skills,
                    importance: data['중요도'] as String,
                    category: data['category'] as String,
                    summary: data['summary'] as String,
                    impression: data['느낀점'] as String);

              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: projects
                    .map(
                      (project) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "• ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${DateFormat('yyyy.MM').format(project.startDate)} ~ ${DateFormat('yyyy.MM').format(project.endDate)}: ',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/projectDetail', arguments: project);
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '[${project.category}] ${project.name}',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //const SizedBox(height: 4),
                    ],
                  ),
                )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
