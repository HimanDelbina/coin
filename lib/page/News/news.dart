import 'package:coin/model/news_model.dart';
import 'package:coin/page/News/news_selected.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persian_number_utility/src/extensions.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: newsData!.length,
          itemBuilder: (context, index) {
            spliteText(newsData![index].persiantime);
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsSelected(
                              title: newsData![index].title,
                              date: newsData![index].date,
                              description: newsData![index].description,
                              image: newsData![index].image,
                              source: newsData![index].source,
                              time: newsData![index].persiantime)));
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.blueAccent.withOpacity(0.05)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: myHeight * 0.1,
                          width: myWidth * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://46.225.114.245:2002" +
                                          newsData![index].image.toString()),
                                  fit: BoxFit.fill)),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Container(
                            height: myHeight * 0.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        newsData![index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("منبع : " + newsData![index].source),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      value1.toString().extractNumber() +
                                          ":" +
                                          value2.toString().extractNumber(),
                                      // overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newsData![index]
                                          .date
                                          .toString()
                                          .toPersianDate(),
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
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

  List? newsData = [];
  var newsList;
  Future<List<NewsModel>?> getNews() async {
    const infourl = 'http://46.225.114.245:2002/news/news_list';
    var response = await http
        .get(Uri.parse(infourl), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var x = response.body;
      newsList = newsModelFromJson(x);
      setState(() {
        newsData = newsList;
      });
      return newsList;
    }
  }
}
