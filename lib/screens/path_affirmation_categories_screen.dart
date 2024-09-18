import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/audioPlay_appearence_screen.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class AffirmationCategoriesScreen extends StatelessWidget {
  static const tag = '/affirmation_categories_screen';

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
      appBar: AppBar(
        leading: IconButton(
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              Get.back();
            },
            icon: const ImageIcon(
              AssetImage(
                "images/icon_back.png",
              ),
              size: 30.0,
            )),
        elevation: 0,
        backgroundColor: MyColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constants.titleAffirmationsCategories,
              style: Styles.subHeadingStyle
                  .copyWith(color: MyColors.textColorSecondary),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    Constants.infoAffirmationsCategories,
                    style: Styles.textStyle.copyWith(fontSize: 14.0),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 100,
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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Get.toNamed(AudioPlayerAppearanceScreen.tag);
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
