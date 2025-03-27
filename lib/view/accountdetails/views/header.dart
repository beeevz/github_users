import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String? avatarUrl;
  const HeaderWidget({super.key, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10 * 3,
      child: Stack(
        children: [
          Center(
            child: ClipOval(
              child: Image.network(
                avatarUrl ?? "",
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
