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
