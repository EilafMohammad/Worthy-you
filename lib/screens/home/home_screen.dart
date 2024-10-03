import 'package:flutter/material.dart';
import 'package:worthy_you/screens/home/main_screen.dart';
import 'package:worthy_you/screens/quiz/affirmation_categories_screen.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

import '../../helpers/meditation_button.dart';
import '../../helpers/meditation_card.dart';
import '../my_affirmations_screen.dart';
import '../quiz/saved_affirmation_screen.dart';
import '../subscription_screen.dart';

class HomeScreen extends StatefulWidget {
  static const tag = '/home_screen';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Default to the Main screen

  final List<Widget> _screens = [
    const SavedAffirmationScreen(),
    const MainScreen(), // Main Screen
    const SubscriptionScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => _screens[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: _screens[_selectedIndex],
        bottomNavigationBar: _selectedIndex == 1
            ? Container(
                decoration: const BoxDecoration(
                  color: MyColors.backgroundColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: MyColors.colorBlack,
                      blurRadius: 2.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        size: 25,
                        AssetImage('images/icons/investment 1.png'),
                      ),
                      label: Constants.labelMyAffirmations,
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        size: 22,
                        AssetImage('images/icons/home 1.png'),
                      ),
                      label: Constants.labelMain,
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        size: 25,
                        AssetImage('images/icons/Money.png'),
                      ),
                      label: Constants.labelSubscriptions,
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.black,
                  unselectedLabelStyle: Styles.textStyle.copyWith(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  selectedLabelStyle: Styles.textStyle.copyWith(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  onTap: _onItemTapped,
                ),
              )
            : null, // Hide bottom bar on other screens
      ),
    );
  }

}

class DesignScreen extends StatelessWidget {
  const DesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 90,
               // color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        const Stack(
                          children: [

                            Positioned(
                              left:160,top: -5,
                              child: SizedBox(
                                height: 30,
                              width: 30,
                                child: Image(
                                  image: AssetImage('images/diamond.png'),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Image(
                              height: 40,
                                width: 200,
                                image: AssetImage('images/topframe.png')),
                          ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35,left: 60),
                              child: Text(
                                'Welcome, Eliaf!',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),


                          ],
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, 'AudioPlayScreen');
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage('images/profile.png'),
                                    ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     'Welcome, Eliaf!',
            //     style: TextStyle(
            //         fontSize: 20,
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold
            //     ),
            //   ),
            // ),
            //const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Crafting your Personalized affirmations',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
SizedBox(height: 10,),
////////////////////////////////////   take a general quiz Container start here ///////////////
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, 'QuizScreen');
              },
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                      image: AssetImage('images/take_a_general_quiz.png',

                      )

                  ),
                  // gradient: const LinearGradient(
                  //   colors: [Color(0xFFdcbcf9), Color(0xFFffb5e8)],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
           // const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
              child: Text(
                'Meditation paths for you',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
           // const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildMeditationButton( title: 'Appearance', onPressed: () { Navigator.pushNamed(context, 'AppearanceScreen'); }),
                  buildMeditationButton(title: 'Academic Performance', onPressed: () {  }),
                  buildMeditationButton(title: 'Acceptance', onPressed: () {  }),
                  buildMeditationButton(title: 'Competence', onPressed: () {  }),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                buildMeditationCard('Echo (venting bot)', 'images/echo.jpg', (){Navigator.pushNamed(context, 'VentingBotScreen1');}),
                const SizedBox(width: 10),
                buildMeditationCard(
                    'Book a session', 'images/book_a_session.png',(){}),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.maxFinite,
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/creative_visualization.png')
                ),
                // gradient: const LinearGradient(
                //   colors: [Color(0xFFbffcc6), Color(0xFFffb5e8)],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creative Visualization',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You, your future,\nare a result of your\nbelieves. Reset your\nmindset to live a \nbreakthrough.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// Helper methods to create buttons and cards



