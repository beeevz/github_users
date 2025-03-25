import 'package:flutter/material.dart';
import 'package:github_users/common/localization/translation_helper.dart';

class HomeWidget extends StatefulWidget {
  static const routePath = "/home";
  static const routeName = "home";

  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final searchFieldController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  void dispose() {
    searchFieldController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: AnimatedAlign(
          // Switch the below to evaluate if we're on the initial load
          alignment:
              searchFocusNode.hasFocus ? Alignment.topCenter : Alignment.center,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 500),
          child: Focus(
            focusNode: searchFocusNode,
            child: TextFormField(
              decoration: InputDecoration(hintText: t(context).search),
            ),
            onFocusChange: (hasFocus) {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
