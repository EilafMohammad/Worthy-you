import 'package:flutter/material.dart';

class AudioPlayScreen extends StatelessWidget {
  static const tag = '/audio_player_screen';

  const AudioPlayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35,),
            ////////////////////////////Top Row start here /////////////////
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
                  const Text(
                    "Hi Eilaf",
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('images/profile.png'),
                      ),
                  ],
                ),
            const SizedBox(height: 80,),
            const SettingsOption(
              label: "Account Security",
              imageIcon: 'images/icons/profile.png',
            ),
            Container(
              color: Colors.blueGrey.shade200,
              width: double.maxFinite,
              height: 1,
            ),

            const SettingsOption(
              imageIcon: 'images/icons/setting-5.png',
              label: "Billing",
            ),
            Container(
              color: Colors.blueGrey.shade200,
              width: double.maxFinite,
              height: 1,
            ),
            const SettingsOption(
              imageIcon: 'images/icons/message-text.png',
              label: "Language",
            ),
            Container(
              color: Colors.blueGrey.shade200,
              width: double.maxFinite,
              height: 1,
            ),
            const SettingsOption(
              imageIcon: 'images/icons/warning-2.png',
              label: "Help",
            ),
            Container(
              color: Colors.blueGrey.shade200,
              width: double.maxFinite,
              height: 1,
            ),
            const SettingsOption(
              imageIcon: 'images/icons/login.png',
              label: "Logout",
            ),

            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: const Text(
                "Notifications Scheduling",
                style: TextStyle(
                  color: Color(0xff392AAB),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(24)
              ),
              child: Column(
                children: [
                  const NotificationCard(
                    session: "Morning Session",
                    date: "Jan 1, 2024",
                    time: "4:00 am",
                    timeColor: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      width: double.maxFinite,
                      height: 1,
                    ),
                  ),
                  const NotificationCard(
                    session: "Evening Session",
                    date: "Jan 31, 2024",
                    time: "7:00 pm",
                    timeColor: Colors.green,
                  ),
                ],
              ),
            ),

            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ]
      )


      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String imageIcon;
  final String label;

  const SettingsOption({super.key, required this.imageIcon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(imageIcon, color: Colors.blueGrey, height: 25,width: 25,),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0XFF121212)
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String session;
  final String date;
  final String time;
  final Color timeColor;

  const NotificationCard({super.key, 
    required this.session,
    required this.date,
    required this.time,
    required this.timeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(16),
      // ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: timeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                time,
                style: TextStyle(
                  color: timeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
