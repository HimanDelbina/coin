import 'package:coin/provider/gettrends_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Trends extends StatefulWidget {
  const Trends({Key? key}) : super(key: key);

  @override
  _TrendsState createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  List<Color> redColor = [
    Colors.red.withOpacity(0.4),
    Colors.red.withOpacity(0),
  ];
  List<Color> greenColor = [
    Colors.green.withOpacity(0.4),
    Colors.green.withOpacity(0),
  ];
  List<Color> greyColor = [
    Colors.grey.withOpacity(0.4),
    Colors.grey.withOpacity(0),
  ];
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    context.read<TrendsGet>().fetchData;
    return Container(
      height: myHeight * 0.22,
      width: myWidth,
      child: Center(
        child: Consumer<TrendsGet>(
          builder: (context, value, child) {
            return value.map!.coins!.length == 0 && !value.error
                ? Center(
                    child: Lottie.asset("assets/animation/loading.json",
                        height: 40.0),
                  )
                : value.error
                    ? Text(value.errorMessage.toString())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            height: myHeight * 0.2,
                            width: myWidth,
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Trends",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "بیشتر ...",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: value.map!.coins!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return value.map!.coins![index].item!
                                                .name !=
                                            null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //       builder: (context) => CoinSelect(
                                                  //           changePrice: value
                                                  //               .map[
                                                  //                   index]
                                                  //               .marketCapChangePercentage24H!,
                                                  //           price: value
                                                  //               .map[
                                                  //                   index]
                                                  //               .currentPrice,
                                                  //           id: value
                                                  //               .map[
                                                  //                   index]
                                                  //               .id
                                                  //               .toString()),
                                                  //     ));
                                                },
                                                child: Container(
                                                  height: myHeight * 0.15,
                                                  width: myWidth * 0.34,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                        )
                                                      ]),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            value
                                                                        .map!
                                                                        .coins![
                                                                            index]
                                                                        .item!
                                                                        .symbol !=
                                                                    null
                                                                ? Text(
                                                                    value
                                                                        .map!
                                                                        .coins![
                                                                            index]
                                                                        .item!
                                                                        .symbol
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            13.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : const Text(
                                                                    "تعیین نشده"),
                                                            Container(
                                                              height: myHeight *
                                                                  0.04,
                                                              width: myWidth *
                                                                  0.08,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.2)),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: NetworkImage(value
                                                                          .map!
                                                                          .coins![
                                                                              index]
                                                                          .item!
                                                                          .small
                                                                          .toString()))),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                const Spacer(),
                                                                value
                                                                            .map!
                                                                            .coins![
                                                                                index]
                                                                            .item!
                                                                            .name !=
                                                                        null
                                                                    ? Text(
                                                                        value
                                                                            .map!
                                                                            .coins![index]
                                                                            .item!
                                                                            .name
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                13.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    : const Text(
                                                                        "تعیین نشده"),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  "رتبه ارز : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      fontSize:
                                                                          14.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                value
                                                                            .map!
                                                                            .coins![
                                                                                index]
                                                                            .item!
                                                                            .marketCapRank !=
                                                                        null
                                                                    ? Text(
                                                                        value
                                                                            .map!
                                                                            .coins![index]
                                                                            .item!
                                                                            .marketCapRank
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      )
                                                                    : const Text(
                                                                        "تعیین نشده"),
                                                                const Spacer(),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: Lottie.asset(
                                                "assets/animation/loading.json",
                                                height: 40.0),
                                          );
                                  },
                                )),
                              ],
                            ),
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}