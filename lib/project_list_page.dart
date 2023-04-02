import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profiel_widget.dart';
import 'project.dart';
import 'package:intl/intl.dart';
import 'utility.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({Key? key}) : super(key: key);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  bool _isLandScape = false;
  String _sortCriteria = '중요도'; // 초기값으로 중요도를 기준으로 정렬
  final Uri _github = Uri.parse('https://github.com/bbibbd');
  final Uri _instagram = Uri.parse('https://www.instagram.com/key_0312/');
  final Uri _tistory = Uri.parse('https://musit.tistory.com/');
  final Uri _kakaotalk =
      Uri.parse('qr.kakao.com/talk/sX6zLpJvLBbDoOHw9yNUzYMfLUk-');
  String _password = '';
  String _selectedCategory = '전체';

  Widget buildProjectSummary(List<String> summary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle_outlined,
              color: Colors.grey,
              size: 12,
            ),
            SizedBox(width: 4),
            Expanded(child: Text(
              summary[0],
              style: TextStyle(
                height: 1.5,
                fontSize: 15,
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),)
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.circle_outlined,
              color: Colors.grey,
              size: 12,
            ),
            SizedBox(width: 4),
            Expanded(
              child:Text(
                summary[4],
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

          ],
        ),
      ],
    );
  }

  Widget buildSortDropdown() {
    return DropdownButton<String>(
      value: _sortCriteria,
      onChanged: (String? value) {
        setState(() {
          _sortCriteria = value!;
        });
      },
      items:
          <String>['중요도', '시작일'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildCategoryDropdown() {
    return DropdownButton<String>(
      value: _selectedCategory,
      onChanged: (String? value) {
        setState(() {
          _selectedCategory = value!;
        });
      },
      items: <String>['전체', '대표 프로젝트', '졸업 연구', '산학 연구', '수업 프로젝트', '학회 활동', '대외 활동']
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

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('김기범', style: TextStyle(fontSize: 18.0)),
              accountEmail: const Text('gibeom@handong.ac.kr'),
              currentAccountPicture: const CircleAvatar(
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
            // ListTile(
            //   title: Text('GitHub', style: TextStyle(fontSize: 16.0)),
            //   leading: Icon(Icons.code),
            //   onTap: () {
            //     _launchUrl(_github);
            //   },
            // ),
            // ListTile(
            //   title: Text('Instagram', style: TextStyle(fontSize: 16.0)),
            //   leading: Icon(Icons.chat),
            //   onTap: () {
            //     _launchUrl(_instagram);
            //   },
            // ),
            // ListTile(
            //   title: Text('Tistory', style: TextStyle(fontSize: 16.0)),
            //   leading: Icon(Icons.chat),
            //   onTap: () {
            //     _launchUrl(_tistory);
            //   },
            // ),
            // ListTile(
            //   title: Text('Kakao', style: TextStyle(fontSize: 16.0)),
            //   leading: Icon(Icons.chat),
            //   onTap: () {
            //     _launchUrl(_kakaotalk);
            //   },
            // ),
            // ListTile(
            //   title: Text('글쓰기', style: TextStyle(fontSize: 16.0)),
            //   leading: Icon(Icons.edit),
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //           title: Text('암호 입력'),
            //           content: TextFormField(
            //             obscureText: true,
            //             decoration: InputDecoration(
            //               hintText: '암호를 입력하세요.',
            //             ),
            //             onChanged: (value) {
            //               _password = value;
            //             },
            //           ),
            //           actions: <Widget>[
            //             TextButton(
            //               child: Text('취소'),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               },
            //             ),
            //             TextButton(
            //               child: Text('확인'),
            //               onPressed: () {
            //                 if (_password == 'dslove1109') {
            //                   // 암호가 맞는 경우
            //                   Navigator.pushNamed(context, '/upload');
            //                 } else {
            //                   // 암호가 틀린 경우
            //                   showDialog(
            //                     context: context,
            //                     builder: (BuildContext context) {
            //                       return AlertDialog(
            //                         title: Text('암호가 틀렸습니다.'),
            //                         actions: <Widget>[
            //                           TextButton(
            //                             child: Text('확인'),
            //                             onPressed: () {
            //                               Navigator.of(context).pop();
            //                             },
            //                           ),
            //                         ],
            //                       );
            //                     },
            //                   );
            //                 }
            //               },
            //             ),
            //           ],
            //         );
            //       },
            //     );
            //   },
            // ),
            // Divider(),
            SizedBox(height: 10,),
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
      children: [
        Icon(
          Icons.calendar_today,
          color: Colors.grey,
          size: 12,
        ),
        SizedBox(width: 4),
        Text(
          'Start: ${DateFormat('yyyy. MM. dd').format(project.startDate)}',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 4),
        Icon(
          Icons.calendar_today,
          color: Colors.grey,
          size: 12,
        ),
        SizedBox(width: 4),
        Text(
          'End: ${DateFormat('yyyy. MM. dd').format(project.endDate)}',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget buildListView(List<Project> projects) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = constraints.maxWidth;
        final isWideScreen = screenWidth >= 960;

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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: isWideScreen ? screenWidth * 0.3 : screenWidth * 0.4,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(project.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Text(
                              project.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            buildProjectSummary(project.summary),
                            SizedBox(height: 8),
                            buildDate(project),
                            SizedBox(height: 8),
                            Wrap(
                              spacing: 4,
                              children: project.skills
                                  .take(3)
                                  .map((skill) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    "# $skill",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }




  String orderBy(String order) {
    if (order == "시작일") {
      return "startDate";
    } else {
      return order;
    }
  }

  Widget buildProfileWidget() {
    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('users').doc('profile').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
          introduction: data['shortIntroduction'],
        );
      },
    );
  }

  Widget buildProjectList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          216, // 216 is the estimated height of the header and footer
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Projects').orderBy('중요도', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Project> projects = [];

          // Filter projects by category
          if (_selectedCategory == '전체') {
            // Show all projects
            projects = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final List<String> imageUrls =
                  (data['imageUrls'] as List<dynamic>)
                      .map((url) => url as String)
                      .toList();
              final List<String> skills = (data['주요기술'] as List<dynamic>)
                  .map((url) => url as String)
                  .toList();
              final List<String> summary = (data['summary'] as List<dynamic>)
                  .map((skill) => skill as String)
                  .toList();

              return Project(
                name: data['projectName'] as String,
                description: data['description'] as String,
                imageUrl: data['imageUrl'] as String,
                startDate: (data['startDate'] as Timestamp).toDate(),
                endDate: (data['endDate'] as Timestamp).toDate(),
                imageUrls: imageUrls,
                skills: skills,
                impression: data['느낀점'] as String,
                importance: data['중요도'] as String,
                category: data['category'] as String,
                summary: summary,
              );
            }).toList();
          } else if(_selectedCategory == '대표 프로젝트'){
            projects = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final List<String> imageUrls =
              (data['imageUrls'] as List<dynamic>)
                  .map((url) => url as String)
                  .toList();
              final List<String> skills = (data['주요기술'] as List<dynamic>)
                  .map((url) => url as String)
                  .toList();
              final List<String> summary = (data['summary'] as List<dynamic>)
                  .map((skill) => skill as String)
                  .toList();
              if (data['대표'] == true){
                return Project(
                  name: data['projectName'] as String,
                  description: data['description'] as String,
                  imageUrl: data['imageUrl'] as String,
                  startDate: (data['startDate'] as Timestamp).toDate(),
                  endDate: (data['endDate'] as Timestamp).toDate(),
                  imageUrls: imageUrls,
                  skills: skills,
                  impression: data['느낀점'] as String,
                  importance: data['중요도'] as String,
                  category: data['category'] as String,
                  summary:  summary,
                );
              }else {
                return null;
              }
            }) .where((p) => p != null)
                .toList()
                .cast<
                Project>(); // Add this line to cast the list to List<Projec
          }
          else {
            // Filter projects by category
            projects = snapshot.data!.docs
                .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final List<String> imageUrls =
              (data['imageUrls'] as List<dynamic>)
                  .map((url) => url as String)
                  .toList();
              final List<String> skills = (data['주요기술'] as List<dynamic>)
                  .map((url) => url as String)
                  .toList();
              final List<String> summary = (data['summary'] as List<dynamic>)
                  .map((skill) => skill as String)
                  .toList();
              if (data['category'] == _selectedCategory) {
                return Project(
                  name: data['projectName'] as String,
                  description: data['description'] as String,
                  imageUrl: data['imageUrl'] as String,
                  startDate: (data['startDate'] as Timestamp).toDate(),
                  endDate: (data['endDate'] as Timestamp).toDate(),
                  imageUrls: imageUrls,
                  skills: skills,
                  impression: data['느낀점'] as String,
                  importance: data['중요도'] as String,
                  category: data['category'] as String,
                  summary: summary,
                );
              } else {
                return null;
              }
            })
                .where((p) => p != null)
                .toList()
                .cast<
                Project>(); // Add this line to cast the list to List<Project>
          }
            return buildListView(projects);
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('프로젝트 목록'),
      leading: null,
      // leading: Builder(
      //   builder: (BuildContext context) {
      //     return IconButton(
      //       icon: const Icon(Icons.menu),
      //       onPressed: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //     );
      //   },
      // ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('암호 입력'),
                  content: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '암호를 입력하세요.',
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('취소'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('확인'),
                      onPressed: () {
                        if (_password == 'dslove1109') {
                          // 암호가 맞는 경우
                          Navigator.pushNamed(context, '/upload');
                        } else {
                          // 암호가 틀린 경우
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('암호가 틀렸습니다.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('확인'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double paddingValue = 12;
    final double screenWidth = MediaQuery.of(context).size.width;

    paddingValue = getPaddingValue(screenWidth);

    return Scaffold(
      appBar: buildAppBar(),
      //drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: paddingValue, right: paddingValue, top: 16.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //buildProfileWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '카테고리',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 10,),
                  buildCategoryDropdown(),
                ],
              ),
              SizedBox(height: 16),
              buildProjectList(),
            ],
          ),
        ),
      ),
    );
  }
}
