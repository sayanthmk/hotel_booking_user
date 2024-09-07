import 'package:flutter/material.dart';
import 'package:hotel_booking/features/auth/presentation/pages/routepage.dart';
import 'package:hotel_booking/features/auth/presentation/widgets/gradiant_button.dart';
import 'package:hotel_booking/features/onboarding/contents.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  OnbordingState createState() => OnbordingState();
}

class OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        contents[i].image!,
                        height: 250,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          contents[i].title!,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                const SizedBox(height: 20),
             
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  width: double.infinity,
                  child: CustomButton(
                    text: currentIndex == contents.length - 1 ? 'Done' : 'Next',
                    onTap: () {
                      if (currentIndex == contents.length - 1) {
                    

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AuthSelectionPage(),
                        ));
                      }
                      _controller!.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.bounceIn,
                      );
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    borderRadius: 10.0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    height: 50,
                    width: 300,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5435FF), 
                        Color(0xFF36C8F6), 
                        Color(0xFFA0FBCD), 
                      ],
                      stops: [0.0, 0.5, 1.0], 
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              
                if (currentIndex < 2)
                  TextButton(
                    onPressed: () {
                      _controller!.animateToPage(
                        contents.length - 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Color(0xFF36C8F6), fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 20 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF36C8F6),
      ),
    );
  }
}
