import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentiment_classifier/classifier.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  late Classifier _classifier;
  late List<Widget> _children;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _classifier = Classifier();
    _children = [];
    _children.add(Container());
  }

  String result = '';
  void preditct() {
    final temp = _classifier.classify(_controller.text);
    if (temp[1] > temp[0]) {
      result = 'Positive';
    } else {
      result = 'Negative';
    }
    setState(() {});
  }

  Widget showResult() {
    if (result == "Positive") {
      return Image.asset("assets/positive.png");
    } else if (result == "Negative") {
      return Image.asset("assets/negative.png");
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff272A4E),
        body: Stack(
          children: [
            // Image.asset(
            //   "assets/background.png",
            //   fit: BoxFit.cover,
            //   height: double.infinity,
            //   width: double.infinity,
            // ),
            BlurryContainer(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              blur: 10,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Type what you feel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    maxLines: 5,
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter your text here",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  showResult(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      fixedSize: Size(MediaQuery.of(context).size.width, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: preditct,
                    child: const Text("Analyse"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
