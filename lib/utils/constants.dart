import 'dart:convert';

import 'package:worthy_you/models/questions_model.dart';

class Constants{
  static const String appName="WorthyYou";

  static const String titleWelcomeApp="Welcome to  $appName";
  static const String welcomeAppInfo="Your journey to self-acceptance and confidence starts here";
  static const String titleDiagnoseInsecurities= "Diagnose your insecurities";
  static const String titleDiagnoseInsecuritiesInfo= "Take a quiz to uncover what’s holding you back.'";
  static const String titlePersonalizedAffirmations= "Personalized Affirmations";
  static const String titlePersonalizedAffirmationsInfo= "Experience the power of affirmations tailored to your needs and delivered in a voice that’s uniquely yours.";


  static const String labelSkip="Skip";
  static const String labelNext="Next";
  static const String labelBack="Back";
  static const String labelGetStarted="Get Started";

  static const String labelMyAffirmations="My Affirmations";
  static const String labelMain="Main";
  static const String labelSubscriptions="Subscriptions";
  static const String labelWelcomEliaf="Welcome, Eliaf!";
  static const String titleCraftingPersonalizedAffirmations="Crafting your Personalized affirmations";
  static const String titleMeditationPaths="Meditation paths for you";

  static const String labelBookSession="Book a session";
  static const String labelEcho="Echo (venting bot)";


  static const String labelVentingBot="Venting Bot";
  static const String chatBotIntroInfo="Hello Nice to see you here! By pressing the 'Start chat' button you agree to have your personal data processed as described in our Privacy Policy";
  static const String labelFiguringInsecurities="Figuring out the insecurities";
  static const String titleQuizResults="Great job on completing the quiz!\nHere’s a snapshot of your insecurities:";
  static const String labelCareerCompetence="Career Competence";
  static const String labelSocialAcceptance="Social Acceptance";
  static const String labelAppearance="Appearance";
  static const String labelAcademicPerformance="Academic Performance";

  static const String labelNextStep="Next Step";
  static const String labelListenPersonalizedAffirmations="Listen to Personalized Affirmations:";
  static const String labelListenPersonalizedAffirmationsInfo="Tailored to address your specific insecurities.";

  static const String titleAffirmationsCategories="Affirmations Categories";
  static const String infoAffirmationsCategories="These results highlight areas where you might feel less confident. Understanding these can help guide your personal growth.";

  static const questions = {
    "questionsData":[
      {
        "scenario": null,
        "data": [
          {
            "key": "appearance",
            "question":
            "You're getting ready for an important event and trying on different outfits. How do you feel about your appearance?",
            "options": [
              "I feel confident and satisfied with how I look",
              "I feel okay, but I wish I could change a few things",
              "I’m unsure and keep changing outfits, worried about how I’ll be perceived.",
              "I feel uncomfortable with my appearance and want to avoid the event"
            ]
          },
          {
            "key": "appearance",
            "question":
            "You notice a change in your weight or body shape. How does this affect your self-esteem?",
            "options": [
              "It doesn't affect me; I’m comfortable in my body.",
              "I’m slightly concerned but focus on staying healthy.",
              "I feel self-conscious and think about dieting or exercising more.",
              "I’m very upset and feel ashamed of my appearance."
            ]
          },
          {
            "key": "appearance",
            "question":
            "You receive a compliment about your looks from someone you admire. How do you react?",
            "options": [
              "I accept the compliment and feel good about myself.",
              "I feel flattered but wonder if they’re just being polite",
              "I feel awkward and struggle to believe the compliment",
              "I dismiss the compliment, thinking they’re not being sincere"
            ]
          },
          {
            "key": "appearance",
            "question":
            "A friend posts a picture of you on social media that you’re not happy with. What do you do?",
            "options": [
              "I don’t mind; I’m comfortable with how I look",
              "I feel a bit uneasy but let it go",
              "I ask my friend to take the photo down",
              "I feel embarrassed and avoid social media for a while"
            ]
          },
          {
            "key": "appearance",
            "question":
            "You’re shopping for new clothes, and the size you usually wear doesn’t fit. How do you feel?",
            "options": [
              "It’s just a number; I’ll try a different size",
              "I feel a bit disappointed but not overly concerned",
              "I feel self-conscious and worry that I’m gaining weight",
              "I feel upset and think about going on a strict diet"
            ]
          }
        ]
      },
      {
        "scenario": null,
        "data": [
          {
            "key": "social_acceptance",
            "question":
            "You’re in a group conversation, but no one seems to acknowledge your contributions. How do you feel?",
            "options": [
              "I’m confident in myself, so I’m not bothered",
              "I feel slightly overlooked but stay engaged",
              "I start doubting whether I belong in the group",
              "I feel completely ignored and decide to stay quiet"
            ]
          },
          {
            "key": "social_acceptance",
            "question":
            "You see your friends hanging out without inviting you. How do you react?",
            "options": [
              "I understand they might have plans without me sometimes",
              "I feel a bit left out but don’t overthink it",
              "I worry that they’re excluding me on purpose",
              "I feel rejected and start questioning the friendship"
            ]
          },
          {
            "key": "social_acceptance",
            "question":
            "You share an idea in a meeting or class, and it’s met with silence. How do you respond?",
            "options": [
              "I stay confident and stand by my idea",
              "I feel a little embarrassed but move on",
              "I start questioning the validity of my idea",
              "I feel humiliated and avoid speaking up again"
            ]
          },
          {
            "key": "social_acceptance",
            "question":
            "You’re new to a group and trying to make friends. How do you feel about fitting in?",
            "options": [
              "I’m confident that I’ll make friends naturally",
              "I feel a bit nervous but am hopeful about making connections",
              "I worry that I won’t fit in or be accepted",
              "I feel like an outsider and consider leaving the group"
            ]
          },
          {
            "key": "social_acceptance",
            "question":
            "You’re organizing a social event, but not many people RSVP. How does this affect you?",
            "options": [
              "I understand that people are busy; it doesn’t bother me",
              "I’m slightly disappointed but look forward to the event anyway",
              "I start worrying that people don’t want to attend because of me",
              "I feel hurt and consider canceling the event"
            ]
          }
        ]
      },
      {
        "scenario": {
          "question":
          "Do you currently attend school, college, or any educational program?",
          "options": [
            "Yes, I’m currently enrolled in an educational program.",
            "No, but I’ve completed my education.",
            "No, and I have no plans to pursue education.",
            "I’m considering going back to school in the future."
          ]
        },
        "data": [
          {
            "key": "academic_performance",
            "question":
            "You receive a challenging assignment with a tight deadline. How do you feel about it?",
            "options": [
              "I’m confident in my ability to complete it on time",
              "I’m slightly stressed but believe I can manage",
              "I feel overwhelmed and worry about failing",
              "I panic and consider asking for an extension"
            ]
          },
          {
            "key": "academic_performance",
            "question":
            "You’re asked to present your work in front of the class or a group. How do you feel?",
            "options": [
              "I’m excited to share my work and confident in my abilities",
              "I feel a bit nervous but prepared to present",
              "I worry about making mistakes and embarrassing myself",
              "I feel terrified and consider finding a way to avoid presenting"
            ]
          },
          {
            "key": "academic_performance",
            "question":
            "You’re studying for an important exam, but you’re finding the material difficult. How do you handle it?",
            "options": [
              "I stay calm and focus on understanding the material",
              "I feel slightly anxious but keep studying",
              "I start doubting my ability to pass the exam",
              "I feel overwhelmed and consider giving up"
            ]
          },
          {
            "key": "academic_performance",
            "question":
            "You receive lower grades than expected in a course you usually excel in. How do you react?",
            "options": [
              "I understand that grades fluctuate and focus on improving",
              "I feel disappointed but motivated to do better next time",
              "I start questioning my intelligence and abilities",
              "I feel like a failure and consider dropping the course"
            ]
          },
          {
            "key": "academic_performance",
            "question":
            "You’re collaborating on a group project, but your contributions aren’t recognized. How do you feel?",
            "options": [
              "I’m confident in my work and don’t need external validation",
              "I feel slightly frustrated but continue contributing",
              "I start feeling undervalued and worry that my efforts aren’t good enough",
              "I feel completely discouraged and consider withdrawing from the project"
            ]
          }
        ]
      },
      {
        "scenario": {
          "question": "Are you currently employed or pursuing a career?",
          "options": [
            "Yes, I’m currently employed or pursuing a career.",
            "No, I’m not currently working but plan to in the future.",
            "No, I’m not working and don’t plan to pursue a career.",
            "I’m retired or not in the workforce."
          ]
        },
        "data": [
          {
            "key": "career_competence",
            "question":
            "You’re given a new responsibility at work that you’ve never handled before. How do you feel about it?",
            "options": [
              "I’m excited and confident that I can learn quickly",
              "I feel a bit nervous but ready to take on the challenge",
              "I start worrying that I might not be able to handle it",
              "I feel overwhelmed and fear that I’ll fail"
            ]
          },
          {
            "key": "career_competence",
            "question":
            "You’re in a meeting where others are discussing topics you’re not familiar with. How do you react?",
            "options": [
              "I stay confident, listen carefully, and ask questions if needed",
              "I feel slightly out of my depth but try to follow along",
              "I start feeling inadequate and worry that I’m not knowledgeable enough",
              "I feel anxious and avoid participating in the discussion"
            ]
          },
          {
            "key": "career_competence",
            "question":
            "You’re up for a promotion, but so is a colleague who has been performing well. How do you feel about your chances?",
            "options": [
              "I’m confident in my abilities and believe I have a good chance",
              "I’m slightly anxious but know that I’ve done good work",
              "I start doubting myself and worry that I’m not as capable as my colleague",
              "I feel discouraged and assume my colleague will get the promotion"
            ]
          },
          {
            "key": "career_competence",
            "question":
            "You’ve received feedback from your manager that highlights areas for improvement. How do you take it?",
            "options": [
              "I take the feedback constructively and see it as an opportunity to grow",
              "I feel a bit disappointed but understand the importance of the feedback",
              "I start feeling insecure and worry that I’m not meeting expectations",
              "I feel criticized and start doubting my competence in my role"
            ]
          },
          {
            "key": "career_competence",
            "question":
            "You’re asked to lead a project that’s crucial to your team’s success. How do you feel about this responsibility?",
            "options": [
              "I’m excited about the opportunity and confident in my leadership abilities",
              "I feel a bit nervous but ready to take on the challenge",
              "I start feeling anxious and worry about my ability to lead effectively",
              "I feel overwhelmed and fear that I’ll let my team down"
            ]
          }
        ]
      }
    ]
  };

  static var questionsModel = questionsModelFromJson(jsonEncode(questions));
}