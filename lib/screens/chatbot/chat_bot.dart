import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';

class ChatBotScreen extends StatefulWidget {
  static const tag = '/chat_screen';

  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Map<String, String>> _conversationHistory = []; // Maintain conversation history
  final List<ChatBubble> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  late OpenAI openAI;
  final ScrollController _scrollController = ScrollController(); // Initialize ScrollController

  @override
  void initState() {
    super.initState();
    _loadMessages();

    // Initialize OpenAI instance with GPT-4 model
    openAI = OpenAI.instance.build(
      token: "sk-KSnHdir8kGGHH6qyB-gl031jYCTnsD4xJHY9BmEB6rT3BlbkFJKmNOdh2xmpnCX60p_grMG_EXkC2N2LyGm3DdfhQXIA", // Replace with your actual OpenAI API key
      baseOption: HttpSetup(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 30),
      ),
      enableLog: true,
    );

    // Add system prompt to conversation history for consistent responses
    _conversationHistory.add({
      "role": "system",
      "content": '''
      Objective: Act as an empathetic and supportive assistant with expertise in emotional well-being.
      
      Tone: Your goal is to provide comfort and encouragement to users who may be experiencing difficult emotions. When a user expresses that they are feeling bad or struggling:
      
      1. Respond with empathy: Make the user feel heard and supported. Use understanding language to show that you care about their emotions.
      
      2. Offer supportive suggestions: Provide gentle, positive actions that the user can take to feel better. Avoid clinical advice and focus on small steps that are achievable.
      
      3. Explore their feelings: Encourage the user to open up and talk more about what they are going through, creating a safe and compassionate space for sharing.
      
      4. Avoid phrases like: "I'm really sorry that you're feeling this way, but I'm unable to provide the help that you need." Instead, keep the focus on support, empathy, and comfort.
    
      Guidelines:
      - Never dismiss the user’s feelings or suggest you are unable to help.
      - Focus on emotional support rather than clinical advice.
      - Encourage them to take small, manageable actions that may improve their mood.
      - At the end of each response, ask a relevant question to keep the conversation ongoing.
      - Avoid using formatting such as **bold**, *italic*, or any special styles.
      - Structure your response in clear sections, making it easy to read and understand.
      - Use bullet points or numbered lists to break down the information where necessary.
      - Keep your answers concise, supportive, and easy to digest for the user.
      - Add emojis to enhance emotional connection, especially in supportive or motivational messages. For example, 😊, ❤️, 🌟.
    
      Identity Handling:
      - If the user asks "Who are you?" or similar questions about identity, reply: "I am Venting Bot."
      - Do not mention or reference any generative models (e.g., GPT, AI models) in your responses.
    
      Motivation Requests:
      - If the user asks for motivation or seems to need encouragement, start with a motivational sentence such as: "You’ve got this! 💪 Remember, every small step counts!".
      - Include emojis to make the motivational message more impactful and positive.
      '''
    });


  }

  // Scroll the ListView to the bottom
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Load saved messages and scroll to the bottom
  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMessages = prefs.getStringList('chatMessages') ?? [];
    setState(() {
      _messages.addAll(savedMessages.map((msg) {
        final split = msg.split(':');
        return ChatBubble(message: split[1], isMe: split[0] == 'true');
      }).toList());
    });
    _scrollToBottom(); // Ensure chat is scrolled to bottom after loading
  }

  // Save conversation history
  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messages = _messages.map((m) => "${m.isMe}:${m.message}").toList();
    prefs.setStringList('chatMessages', messages);
  }

  // Function to delete messages from SharedPreferences
  Future<void> _deleteMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('chatMessages'); // Remove the saved chat history
  }

  // Function to send a message
  void _sendMessage(String message) async {
    setState(() {
      _messages.add(ChatBubble(message: message, isMe: true));
      _conversationHistory.add({"role": "user", "content": message});
      _isLoading = true;
    });
    _scrollToBottom(); // Scroll to bottom after sending message

    // Create the GPT request with prompt engineering
    final request = ChatCompleteText(
      messages: _conversationHistory,
      maxToken: 300,
      model: Gpt4ChatModel(),
      temperature: 0.3, // Encourage focused and reliable responses
      topP: 1.0,
      n: 1,
      presencePenalty: 0.0,
      frequencyPenalty: 0.0,
    );

    try {
      // Send the user's message to the GPT API and wait for the response
      final response = await openAI.onChatCompletion(request: request);

      // Extract the response from the API
      final reply = response?.choices.first.message?.content ?? "I'm here to listen. 😊 Please tell me more about how you're feeling.";

      // Add the bot's response to the message list
      setState(() {
        _messages.add(ChatBubble(message: reply, isMe: false, isBotResponse: true));
        _conversationHistory.add({"role": "assistant", "content": reply});
        _isLoading = false;
      });
    } catch (error) {
      // If an error occurs, show an error message
      setState(() {
        _messages.add(ChatBubble(message: "An error occurred. Please try again later.", isMe: false, isBotResponse: true));
        _isLoading = false;
      });
    }

    // Save the conversation after sending
    _saveMessages();

    // Scroll to bottom after receiving the message
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          Constants.labelVentingBot,
          style: Styles.subHeadingStyle,
        ),
        centerTitle: true,
        backgroundColor: MyColors.backgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach the scroll controller
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: DotsLoadingIndicator(),
            ),
          const Divider(height: 1.0,),
          MessageInput(
            controller: _controller,
            onSend: (value) {
              if (value.isNotEmpty) {
                _sendMessage(value);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final bool isBotResponse;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.isBotResponse = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const CircleAvatar(
                radius: 15.0,
                backgroundImage: AssetImage('images/icon_bot.jpg'),
              ),
            ),
          Expanded(
            child: Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(14),
                // margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                margin: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  right: isMe ? 10.0 : 50.0,
                  left: isMe ? 50.0 : 10.0,
                ),
                decoration: BoxDecoration(
                    color: isMe
                        ? MyColors.selfChatBubbleBackground
                        : MyColors.colorWhite,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    border: Border.all(
                      color: isMe
                          ? MyColors.selfChatBubbleBackground
                          : MyColors.inActiveBorderColor,
                    )),
                child: Text(
                  message,
                  style: Styles.textStyle.copyWith(
                    color: isMe ? MyColors.colorWhite : Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const MessageInput({
    required this.controller,
    required this.onSend,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(color: MyColors.colorWhite),
      height: 60.0,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration.collapsed(hintText: "Write a message",hintStyle: Styles.textStyle.copyWith(fontSize: 14,color: MyColors.textColorSecondary,fontWeight: FontWeight.normal)),
              onSubmitted: onSend,
            ),
          ),
          IconButton(
            icon: const ImageIcon(AssetImage("images/icon_send.png")),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSend(controller.text);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class DotsLoadingIndicator extends StatefulWidget {
  const DotsLoadingIndicator({super.key});

  @override
  _DotsLoadingIndicatorState createState() => _DotsLoadingIndicatorState();
}

class _DotsLoadingIndicatorState extends State<DotsLoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return FadeTransition(
            opacity: _controller.drive(
              CurveTween(curve: Interval(index * 0.2, 1.0, curve: Curves.easeInOut)),
            ),
            child: const Dot(),
          );
        }),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}
