import 'package:flutter/material.dart';

class HomeExclusiveCard extends StatefulWidget {
  final String discount;
  final String model;
  final String image;
  const HomeExclusiveCard({
    super.key,
    required this.discount,
    required this.model,
    required this.image,
  });

  @override
  State<HomeExclusiveCard> createState() => _HomeExclusiveCardState();
}

class _HomeExclusiveCardState extends State<HomeExclusiveCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[400],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          "${widget.discount} Off",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.model,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
