import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/theme_provider.dart';

class ReadingDescriptionScreen extends StatefulWidget {
  final String? description;

  const ReadingDescriptionScreen(this.description, {super.key});

  @override
  State<ReadingDescriptionScreen> createState() =>
      _ReadingDescriptionScreenState();
}

class _ReadingDescriptionScreenState extends State<ReadingDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<String?>?>(
              future: splitReadings(widget.description),
              initialData: const [],
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return RichText(
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    text: snapshot.data![i].toString(),
                                    style: TextStyle(
                                        color: themeProvider.isDarkModeEnabled
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 22),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      );
    });
  }

  //-----------------------------------------------------------------
  Future<List<String?>> splitReadings(String? readings) async {
    return readings?.split('\\n') ?? List.empty();
  }
}
