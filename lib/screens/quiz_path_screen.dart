import 'package:flutter/material.dart';
import 'package:worthy_you/screens/path_affirmation_categories_screen.dart';

class QuizPathScreen extends StatelessWidget {
  static const routeName = 'QuizPathScreen';

  const QuizPathScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFDFF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   // SizedBox(height: 20),
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);

                        },
                        child: Image.asset('images/icons/arrowleft.png',
                          height: 35,
                          width: 35,
                        )
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Great job on completing the quiz!\nHere’s a snapshot of your insecurities:',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('0.0'),
                              Text('0.2'),
                              Text('0.4'),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInsecurityItem('Career Competence', '0'),
                              const SizedBox(height: 20,),
                              _buildInsecurityItem('Social Acceptance', '0'),
                              const SizedBox(height: 20,),
                              _buildInsecurityItem('Appearance', '0'),
                              const SizedBox(height: 20,),
                              _buildInsecurityItem('Academic Performance', '0'),
                              const SizedBox(height: 20,),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 120),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xff6DD3CE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Next Step\nListen to Personalized Affirmations: '
                            'Tailored to address your specific insecurities.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(
                                size: 40,
                                Icons.arrow_circle_right_outlined, color: Colors.grey),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) =>
                                   AffirmationCategoriesScreen(),),);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInsecurityItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 20,),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}


