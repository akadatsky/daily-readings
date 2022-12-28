import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            RichText(
              text: const TextSpan(
                text: 'What is in the App?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
                children: [
                  TextSpan(
                    text:
                        'The App consists of a reading for each day, with a Bible section to read (at the top), a meditation from C H Spurgeon which has been lightly modernized, a “for thought and prayer" section at the end of each reading and a hymn to read or sing, along with the accompanying music. Also in the App is a complete Bible (the English Standard Version or ESV) which is accessible from the left ‘slide out’ menu.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: 'How to use the App?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                        'There are readings for every morning and evening of the year. We suggest the following:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' •	Start by considering the verse provided by C H Spurgeon (in the image at the top of each reading)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' •	Click on the Bible reading icon and read the suggested passage of Scripture. This has been chosen to add context or further insight',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: " •	Read C H Spurgeon's comments",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text:
                        " •	Sing or read the hymn next (you need not sing aloud, especially if you are wearing headphones!)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text:
                        " •	Finally, read the ‘For Thought and Prayer’ section and commit the matters you have been considering to the Lord in prayer",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Of course, this is only a suggestion and we would love to hear more from you on how you are using the App. You can send us feedback through the ‘feedback section’ from the slide out menu.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  RotatedBox(
                    quarterTurns: -2,
                    child: Icon(Icons.wb_incandescent_outlined),
                  ),
                  SizedBox(width: 5),
                  Text('START-UP HELP')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}