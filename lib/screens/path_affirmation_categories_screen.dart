import 'package:flutter/material.dart';

class AffirmationCategoriesScreen extends StatelessWidget {
  // List of image assets
  final List<String> imagePaths = [
    'images/playlist8.png',
    'images/Playlist 7.png',
    'images/Playlist 6.png',
    'images/img.png',
  ];

   AffirmationCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             // const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);

                    },
                    child: Image.asset('images/icons/arrowleft.png',
                      height: 35,
                      width: 35,
                    )
                ),
             //   const SizedBox(width: 10,),
                const Text(
                  "Affirmations Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(),
              ],),
              SizedBox(height: 30,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'These results highlight areas where you might feel less confident. Understanding these can help guide your personal growth.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 110,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('images/Frame 10.png'),
                      ),
                    ),
                  ), // Image on the right side
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey), // Divider below the text
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, 'AudioplayAppearenceScreen');
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                         // color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(imagePaths[index]), // Use the image path from the list
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashHeight;

  DashedLinePainter({required this.color, this.dashHeight = 5});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight * 2;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
