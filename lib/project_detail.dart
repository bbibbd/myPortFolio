import 'package:flutter/material.dart';
import 'package:portfolio/project.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Project project =
    ModalRoute.of(context)!.settings.arguments as Project;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isPortrait = screenHeight > screenWidth;

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageStorage(
              bucket: PageStorageBucket(),
              child: CarouselSlider(
                items: project.imageUrls
                    .map((imageUrl) => Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
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
              ),
            ),
            Row(
              children: [
                Text(
                  'Start Date: ',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  '${project.startDate.year}-${project.startDate.month}-${project.startDate.day}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'End Date:  ',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  '${project.endDate.year}-${project.endDate.month}-${project.endDate.day}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  project.description,
                  style: TextStyle(
                    fontSize: 17,
                  )
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
