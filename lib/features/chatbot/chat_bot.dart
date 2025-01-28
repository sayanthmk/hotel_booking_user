import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hotel_booking/core/constants/colors.dart';
import 'package:hotel_booking/utils/custom_appbar/custom_appbar.dart';
import 'package:image_picker/image_picker.dart';

class HotelBookingChat extends StatefulWidget {
  const HotelBookingChat({super.key});

  @override
  State<HotelBookingChat> createState() => HotelBookingChatState();
}

class HotelBookingChatState extends State<HotelBookingChat> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "Guest");
  ChatUser hotelBot = ChatUser(
    id: "1",
    firstName: "Booking Assistant",
    profileImage: "assets/images/hotel_image.jpg",
  );

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BookingAppbar(
        heading: 'Booking Assistant',
      ),
      body: DashChat(
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
            hintText: "Type your booking query...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          trailing: [
            IconButton(
              onPressed: () async {
                ImagePicker picker = ImagePicker();
                XFile? file = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (file != null) {
                  ChatMessage chatMessage = ChatMessage(
                    user: currentUser,
                    createdAt: DateTime.now(),
                    text: "I'd like information about this room/area",
                    medias: [
                      ChatMedia(
                        url: file.path,
                        fileName: "",
                        type: MediaType.image,
                      )
                    ],
                  );
                  sendMessage(chatMessage);
                }
              },
              icon: const Icon(Icons.image),
              tooltip: "Share room image for inquiry",
            ),
          ],
        ),
        currentUser: currentUser,
        onSend: sendMessage,
        messages: messages,
        messageOptions: const MessageOptions(
          showTime: true,
          containerColor: HotelBookingColors.basictextcolor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      // Prepare the context for hotel-related queries
      String contextPrompt = "You are a helpful hotel booking assistant. "
          "Provide relevant information about room availability, amenities, "
          "and booking procedures. Be polite and professional.";

      String question = "$contextPrompt\n\nUser query: ${chatMessage.text}";
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }

      gemini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == hotelBot) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: hotelBot,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      // Handle errors
      setState(() {
        messages = [
          ChatMessage(
            user: hotelBot,
            createdAt: DateTime.now(),
            text:
                "I apologize, but I'm having trouble processing your request. "
                "Please try again or contact our front desk directly.",
          ),
          ...messages
        ];
      });
    }
  }
}

// appBar: PreferredSize(
//   preferredSize: const Size.fromHeight(kToolbarHeight),
//   child: Container(
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         colors: [
//           Color(0xFF1B4F72),
//           Color(0xFF2E86C1),
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//     ),
//     child: AppBar(
//       backgroundColor: Colors.transparent,
//       centerTitle: true,
//       title: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.hotel, color: Colors.white),
//           SizedBox(width: 8),
//           Text(
//             "Luxury Hotel Booking",
//             style: TextStyle(
//               fontSize: 24,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//       elevation: 0,
//     ),
//   ),
// ),

// void _showQuickResponses() {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) => Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: const Icon(Icons.calendar_today),
//             title: const Text("Check room availability"),
//             onTap: () {
//               Navigator.pop(context);
//               sendMessage(
//                 ChatMessage(
//                   user: currentUser,
//                   createdAt: DateTime.now(),
//                   text:
//                       "I'd like to check room availability for the next weekend",
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.hotel),
//             title: const Text("Room types"),
//             onTap: () {
//               Navigator.pop(context);
//               sendMessage(ChatMessage(
//                 user: currentUser,
//                 createdAt: DateTime.now(),
//                 text: "What types of rooms do you offer?",
//               ));
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.spa),
//             title: const Text("Hotel amenities"),
//             onTap: () {
//               Navigator.pop(context);
//               sendMessage(ChatMessage(
//                 user: currentUser,
//                 createdAt: DateTime.now(),
//                 text: "What amenities are available at the hotel?",
//               ));
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }

// void initState() {
//   super.initState();
//   Future.delayed(Duration.zero, () {
//     final welcomeMessage = ChatMessage(
//       user: hotelBot,
//       createdAt: DateTime.now(),
//       // text: "Welcome to Luxury Hotel! How may I assist you today?\n\n"
//       //     "I can help you with:\n"
//       //     "• Room bookings and availability\n"
//       //     "• Room types and amenities\n"
//       //     "• Check-in/check-out information\n"
//       //     "• Hotel facilities\n"
//       //     "• Special requests",
//     );
//     setState(() {
//       messages = [welcomeMessage];
//     });
//   });
// }
