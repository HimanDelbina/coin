import 'package:coin/provider/gettrends_provider.dart';
import 'package:coin/provider/theme.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_number_utility/src/extensions.dart';
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
    ThemeBloc theme = Provider.of<ThemeBloc>(context);
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
                            height: myHeight * 0.22,
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
                                    children: [
                                      Text(
                                        "trend".tr(),
                                        style: TextStyle(
                                          color: theme.textColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "more".tr(),
                                        style: const TextStyle(
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
                                    return Padding(
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
                                                color: theme.conColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                                  .coins![index]
                                                                  .item!
                                                                  .symbol !=
                                                              null
                                                          ? Text(
                                                              value
                                                                  .map!
                                                                  .coins![index]
                                                                  .item!
                                                                  .symbol
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: theme
                                                                      .textColor,
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              "specified".tr(),
                                                              style: TextStyle(
                                                                  color: theme
                                                                      .textColor)),
                                                      Container(
                                                        height: myHeight * 0.04,
                                                        width: myWidth * 0.08,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2)),
                                                            image: DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
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
                                                        // crossAxisAlignment:
                                                        //     CrossAxisAlignment
                                                        //         .start,
                                                        children: [
                                                          // const Spacer(),
                                                          value
                                                                      .map!
                                                                      .coins![
                                                                          index]
                                                                      .item!
                                                                      .name !=
                                                                  null
                                                              ? Flexible(
                                                                flex: 1,
                                                                child: Text(
                                                                  
                                                                    value
                                                                        .map!
                                                                        .coins![
                                                                            index]
                                                                        .item!
                                                                        .name
                                                                        .toString(),
                                                                        softWrap: true,
                                                                    style: TextStyle(
                                                                        color: theme
                                                                            .textColor,
                                                                        fontSize:
                                                                            13.0,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                              )
                                                              : Text(
                                                                  "specified"
                                                                      .tr(),
                                                                  style: TextStyle(
                                                                      color: theme
                                                                          .textColor)),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "rank".tr() + " : ",
                                                            style: TextStyle(
                                                                color: theme
                                                                    .textMoreColor,
                                                                fontSize: 14.0,
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
                                                                      .coins![
                                                                          index]
                                                                      .item!
                                                                      .marketCapRank
                                                                      .toString()
                                                                      .seRagham()
                                                                      .toPersianDigit(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: theme
                                                                        .textColor,
                                                                    fontSize:
                                                                        13.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "specified"
                                                                      .tr(),
                                                                  style: TextStyle(
                                                                      color: theme
                                                                          .textColor)),
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
