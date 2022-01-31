import 'package:flutter/material.dart';
import 'package:persian_number_utility/src/extensions.dart';

class NewsSelected extends StatefulWidget {
  String? image;
  String? title;
  String? description;
  DateTime? date;
  String? time;
  String? source;
  NewsSelected(
      {Key? key,
      this.date,
      this.description,
      this.image,
      this.source,
      this.time,
      this.title})
      : super(key: key);

  @override
  _NewsSelectedState createState() => _NewsSelectedState();
}

class _NewsSelectedState extends State<NewsSelected> {
  @override
  void initState() {
    super.initState();
    spliteText(widget.time.toString());
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                children: [
                  Text(
                    widget.title!,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Text(
                    widget.description.toString(),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: myHeight * 0.05,
            width: myWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value1.toString().extractNumber() +
                        ":" +
                        value2.toString().extractNumber(),
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "منبع : " + widget.source.toString(),
                    style: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.date.toString().toPersianDate(),
                    style: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  String? value1;
  String? value2;
  void spliteText(String text) {
    final split = text.split(':');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };
    value1 = values[0];
    value2 = values[1];
  }
}
