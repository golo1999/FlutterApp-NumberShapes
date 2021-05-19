import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './app_data.dart';

void main() {
  runApp(MaterialApp(
    home: NumberShapes(),
    debugShowCheckedModeBanner: false,
  ));
}

class NumberShapes extends StatelessWidget {
  const NumberShapes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final TextEditingController textFieldController = TextEditingController();

    void clearController() {
      if (textFieldController.text.isNotEmpty) textFieldController.text = "";
    }

    void showAlertDialog(BuildContext context, String message) {
      Widget okButton = TextButton(
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop();
          },
          child: Text("OK"));

      AlertDialog dialog = AlertDialog(
        title: Text(AppData.userInputNumber.toString()),
        content: Text(message),
        actions: [
          okButton,
        ],
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppData.primaryColor,
        title: Text(
          AppData.appTitle,
          style: TextStyle(
            color: AppData.secondaryColor,
            fontSize: data.size.longestSide * 0.02,
          ),
        ),
        actions: [
          IconButton(
            onPressed: AppData.closeApp,
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Container(
        color: AppData.secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: .8,
                child: Container(
                  color: AppData.secondaryColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: data.size.longestSide * 0.025,
                            horizontal: 0),
                        child: Text(
                          AppData.topText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: data.size.longestSide * 0.02,
                            color: AppData.primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: data.size.longestSide * 0.025,
                            horizontal: 0),
                        child: TextField(
                          controller: textFieldController,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                Icons.clear,
                                color: AppData.primaryColor,
                                size: data.size.longestSide * 0.025,
                              ),
                              onPressed: clearController,
                            ),
                            contentPadding: EdgeInsets.zero,
                            hintText: AppData.yourNumberText,
                            hintStyle: TextStyle(
                              color: AppData.primaryColor,
                              fontSize: data.size.longestSide * 0.02,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppData.primaryColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppData.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: AppData.primaryColor,
                            fontSize: data.size.longestSide * 0.02,
                          ),
                          keyboardType: TextInputType.number,
                          cursorHeight: data.size.longestSide * 0.02,
                          cursorColor: AppData.primaryColor,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (text) {
                            if (text.length > 1 && text[0] == '0') {
                              textFieldController.text = AppData.handleZeroFirstCharacter(textFieldController.text);
                              textFieldController.selection = TextSelection.fromPosition(TextPosition(offset: textFieldController.text.length));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppData.primaryColor,
        child: Icon(
          Icons.check,
          color: AppData.secondaryColor,
        ),
        onPressed: () {
          if (textFieldController.text.isNotEmpty && textFieldController.text != AppData.userInputNumber.toString())
            AppData.userInputNumber = int.tryParse(textFieldController.text);
          else if (textFieldController.text.isEmpty)
            AppData.userInputNumber = -1;

          if (AppData.userInputNumber >= 0) {
            bool isSquare = AppData.numberIsSquare(AppData.userInputNumber);
            bool isCube = AppData.numberIsCube(AppData.userInputNumber);

            if (isSquare && isCube)
              showAlertDialog(context, "Number " + AppData.userInputNumber.toString() + " is both square and cube");
            else if (!isSquare && !isCube)
              showAlertDialog(context, "Number " + AppData.userInputNumber.toString() + " is neither square nor cube");
            else if (isSquare)
              showAlertDialog(context, "Number " + AppData.userInputNumber.toString() + " is square");
            else showAlertDialog(context, "Number " + AppData.userInputNumber.toString() + " is cube");
          }
          // if the user hasn't enter a number
          else showAlertDialog(context, "Please enter a number");
        },
      ),
    );
  }
}
