import 'package:flutter/material.dart';
import 'utility.dart';

class IntroductionDetailPage extends StatelessWidget {
  static const String routeName = '/introduction-detail';

  final List<String> titles = [
    '전공에 기반하여 본인을 소개하라',
    '가장 의미 있었던 프로젝트 수행 경험과 이로 인한 영향을 작성하라.',
    '지원한 직업(직무)에 대한 자신의 포부와 비전을 작성하라.',
    '당신의 강점을 구체적 사례를 들어 설명하라',
    '당신의 약점을 구체적 사례를 들어 설명하라.',
    '전공 관련 경험이 아닌 내용으로 자신이 어떤 사람인지 경험에 기반하여 표현하라.',
    '당신은 어떤 가치관을 가진 사람인지 설명하라.',
    '변화와 유연성이 필요하다”는 요구에 대해 당신의 생각을 경험에 비추어 설명하라.',
  ];

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    double paddingValue = 12;
    final double screenWidth = MediaQuery.of(context).size.width;

    paddingValue = getPaddingValue(screenWidth);

    return Scaffold(
      appBar: AppBar(
        title: Text('자기소개 전문'),
      ),
      body:
      Padding(
        padding: EdgeInsets.only(left: paddingValue, right: paddingValue),
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            final title = titles[index];
            final answer = data['full_introduction'][index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. $title',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        answer,
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
