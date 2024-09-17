import 'package:flutter/material.dart';

class HomeRowCard extends StatefulWidget {
  final String title;
  final Icon icon;
  final Color? color;
  const HomeRowCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  State<HomeRowCard> createState() => _HomeRowCardState();
}

class _HomeRowCardState extends State<HomeRowCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
              child: Center(
                child: widget.icon,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
