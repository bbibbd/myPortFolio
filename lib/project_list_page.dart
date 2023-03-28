import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profiel_widget.dart';
import 'project.dart';
import 'package:intl/intl.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({Key? key}) : super(key: key);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  bool _isLandScape = false;
  String _sortCriteria = '중요도'; // 초기값으로 중요도를 기준으로 정렬
  final Uri _url = Uri.parse('https://github.com/bbibbd');

  Widget buildSortDropdown() {
    return DropdownButton<String>(
      value: _sortCriteria,
      onChanged: (String? value) {
        setState(() {
          _sortCriteria = value!;
        });
      },
      items: <String>['중요도', '시작일']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

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

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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
                _launchUrl();
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
                  Text('Designed by Gibeom Kim'),
                  Text('Address: 장량로114번길 23-8'),
                  Text('Phone: +82 10-6501-6514'),
                  Text('Email: gibeom@handong.ac.kr'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDate(Project project) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.grey,
                size: 12,
              ),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  'Start: ${DateFormat('yyyy. MM. dd').format(project.startDate)}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.grey,
                size: 12,
              ),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  'End: ${DateFormat('yyyy. MM. dd').format(project.endDate)}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGridView(List<Project> projects) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth ~/ 300; // 300은 각 열의 최소 너비

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/projectDetail', arguments: project);
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
                      SizedBox(height: 8),
                      buildDate(project),
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
            Navigator.pushNamed(context, '/projectDetail', arguments: project);
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
                      SizedBox(height: 8),
                      buildDate(project),
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

  String orderBy(String order){
    if(order == "시작일"){
      return "startDate";
    }
    else{
      return order;
    }
  }

  @override
  Widget build(BuildContext context) {
    double paddingValue = 12;
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 320 && screenWidth <= 375) {
      paddingValue = 12;
    } else if (screenWidth > 375 && screenWidth <= 414) {
      paddingValue = 20;
    } else if (screenWidth > 414 && screenWidth <= 480) {
      paddingValue = 28;
    } else if (screenWidth > 480 && screenWidth <= 540) {
      paddingValue = 36;
    } else if (screenWidth > 540 && screenWidth <= 600) {
      paddingValue = 44;
    } else if (screenWidth > 600 && screenWidth <= 720) {
      paddingValue = 52;
    } else if (screenWidth > 720 && screenWidth <= 840) {
      paddingValue = 60;
    } else if (screenWidth > 840 && screenWidth <= 960) {
      paddingValue = 68;
    } else if (screenWidth > 960 && screenWidth <= 1080) {
      paddingValue = 76;
    } else if (screenWidth > 1080) {
      paddingValue = 84;
    }

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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
      drawer: buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.only(left:paddingValue, right: paddingValue, top: 16.0, bottom: 16.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Projects',
                  style: Theme.of(context).textTheme.headline6,
                ),
                buildSortDropdown(),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Projects')
                    .orderBy(orderBy(_sortCriteria), descending: false)
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
                    final List<String> skills = (data['주요기술'] as List<dynamic>)
                        .map((url) => url as String)
                        .toList();

                    return Project(
                      name: data['projectName'] as String,
                      description: data['description'] as String,
                      imageUrl: data['imageUrl'] as String,
                      startDate: (data['startDate'] as Timestamp).toDate(),
                      endDate: (data['endDate'] as Timestamp).toDate(),
                      imageUrls: imageUrls,
                      skills: skills
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
