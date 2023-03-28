import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profiel_widget.dart';
import 'project.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({Key? key}) : super(key: key);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  bool _isLandScape = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkOrientation();
  }

  void _checkOrientation() {
    final mediaQuery = MediaQuery.of(context);
    if (mediaQuery.orientation == Orientation.landscape) {
      setState(() {
        _isLandScape = true;
      });
    } else {
      setState(() {
        _isLandScape = false;
      });
    }
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('김기범', style: TextStyle(fontSize: 18.0)),
              accountEmail: Text('gibeom@handong.ac.kr'),
              currentAccountPicture: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/myportfolio-eeeb5.appspot.com/o/profile%2FIMG_3101.JPG?alt=media&token=9585553e-2221-49d0-8648-1c265a5f3472',
                ), // default image URL
              ),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              title: Text('GitHub', style: TextStyle(fontSize: 16.0)),
              leading: Icon(Icons.code),
              onTap: () {
                launch('https://github.com/bbibbd');
              },
            ),
            ListTile(
              title: Text('Write a Post', style: TextStyle(fontSize: 16.0)),
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.pushNamed(context, '/upload');
              },
            ),
            Divider(),
            SizedBox(height: MediaQuery.of(context).size.height / 2),
            ListTile(
              title: Text('Contact', style: TextStyle(fontSize: 16.0)),
              leading: Icon(Icons.contact_mail),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(''),
                  Text('Address: '),
                  Text('Phone: 555-555-5555'),
                  Text('Email: youremail@example.com'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildGridView(List<Project> projects) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/projectDetail',
                arguments: project);
          },
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(project.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        project.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget buildListView(List<Project> projects) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/projectDetail',
                arguments: project);
          },
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(project.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        project.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Portfolio'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc('profile')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('에러가 발생했습니다.'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;

                return ProfileWidget(
                  name: data['name'],
                  imageUrl: data['profileImageUrl'],
                  introduction: data['introduction'],
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              'Projects',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Projects')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final projects = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final List<String> imageUrls =
                        (data['imageUrls'] as List<dynamic>)
                            .map((url) => url as String)
                            .toList();
                    return Project(
                      name: data['projectName'] as String,
                      description: data['description'] as String,
                      imageUrl: data['imageUrl'] as String,
                      startDate: (data['startDate'] as Timestamp).toDate(),
                      endDate: (data['endDate'] as Timestamp).toDate(),
                      imageUrls: imageUrls,
                    );
                  }).toList();

                  if (_isLandScape) {
                    return buildGridView(projects);
                  } else {
                    return buildListView(projects);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
