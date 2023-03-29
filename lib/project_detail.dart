import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:portfolio/project.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';


class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({Key? key}) : super(key: key);

  Widget buildDate(Project project){
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
  void _showImage(BuildContext context, List<String> imageUrls, int initialIndex) {
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

  Widget buildCarouselSlider(
      BuildContext context, Project project, bool isPortrait, double screenHeight) {
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
          height: isPortrait ? 200 : screenHeight * 0.38,
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


  Widget buildSkills(List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주요 기술',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: skills.map((skill) {
            return Chip(
              label: Text(skill),
              backgroundColor: Colors.grey[300],
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Project project = ModalRoute.of(context)!.settings.arguments as Project;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isPortrait = screenHeight > screenWidth;

    double paddingValue = 12;
    if (screenWidth > 320 && screenWidth <= 375) {
      paddingValue = 12;
    } else if (screenWidth > 375 && screenWidth <= 414) {
      paddingValue = 24;
    } else if (screenWidth > 414 && screenWidth <= 480) {
      paddingValue = 36;
    } else if (screenWidth > 480 && screenWidth <= 540) {
      paddingValue = 48;
    } else if (screenWidth > 540 && screenWidth <= 600) {
      paddingValue = 60;
    } else if (screenWidth > 600 && screenWidth <= 720) {
      paddingValue = 72;
    } else if (screenWidth > 720 && screenWidth <= 840) {
      paddingValue = 84;
    } else if (screenWidth > 840 && screenWidth <= 960) {
      paddingValue = 96;
    } else if (screenWidth > 960 && screenWidth <= 1080) {
      paddingValue = 108;
    } else if (screenWidth > 1080) {
      paddingValue = 120;
    }

    Widget buildParagraph(String text, String delimiter) {
      final paragraphs = text.split(delimiter);
      final widgets = <Widget>[];

      for (int i = 0; i < paragraphs.length; i++) {
        final paragraph = paragraphs[i];
        widgets.add(Text(
          paragraph.trim(),
          style: TextStyle(fontSize: 20),
        ));
        if (i != paragraphs.length - 1) {
          widgets.add(SizedBox(height: 10));
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: paddingValue, right: paddingValue, top: 16, bottom: 16),
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
              buildDate(project),
              SizedBox(height: 10),
              buildSkills(project.skills),
              SizedBox(height: 10),
              Text(
                "프로젝트 설명",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              buildParagraph(project.description, "\\n\\n"),
              SizedBox(height: 10),
              Text(
                "배우고 느낀점",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              buildParagraph(project.impression, "\\n\\n"),
            ],
          ),
        ),
      ),
    );
  }


}
