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
  static const String labelPressHoldMic="Press the mic, and hold to record";


  static const String infoAppearance="Do you often feel self-conscious about your appearance? What specific aspects of your appearance are most troubling to you, and how do these feelings affect your self-image and daily life?";
  static const String infoSocialAcceptance="Do you often feel insecure about how others perceive you, and why do you think that is? How does it affect your self-confidence?";
  static const String infoAcademicPerformance="Do you often feel anxious or uncertain about your academic performance? What do you think might be causing these feelings, and how does it impact your overall self-esteem?";
  static const String infoCareerCompetence="Do you ever question your ability to succeed in your career? What experiences or thoughts contribute to this doubt, and how does it affect your confidence in your professional skills?";

  static const questions = {
    "questionsData":[
      {
        "id": 1,
        "data": [
          {
            "catId": 1,
            "questionId": 0001,
            "key": "appearance",
            "question":
            "You're getting ready for an important event and trying on different outfits. How do you feel about your appearance?",
            "options": [
              {
                "catId": 1,
                "questionId": 0001,
                "optionId": 0011,
                "option": "I feel confident and satisfied with how I look",
              },
              {
                "catId": 1,
                "questionId": 0001,
                "optionId": 0012,
                "option": "I feel okay, but I wish I could change a few things",
              },
              {
                "catId": 1,
                "questionId": 0001,
                "optionId": 0013,
                "option":
                    "I’m unsure and keep changing outfits, worried about how I’ll be perceived.",
              },
              {
                "catId": 1,
                "questionId": 0001,
                "optionId": 0014,
                "option":
                    "I feel uncomfortable with my appearance and want to avoid the event"
              }
            ]
          },
          {
            "catId": 1,
            "questionId": 0002,
            "key": "appearance",
            "question":
                "You notice a change in your weight or body shape. How does this affect your self-esteem?",
            "options": [
              {
                "catId": 1,
                "questionId": 0002,
                "optionId": 0021,
                "option": "It doesn't affect me; I’m comfortable in my body.",
              },
              {
                "catId": 1,
                "questionId": 0002,
                "optionId": 0022,
                "option":
                    "I’m slightly concerned but focus on staying healthy.",
              },
              {
                "catId": 1,
                "questionId": 0002,
                "optionId": 0023,
                "option":
                    "I feel self-conscious and think about dieting or exercising more.",
              },
              {
                "catId": 1,
                "questionId": 0002,
                "optionId": 0024,
                "option": "I’m very upset and feel ashamed of my appearance."
              }
            ]
          },
          {
            "catId": 1,
            "questionId": 0003,
            "key": "appearance",
            "question":
            "You receive a compliment about your looks from someone you admire. How do you react?",
            "options": [
              {
                "catId": 1,
                "questionId": 0003,
                "optionId": 0031,
                "option": "I accept the compliment and feel good about myself.",
              },
              {
                "catId": 1,
                "questionId": 0003,
                "optionId": 0032,
                "option":
                    "I feel flattered but wonder if they’re just being polite",
              },
              {
                "catId": 1,
                "questionId": 0003,
                "optionId": 0033,
                "option":
                    "I feel awkward and struggle to believe the compliment",
              },
              {
                "catId": 1,
                "questionId": 0003,
                "optionId": 0034,
                "option":
                    "I dismiss the compliment, thinking they’re not being sincere"
              }
            ]
          },
          {
            "catId": 1,
            "questionId": 0004,
            "key": "appearance",
            "question":
            "A friend posts a picture of you on social media that you’re not happy with. What do you do?",
            "options": [
              {
                "catId": 1,
                "questionId": 0004,
                "optionId": 0041,
                "option": "I don’t mind; I’m comfortable with how I look",
              },
              {
                "catId": 1,
                "questionId": 0004,
                "optionId": 0042,
                "option": "I feel a bit uneasy but let it go",
              },
              {
                "catId": 1,
                "questionId": 0004,
                "optionId": 0043,
                "option": "I ask my friend to take the photo down",
              },
              {
                "catId": 1,
                "questionId": 0004,
                "optionId": 0044,
                "option":
                    "I feel embarrassed and avoid social media for a while"
              }
            ]
          },
          {
            "catId": 1,
            "questionId": 0005,
            "key": "appearance",
            "question":
            "You’re shopping for new clothes, and the size you usually wear doesn’t fit. How do you feel?",
            "options": [
              {
                "catId": 1,
                "questionId": 0005,
                "optionId": 0051,
                "option": "It’s just a number; I’ll try a different size",
              },
              {
                "catId": 1,
                "questionId": 0005,
                "optionId": 0052,
                "option": "I feel a bit disappointed but not overly concerned",
              },
              {
                "catId": 1,
                "questionId": 0005,
                "optionId": 0053,
                "option":
                    "I feel self-conscious and worry that I’m gaining weight",
              },
              {
                "catId": 1,
                "questionId": 0005,
                "optionId": 0054,
                "option": "I feel upset and think about going on a strict diet"
              }
            ]
          }
        ]
      },
      {
        "id": 2,
        "data": [
          {
            "catId": 2,
            "questionId": 0001,
            "key": "social_acceptance",
            "question":
            "You’re in a group conversation, but no one seems to acknowledge your contributions. How do you feel?",
            "options": [
              {
                "catId": 2,
                "questionId": 0001,
                "optionId": 0011,
                "option": "I’m confident in myself, so I’m not bothered",
              },
              {
                "catId": 2,
                "questionId": 0001,
                "optionId": 0012,
                "option": "I feel slightly overlooked but stay engaged",
              },
              {
                "catId": 2,
                "questionId": 0001,
                "optionId": 0013,
                "option": "I start doubting whether I belong in the group",
              },
              {
                "catId": 2,
                "questionId": 0001,
                "optionId": 0014,
                "option": "I feel completely ignored and decide to stay quiet"
              }
            ]
          },
          {
            "catId": 2,
            "questionId": 0002,
            "key": "social_acceptance",
            "question":
            "You see your friends hanging out without inviting you. How do you react?",
            "options": [
              {
                "catId": 2,
                "questionId": 0002,
                "optionId": 0021,
                "option":
                    "I understand they might have plans without me sometimes",
              },
              {
                "catId": 2,
                "questionId": 0002,
                "optionId": 0022,
                "option": "I feel a bit left out but don’t overthink it",
              },
              {
                "catId": 2,
                "questionId": 0002,
                "optionId": 0023,
                "option": "I worry that they’re excluding me on purpose",
              },
              {
                "catId": 2,
                "questionId": 0002,
                "optionId": 0024,
                "option": "I feel rejected and start questioning the friendship"
              }
            ]
          },
          {
            "catId": 2,
            "questionId": 0003,
            "key": "social_acceptance",
            "question":
            "You share an idea in a meeting or class, and it’s met with silence. How do you respond?",
            "options": [
              {
                "catId": 2,
                "questionId": 0003,
                "optionId": 0031,
                "option": "I stay confident and stand by my idea",
              },
              {
                "catId": 2,
                "questionId": 0003,
                "optionId": 0032,
                "option": "I feel a little embarrassed but move on",
              },
              {
                "catId": 2,
                "questionId": 0003,
                "optionId": 0033,
                "option": "I start questioning the validity of my idea",
              },
              {
                "catId": 2,
                "questionId": 0003,
                "optionId": 0034,
                "option": "I feel humiliated and avoid speaking up again"
              }
            ]
          },
          {
            "catId": 2,
            "questionId": 0004,
            "key": "social_acceptance",
            "question":
            "You’re new to a group and trying to make friends. How do you feel about fitting in?",
            "options": [
              {
                "catId": 2,
                "questionId": 0004,
                "optionId": 0041,
                "option": "I’m confident that I’ll make friends naturally",
              },
              {
                "catId": 2,
                "questionId": 0004,
                "optionId": 0042,
                "option":
                    "I feel a bit nervous but am hopeful about making connections",
              },
              {
                "catId": 2,
                "questionId": 0004,
                "optionId": 0043,
                "option": "I worry that I won’t fit in or be accepted",
              },
              {
                "catId": 2,
                "questionId": 0004,
                "optionId": 0044,
                "option":
                    "I feel like an outsider and consider leaving the group"
              }
            ]
          },
          {
            "catId": 2,
            "questionId": 0005,
            "key": "social_acceptance",
            "question":
            "You’re organizing a social event, but not many people RSVP. How does this affect you?",
            "options": [
              {
                "catId": 2,
                "questionId": 0005,
                "optionId": 0051,
                "option":
                    "I understand that people are busy; it doesn’t bother me",
              },
              {
                "catId": 2,
                "questionId": 0005,
                "optionId": 0052,
                "option":
                    "I’m slightly disappointed but look forward to the event anyway",
              },
              {
                "catId": 2,
                "questionId": 0005,
                "optionId": 0053,
                "option":
                    "I start worrying that people don’t want to attend because of me",
              },
              {
                "catId": 2,
                "questionId": 0005,
                "optionId": 0054,
                "option": "I feel hurt and consider canceling the event"
              }
            ]
          }
        ]
      },
      {
        "id": 3,
        "data": [
          {
            "catId": 3,
            "questionId": 0000,
            "key": "academic_performance",
            "question": "Do you currently attend school, college, or any educational program?",
            "options": [
              {
                "catId": 3,
                "questionId": 0000,
                "optionId": 0001,
                "option": "Yes, I’m currently enrolled in an educational program.",
              },
              {
                "catId": 3,
                "questionId": 0000,
                "optionId": 0002,
                "option":"No, but I’ve completed my education.",
              },
              {
                "catId": 3,
                "questionId": 0000,
                "optionId": 0003,
                "option":"No, and I have no plans to pursue education.",
              },
              {
                "catId": 3,
                "questionId": 0000,
                "optionId": 0004,
                "option":"I’m considering going back to school in the future."
              }
            ]
          },

          {
            "catId": 3,
            "questionId": 0001,
            "key": "academic_performance",
            "question":
            "You receive a challenging assignment with a tight deadline. How do you feel about it?",
            "options": [
              {
                "catId": 3,
                "questionId": 0001,
                "optionId": 0011,
                "option": "I’m confident in my ability to complete it on time",
              },
              {
                "catId": 3,
                "questionId": 0001,
                "optionId": 0012,
                "option": "I’m slightly stressed but believe I can manage",
              },
              {
                "catId": 3,
                "questionId": 0001,
                "optionId": 0013,
                "option": "I feel overwhelmed and worry about failing",
              },
              {
                "catId": 3,
                "questionId": 0001,
                "optionId": 0014,
                "option": "I panic and consider asking for an extension"
              }
            ]
          },
          {
            "catId": 3,
            "questionId": 0002,
            "key": "academic_performance",
            "question":
            "You’re asked to present your work in front of the class or a group. How do you feel?",
            "options": [
              {
                "catId": 3,
                "questionId": 0002,
                "optionId": 0021,
                "option":
                    "I’m excited to share my work and confident in my abilities",
              },
              {
                "catId": 3,
                "questionId": 0002,
                "optionId": 0022,
                "option": "I feel a bit nervous but prepared to present",
              },
              {
                "catId": 3,
                "questionId": 0002,
                "optionId": 0023,
                "option":
                    "I worry about making mistakes and embarrassing myself",
              },
              {
                "catId": 3,
                "questionId": 0002,
                "optionId": 0024,
                "option":
                    "I feel terrified and consider finding a way to avoid presenting"
              }
            ]
          },
          {
            "catId": 3,
            "questionId": 0003,
            "key": "academic_performance",
            "question":
            "You’re studying for an important exam, but you’re finding the material difficult. How do you handle it?",
            "options": [
              {
                "catId": 3,
                "questionId": 0003,
                "optionId": 0031,
                "option": "I stay calm and focus on understanding the material",
              },
              {
                "catId": 3,
                "questionId": 0003,
                "optionId": 0032,
                "option": "I feel slightly anxious but keep studying",
              },
              {
                "catId": 3,
                "questionId": 0003,
                "optionId": 0033,
                "option": "I start doubting my ability to pass the exam",
              },
              {
                "catId": 3,
                "questionId": 0003,
                "optionId": 0034,
                "option": "I feel overwhelmed and consider giving up"
              }
            ]
          },
          {
            "catId": 3,
            "questionId": 0004,
            "key": "academic_performance",
            "question":
            "You receive lower grades than expected in a course you usually excel in. How do you react?",
            "options": [
              {
                "catId": 3,
                "questionId": 0004,
                "optionId": 0041,
                "option":
                    "I understand that grades fluctuate and focus on improving",
              },
              {
                "catId": 3,
                "questionId": 0004,
                "optionId": 0042,
                "option":
                    "I feel disappointed but motivated to do better next time",
              },
              {
                "catId": 3,
                "questionId": 0004,
                "optionId": 0043,
                "option": "I start questioning my intelligence and abilities",
              },
              {
                "catId": 3,
                "questionId": 0004,
                "optionId": 0044,
                "option":
                    "I feel like a failure and consider dropping the course"
              }
            ]
          },
          {
            "catId": 3,
            "questionId": 0005,
            "key": "academic_performance",
            "question":
            "You’re collaborating on a group project, but your contributions aren’t recognized. How do you feel?",
            "options": [
              {
                "catId": 3,
                "questionId": 0005,
                "optionId": 0051,
                "option":
                    "I’m confident in my work and don’t need external validation",
              },
              {
                "catId": 3,
                "questionId": 0005,
                "optionId": 0052,
                "option":
                    "I feel slightly frustrated but continue contributing",
              },
              {
                "catId": 3,
                "questionId": 0005,
                "optionId": 0053,
                "option":
                    "I start feeling undervalued and worry that my efforts aren’t good enough",
              },
              {
                "catId": 3,
                "questionId": 0005,
                "optionId": 0054,
                "option":
                    "I feel completely discouraged and consider withdrawing from the project"
              }
            ]
          }
        ]
      },
      {
        "id": 4,
        "data": [
          {
            "catId": 4,
            "questionId": 0000,
            "key": "career_competence",
            "question": "Are you currently employed or pursuing a career?",
            "options": [
              {
                "catId": 4,
                "questionId": 0000,
                "optionId": 0001,
                "option": "Yes, I’m currently employed or pursuing a career.",
              },
              {
                "catId": 4,
                "questionId": 0000,
                "optionId": 0002,
                "option":"No, I’m not currently working but plan to in the future.",
              },
              {
                "catId": 4,
                "questionId": 0000,
                "optionId": 0003,
                "option": "No, I’m not working and don’t plan to pursue a career.",
              },
              {
                "catId": 4,
                "questionId": 0000,
                "optionId": 0004,
                "option":"I’m retired or not in the workforce."
              }
            ]
          },
          {
            "catId": 4,
            "questionId": 0001,
            "key": "career_competence",
            "question":
            "You’re given a new responsibility at work that you’ve never handled before. How do you feel about it?",
            "options": [
              {
                "catId": 4,
                "questionId": 0001,
                "optionId": 0011,
                "option": "I’m excited and confident that I can learn quickly",
              },
              {
                "catId": 4,
                "questionId": 0001,
                "optionId": 0012,
                "option":
                    "I feel a bit nervous but ready to take on the challenge",
              },
              {
                "catId": 4,
                "questionId": 0001,
                "optionId": 0013,
                "option":
                    "I start worrying that I might not be able to handle it",
              },
              {
                "catId": 4,
                "questionId": 0001,
                "optionId": 0014,
                "option": "I feel overwhelmed and fear that I’ll fail"
              }
            ]
          },
          {
            "catId": 4,
            "questionId": 0002,
            "key": "career_competence",
            "question":
            "You’re in a meeting where others are discussing topics you’re not familiar with. How do you react?",
            "options": [
              {
                "catId": 4,
                "questionId": 0002,
                "optionId": 0021,
                "option":
                    "I stay confident, listen carefully, and ask questions if needed",
              },
              {
                "catId": 4,
                "questionId": 0002,
                "optionId": 0022,
                "option":
                    "I feel slightly out of my depth but try to follow along",
              },
              {
                "catId": 4,
                "questionId": 0002,
                "optionId": 0023,
                "option":
                    "I start feeling inadequate and worry that I’m not knowledgeable enough",
              },
              {
                "catId": 4,
                "questionId": 0002,
                "optionId": 0024,
                "option":
                    "I feel anxious and avoid participating in the discussion"
              }
            ]
          },
          {
            "catId": 4,
            "questionId": 0003,
            "key": "career_competence",
            "question":
            "You’re up for a promotion, but so is a colleague who has been performing well. How do you feel about your chances?",
            "options": [
              {
                "catId": 4,
                "questionId": 0003,
                "optionId": 0031,
                "option":
                    "I’m confident in my abilities and believe I have a good chance",
              },
              {
                "catId": 4,
                "questionId": 0003,
                "optionId": 0032,
                "option":
                    "I’m slightly anxious but know that I’ve done good work",
              },
              {
                "catId": 4,
                "questionId": 0003,
                "optionId": 0033,
                "option":
                    "I start doubting myself and worry that I’m not as capable as my colleague",
              },
              {
                "catId": 4,
                "questionId": 0003,
                "optionId": 0034,
                "option":
                    "I feel discouraged and assume my colleague will get the promotion"
              }
            ]
          },
          {
            "catId": 4,
            "questionId": 0004,
            "key": "career_competence",
            "question":
            "You’ve received feedback from your manager that highlights areas for improvement. How do you take it?",
            "options": [
              {
                "catId": 4,
                "questionId": 0004,
                "optionId": 0041,
                "option":
                    "I take the feedback constructively and see it as an opportunity to grow",
              },
              {
                "catId": 4,
                "questionId": 0004,
                "optionId": 0042,
                "option":
                    "I feel a bit disappointed but understand the importance of the feedback",
              },
              {
                "catId": 4,
                "questionId": 0004,
                "optionId": 0043,
                "option":
                    "I start feeling insecure and worry that I’m not meeting expectations",
              },
              {
                "catId": 4,
                "questionId": 0004,
                "optionId": 0044,
                "option":
                    "I feel criticized and start doubting my competence in my role"
              }
            ]
          },
          {
            "catId": 4,
            "questionId": 0005,
            "key": "career_competence",
            "question":
            "You’re asked to lead a project that’s crucial to your team’s success. How do you feel about this responsibility?",
            "options": [
              {
                "catId": 4,
                "questionId": 0005,
                "optionId": 0051,
                "option":
                    "I’m excited about the opportunity and confident in my leadership abilities",
              },
              {
                "catId": 4,
                "questionId": 0005,
                "optionId": 0052,
                "option":
                    "I feel a bit nervous but ready to take on the challenge",
              },
              {
                "catId": 4,
                "questionId": 0005,
                "optionId": 0053,
                "option":
                    "I start feeling anxious and worry about my ability to lead effectively",
              },
              {
                "catId": 4,
                "questionId": 0005,
                "optionId": 0054,
                "option":
                    "I feel overwhelmed and fear that I’ll let my team down"
              }
            ]
          }
        ]
      }
    ]
  };

  static var questionsModel = questionsModelFromJson(jsonEncode(questions));

  static const String labelClear ="Clear";
  static const String labelSubmit ="Submit";
}