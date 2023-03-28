import 'package:flutter/material.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Detail'),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return  buildNarrowLayout(context);
        },
      ),
    );
  }

  Widget buildNarrowLayout(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return Column(
              children: [
                SizedBox(height: 16),
                buildProfileCard(context),
              ],
            );
          case 1:
            return buildIntroduction(context);
          case 2:
            return buildSkills(context);
          case 3:
            return buildExperience(context);
          default:
            return SizedBox.shrink();
        }
      },
    );
  }

  Widget buildProfileImage() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/myportfolio-eeeb5.appspot.com/o/profile%2FIMG_3101.JPG?alt=media&token=9585553e-2221-49d0-8648-1c265a5f3472',
      ),
    );
  }

  Widget buildProfileCard(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16.0),
          buildProfileImage(),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Text(
                  '김기범',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                ),
                SizedBox(height: 8.0),
                Text(
                  'gibeom@handong.ac.kr',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '010-6501-6514',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '경북 포항시북구 장량로114번길 24-5',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget buildIntroduction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '자기소개',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          Text(
            '안녕하세요. 저는 Flutter를 좋아하는 개발자 김기범입니다. 새로운 기술에 대한 관심이 많으며, 이를 배우고 적용해 나가는 것을 즐깁니다.',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  Widget buildSkills(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '스킬',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text('C, C++')),
              Chip(label: Text('Python')),
              Chip(label: Text('Java')),
              Chip(label: Text('Linux')),
              Chip(label: Text('ROS')),
              Chip(label: Text('Embedded')),
              Chip(label: Text('Visual SLAM')),
              Chip(label: Text('Deep Learning')),
              Chip(label: Text('Flutter')),
              Chip(label: Text('Dart')),
              Chip(label: Text('Firebase')),
              Chip(label: Text('Git')),
              Chip(label: Text('HTML/CSS')),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildExperience(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '경력',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          Text(
            'Handong Global University, CSE B.S. (2017-2023)',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
