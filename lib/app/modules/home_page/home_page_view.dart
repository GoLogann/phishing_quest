import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:phishing_quest/app/modules/home_page/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá, Logan',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        CircleAvatar(
                          radius: 30
                       ),
                    ],
                                    ),
                  ),
                SizedBox(height: 20),
                 Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          value: 0.0, // Valor do progresso
                          strokeWidth: 8,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Vamos começar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Complete os desafios e avance em conhecimento',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                SizedBox(height: 20),
                // Desafios
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ChallengeCard('Phishing Challenge', 'assets/flutter_logo.png'),
                    ChallengeCard('Engenharia Social', 'assets/react_logo.png'),
                    ChallengeCard('Phishing Quizz', 'assets/csharp_logo.png'),
                    ChallengeCard('Golpes Virtuais', 'assets/python_logo.png'),
                  ],
                ),
              ],
            
            ),
          ),
          
        )
      )
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final String title;
  final String assetPath;

  ChallengeCard(this.title, this.assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('0 de 10', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}