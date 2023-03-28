import 'package:flutter/material.dart';
import 'package:portfolio/project.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (_, index) {
                      return PhotoView(
                        imageProvider: NetworkImage(imageUrls[index]),
                      );
                    },
                    onPageChanged: (index) {},
                    controller: PageController(initialPage: initialIndex),
                  ),
                  Positioned(
                    top: 40,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget buildCarouselSlider(BuildContext context, Project project, bool isPortrait, double screenHeight){
    return PageStorage(
        bucket: PageStorageBucket(),
        child: CarouselSlider(
          items: project.imageUrls
              .map((imageUrl) => GestureDetector(
            onTap: () {
              _showImage(context, project.imageUrls, project.imageUrls.indexOf(imageUrl));
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ))
              .toList(),
          options: CarouselOptions(
            height: isPortrait ? 200 : screenHeight * 0.5,
            aspectRatio: 16 / 9,
            viewportFraction: 0.7,
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
        )
    );
  }

  Widget buildSkills(List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주요 기술',
          style: TextStyle(
            fontSize: 16,
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
    final Project project =
    ModalRoute.of(context)!.settings.arguments as Project;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isPortrait = screenHeight > screenWidth;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCarouselSlider(context, project, isPortrait, screenHeight),
            SizedBox(height: 10),
            Text(
              project.name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            buildDate(project),
            SizedBox(height: 10),
            buildSkills(project.skills),
            SizedBox(height: 10),
            Expanded(
              child: Text(
                project.description,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),


    );
  }
}
