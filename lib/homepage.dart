import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfilePictureWidget(
                  imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/myportfolio-eeeb5.appspot.com/o/profile%2FIMG_3101.JPG?alt=media&token=9585553e-2221-49d0-8648-1c265a5f3472',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Welcome to My Portfolio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Here, you can find a brief overview of the projects that I have worked on.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/projectList',
                      arguments: {'title': 'My Projects'},
                    );
                  },
                  child: Text(
                    'View Projects',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ProfilePictureWidget extends StatelessWidget {
  final String imageUrl;

  ProfilePictureWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profileImage',
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}
