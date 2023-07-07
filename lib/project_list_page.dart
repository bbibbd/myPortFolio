import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  String _password = '';
  String _selectedCategory = '전체';

  String getSortedValue(String sortedCriteria){
    if(sortedCriteria == '최신순') {
      return 'startDate';
    } else{
      return '중요도';
    }
  }

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
            Expanded(
              child: Text(
                summary[0],
                style: TextStyle(
                  height: 1.5,
                  fontSize: 15,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
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
              child: Text(
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
          <String>['기본', '최신순'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: getSortedValue(value),
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
      items: <String>['전체', '대표 프로젝트', '자율주행', '임베디드', '딥러닝', 'SLAM']
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
    if (mediaQuery.size.width > 730) {
      setState(() {
        _isLandScape = true;
      });
    } else {
      setState(() {
        _isLandScape = false;
      });
    }
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

  Widget buildNarrowListView(List<Project> projects) {
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
                Navigator.pushNamed(context, '/projectDetail',
                    arguments: project);
              },
              child: Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: isWideScreen ? 350 : 180,
                      child: Image.network(
                        project.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else if (loadingProgress.expectedTotalBytes != null) {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!,
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),

                    ),

                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
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
                            project.category[0],
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
                  ],
                ),
              ),
            );
          },
        );
      },
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
                Navigator.pushNamed(context, '/projectDetail',
                    arguments: project);
              },
              child: Card(
                elevation: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.3,
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
                        padding: const EdgeInsets.all(
                          16,
                        ),
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
                              project.category[0],
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
                                          borderRadius:
                                              BorderRadius.circular(7),
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
      height: MediaQuery.of(context).size.height - 180,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Projects')
            .orderBy(_sortCriteria, descending: _sortCriteria == 'startDate' ? true : false)
            .snapshots(),
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
              final List<String> category = (data['category'] as List<dynamic>)
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
                category: category,
                summary: summary,
              );
            }).toList();
          } else if (_selectedCategory == '대표 프로젝트') {
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
                  final List<String> summary =
                      (data['summary'] as List<dynamic>)
                          .map((skill) => skill as String)
                          .toList();
                  final List<String> category =
                  (data['category'] as List<dynamic>)
                      .map((skill) => skill as String)
                      .toList();
                  if (data['대표'] == true) {
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
                      category: category,
                      summary: summary,
                    );
                  } else {
                    return null;
                  }
                })
                .where((p) => p != null)
                .toList()
                .cast<Project>();
          } else {
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
                  final List<String> summary =
                      (data['summary'] as List<dynamic>)
                          .map((skill) => skill as String)
                          .toList();
                  final List<String> category = (data['category'] as List<dynamic>)
                      .map((url) => url as String)
                      .toList();
                  if (data['category'].contains(_selectedCategory)) {
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
                      category: category,
                      summary: summary,
                    );
                  } else {
                    return null;
                  }
                })
                .where((p) => p != null)
                .toList()
                .cast<Project>();
          }
          return _isLandScape
              ? buildListView(projects)
              : buildNarrowListView(projects);
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

    paddingValue = getPaddingValueOfDetailPage(screenWidth);

    return Scaffold(
      appBar: buildAppBar(),
      //drawer: buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.only(
          left: paddingValue,
          right: paddingValue,
          top: 16.0,
        ),
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
                SizedBox(
                  width: 10,
                ),
                buildCategoryDropdown(),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '정렬',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                buildSortDropdown(),
              ],
            ),
            SizedBox(height: 16),
            buildProjectList(),
          ],
        ),
      ),
    );
  }
}
