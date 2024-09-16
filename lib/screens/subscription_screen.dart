import 'package:flutter/material.dart';


class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0XFFFAFDFF),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
            //  mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                          size: 30,
                          Icons.arrow_circle_left_outlined, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const PlanCard(
                  title: 'Free',
                  price: '\$0/mo',
                  features: [
                    'Take the initial quiz to uncover your insecurities',
                    'Receive personalized AI-generated affirmations for one week',
                  ],
                  isPremium: false,
                ),
                const SizedBox(height: 20),
                const PlanCard(
                  title: 'Premium',
                  price: '\$50/mo',
                  features: [
                    'Record your own voice and receive affirmations generated in your unique AI voice.',
                    'Venting Bot: Chat for additional emotional support.',
                  ],
                  isPremium: true,
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isPremium;

  const PlanCard({super.key, 
    required this.title,
    required this.price,
    required this.features,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPremium ? Colors.lightBlueAccent : Color(0xffFAFDFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isPremium ? Colors.white : Colors.blue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: TextStyle(
              color: isPremium ? Colors.white : Colors.blue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((feature) {
              return Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: isPremium ? Colors.white : Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        color: isPremium ? Colors.white : Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          if (isPremium) ...[
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle buy now button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'Buy now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

