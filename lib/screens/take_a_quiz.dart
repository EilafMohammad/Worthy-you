import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = 'QuizScreen';
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final List<String> _questions = [
    "When you feel self-conscious, which of the following aspects do you often focus on the most? (you can select multiple)",
    "How often do you feel anxious about your appearance or social interactions?",
    "Do you find yourself comparing your achievements to others?"
  ];

  final List<List<String>> _options = [
    [
      "My physical appearance",
      "How others perceive me socially",
      "My academic performance or intelligence",
      "My abilities and skills in various areas"
    ],
    [
      "Always",
      "Frequently",
      "Sometimes",
      "Rarely"
    ],
    [
      "Yes, all the time",
      "Sometimes",
      "No, not really"
    ]
  ];

  void _onOptionSelected() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Navigator.pushNamed(context, 'QuizPathScreen');

    }
  }

  double get _progress {
    return (_currentQuestionIndex + 1) / _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            Row(children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);

                },
                child: Image.asset('images/icons/arrowleft.png',
                height: 35,
                  width: 35,
                )
              ),
             const SizedBox(width: 10,),
              const Text(
                "Figuring out the insecurities",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                _questions[_currentQuestionIndex],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),
            const SizedBox(height: 20),
            ..._options[_currentQuestionIndex].map((option) {
              return GestureDetector(
                onTap: _onOptionSelected,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0XFFFFFFFF),
                        border: Border.all(color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          option,
                          style: const TextStyle(
                            color: Color(0XFF8367C7),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: _currentQuestionIndex > 0
                    ? () {
                  setState(() {
                    _currentQuestionIndex--;
                  });
                }
                    : null,
                child: const Text(
                  'back',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0XFF6C717B),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(10),
                value: _progress,
                backgroundColor: Color(0XFFD9D9D9),
                color: Color(0XFF8367C7),
                minHeight: 13,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}



