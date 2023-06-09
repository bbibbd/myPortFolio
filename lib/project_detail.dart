import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:portfolio/project.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:portfolio/utility.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({Key? key}) : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  bool _isSummary = true;

  @override
  void initState() {
    super.initState();
    _isSummary = true; // 초기값 설정
  }

  Widget buildDate(Project project) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
        SizedBox(width: 16),
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
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  void _showImage(
      BuildContext context, List<String> imageUrls, int initialIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.black54,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: PhotoViewGallery.builder(
                  itemCount: imageUrls.length,
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(imageUrls[index]),
                      initialScale: PhotoViewComputedScale.contained,
                      heroAttributes:
                          PhotoViewHeroAttributes(tag: imageUrls[index]),
                    );
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: BoxDecoration(color: Colors.black54),
                  pageController: PageController(initialPage: initialIndex),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCarouselSlider(BuildContext context, Project project,
      bool isPortrait, double screenHeight) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: CarouselSlider(
        items: project.imageUrls
            .asMap()
            .entries
            .map((entry) => InkWell(
                  onTap: () {
                    _showImage(context, project.imageUrls, entry.key);
                  },
                  child: Image.network(
                    entry.value,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          height: isPortrait ? 200 : screenHeight * 0.30,
          aspectRatio: 16 / 9,
          viewportFraction: 0.5,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget buildSkills(Project project) {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: project.skills.map((skill) {
              return Chip(
                label: Text(skill),
                backgroundColor: Colors.grey[300],
              );
            }).toList(),
          ),
        ],
      );

  }

  Widget buildTitleText(Project project) {
    if (project.category == "대외 활동") {
      return Text(
        "활동내용",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "프로젝트 설명",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Widget buildParagraph(String text, String delimiter) {
    final paragraphs = text.split(delimiter);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var paragraph in paragraphs)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paragraph.trim(),
                    style: TextStyle(fontSize: 22, height: 1.8),
                  ),
                  SizedBox(height: 16),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildBulletParagraph(List<String> texts) {
    final titles = [    "프로젝트 목표",    "사용한 기술",    "문제점 및 어려운점",    "해결 방안",    "결과",    "배우고 느낀점",  ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < titles.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${titles[i]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    texts[i].trim(),
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget buildOutsideBulletParagraph(List<String> texts) {
    final titles = [
      "주체기관",
      "활동목표",
      "활동내용",
      "담당역할",
      "활동성과",
      "배우고 느낀점",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < titles.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${titles[i]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    texts[i].trim(),
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget buildSummary(Project project){

    if(project.category == "대외 활동"){
      return buildOutsideBulletParagraph(project.summary);
    }
    else{
      return buildBulletParagraph(project.summary);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Project project =
        ModalRoute.of(context)!.settings.arguments as Project;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isPortrait = screenHeight > screenWidth;

    double paddingValue = getPaddingValueOfDetailPage(screenWidth);





    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: paddingValue, right: paddingValue, top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildCarouselSlider(context, project, isPortrait, screenHeight),
              SizedBox(height: 10),
              Text(
                project.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                project.category[0],
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              buildDate(project),
              buildSkills(project),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isSummary = true;
                      });
                    },
                    child: Text('요약'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_isSummary ? Colors.grey : null,
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isSummary = false;
                      });
                    },
                    child: Text('자세히'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isSummary ? Colors.grey : null,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(child: Text(
                    "프로젝트 상세 정보를 보시려면 '자세히'를 클릭해주세요.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),)
                ],
              ),
              SizedBox(height: 10),
              _isSummary
                  ? buildSummary(project)
                   : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          "프로젝트 내용",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        buildParagraph(project.description, "\\n\\n"),
                        Text(
                          "배우고 느낀점",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        buildParagraph(project.impression, "\\n\\n"),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
