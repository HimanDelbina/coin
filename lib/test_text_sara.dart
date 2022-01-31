import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaxalof extends StatefulWidget {
  // AddTaxalof({Key? key, this.finalLocLat, this.finalLocLong}) : super(key: key);

  @override
  _AddTaxalofState createState() => _AddTaxalofState();
}

class _AddTaxalofState extends State<AddTaxalof> {
  final GlobalKey<FormFieldState> _key = GlobalKey();

  TextEditingController? p1_controller;
  TextEditingController? p3_controller;
  TextEditingController? p4_controller;
  TextEditingController? description_controller;
  double? finalLocLat;
  double? finalLocLong;

  @override
  void initState() {
    // getGozareshat();
    // getHorof();

    p1_controller = new TextEditingController();
    p3_controller = new TextEditingController();
    p4_controller = new TextEditingController();
    description_controller = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    p1_controller!.dispose();
    p3_controller!.dispose();
    p4_controller!.dispose();
    description_controller!.dispose();

    super.dispose();
  }

  Future<Null> _selectedTime(BuildContext context) async {
    _timePicked = await showTimePicker(context: context, initialTime: _time);

    if (_timePicked != null) {
      setState(() {
        _time = _timePicked!;
      });
    }
  }

  // TimeOfDay _timeStart = TimeOfDay.fromDateTime(DateTime.now());
  // void _selectTimeStart() async {
  //   final TimeOfDay newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _timeStart,
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _timeStart = newTime;
  //     });
  //   }
  // }
  String? pelakFinal;

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  Duration initialtimer = new Duration();
  DateTime? _datePicked;
  TimeOfDay? _timePicked;

  File? _imageUser;
  String userImage = "";
  String? fileName;
  bool imageShow = false;

  // final picker = ImagePicker();
  // _getImageNemoneKar(ImageSource imageSource) async {
  //   XFile? imageFile = await picker.pickImage(source: imageSource);
  //   if (imageFile == null) return;
  //   setState(
  //     () {
  //       imageShow = true;
  //       _imageUser = File(imageFile.path);
  //       fileName = imageFile.path.split('/').last;
  //       imageFile.readAsBytes().then((value) {
  //         userImage = base64Encode((value));
  //       });
  //     },
  //   );
  // }

  var _selectedValue;
  var _selectedValue1;
  var _selectedValue2;
  List<String> gozaresh = [
    "تخلفات پرخطر",
    "تخلفات ترافیکی",
    "گزارشات شهروندی",
  ];
  List<String> anvagozaresh = [
    "سرعت غیرمجاز",
    "حرکات نمایشی",
    "حرکات مارپیچی",
  ];
  List<String> horof = [
    "ص",
    "الف",
    "ب",
    "د",
    "و",
  ];
  // DateTime today = DateTime.now();
  String? _dateStart = "";
  String? _format = 'yyyy-mm-dd';
  String? _valuePikerStart = '';

//   void _showDatePicker() {
//     final bool showTitleActions = false;
//     DatePicker.showDatePicker(context,
//         minYear: 1300,
//         maxYear: 1500,
// /*      initialYear: 1368,
//       initialMonth: 05,
//       initialDay: 30,*/
//         confirm: Text(
//           'تایید',
//           style: TextStyle(color: Colors.blue),
//         ),
//         cancel: Text(
//           'لغو',
//           style: TextStyle(color: Colors.red),
//         ),
//         dateFormat: _format, onChanged: (int? year, int? month, int? day) {
//       if (!showTitleActions) {
//         _changeDatetime(year, month, day);
//       }
//     }, onConfirm: (int? year, int? month, int? day) {
//       _changeDatetime(year, month, day);
//       _valuePikerStart =
//           " تاریخ ترکیبی : $_dateStart  \n سال : $year \n  ماه :   $month \n  روز :  $day";
//     });
//   }

  void _changeDatetime(int? year, int? month, int? day) {
    setState(() {
      _dateStart = '$year/$month/$day';
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    double mywidth = MediaQuery.of(context).size.width;
    final focus = FocusScope.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: Text('ثبت گزارش'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                      // onTap: () {
                      //   Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => GoogleMapPicker()))
                      //       .then((value) {
                      //     var m = value[0];
                      //     setState(() {
                      //       finalLocLat = m['finalLocLat'];
                      //       finalLocLong = m['finalLocLong'];
                      //     });
                      //   });
                      // },
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              finalLocLat != null
                                  ? Text(
                                      "موقعیت مکانی انتخاب شد" +
                                          "-" +
                                          finalLocLat!
                                              .toStringAsFixed(3)
                                              .toString() +
                                          "-" +
                                          finalLocLong!
                                              .toStringAsFixed(3)
                                              .toString(),
                                      // "موقعیت مکانی انتخاب شد" + "-" + finalLocLat.toString() + "-" + finalLocLong.toString(),
                                      style: TextStyle(
                                          color: Colors.lightBlue.shade900),
                                    )
                                  : Text("موقعیت مکانی"),
                              Icon(Icons.location_on_rounded,
                                  color: Colors.lightBlue.shade900)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: DropdownButtonFormField(
                            //   // value: _selectedValue,
                            //   iconEnabledColor: Colors.lightBlue.shade900,
                            //   decoration: InputDecoration(
                            //     // border: OutlineInputBorder(
                            //     //     borderRadius: BorderRadius.circular(0)),
                            //     border: InputBorder.none,
                            //   ),
                            //   hint: Text(
                            //     'نوع گزارش را انتخاب کنید',
                            //     style: TextStyle(
                            //         color: Colors.black.withOpacity(0.6),
                            //         fontSize: 17),
                            //   ),
                            //   isExpanded: true,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _selectedValue = value;
                            //     });

                            //     getgozareshid();
                            //   },

                            //   onSaved: (value) {
                            //     setState(() {
                            //       _selectedValue = value;
                            //     });
                            //   },

                            //   // items: gozaresh.map((var val) {
                            //   //   return DropdownMenuItem(
                            //   //     value: val,
                            //   //     child: Text(val),
                            //   //   );
                            //   // }).toList(),
                            //   items: getGozaresh.map((map) {
                            //     return DropdownMenuItem(
                            //       value: map,
                            //       child: Text(map.title),
                            //     );
                            //   }).toList(),
                            // ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            // child: DropdownButtonFormField(
                            //   key: _key,
                            //   // value: _selectedValue,
                            //   iconEnabledColor: Colors.lightBlue.shade900,
                            //   decoration: InputDecoration(
                            //     // border: OutlineInputBorder(
                            //     //     borderRadius: BorderRadius.circular(0)),
                            //     border: InputBorder.none,
                            //   ),
                            //   hint: Text(
                            //     'انواع گزارش',
                            //     style: TextStyle(
                            //         color: Colors.black.withOpacity(0.6),
                            //         fontSize: 17),
                            //   ),
                            //   isExpanded: true,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _selectedValue1 = value;
                            //     });

                            //     // getgozareshid();
                            //   },

                            //   onSaved: (value) {
                            //     setState(() {
                            //       _selectedValue1 = value;
                            //     });
                            //   },

                            //   items: getidgozaresh.map((map) {
                            //     return DropdownMenuItem(
                            //       value: map,
                            //       child: Text(map.title),
                            //     );
                            //   }).toList(),
                            //   // items: ostanList.map((map) {
                            //   //   return DropdownMenuItem(
                            //   //     value: map,
                            //   //     child: Text(map.states),
                            //   //   );
                            //   // }).toList(),
                            // ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('پلاک'),
                          ),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Container(
                            height: double.infinity,
                            width: mywidth * 0.18,
                            // color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length == 2) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  controller: p4_controller,
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 9, right: 10),
                                      counterText: '',
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              height: double.infinity,
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: mywidth * 0.26,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: TextFormField(
                                  focusNode: textSecondFocusNode,
                                  controller: p3_controller,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 6, right: 25),
                                      counterText: '',
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: mywidth * 0.18,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                // child: DropdownButtonFormField(
                                //   // value: _selectedValue,
                                //   iconEnabledColor: Colors.lightBlue.shade900,
                                //   decoration: InputDecoration(
                                //     // border: OutlineInputBorder(
                                //     //     borderRadius: BorderRadius.circular(0)),
                                //     border: InputBorder.none,
                                //   ),
                                //   hint: Text(
                                //     'حروف',
                                //     style: TextStyle(
                                //         color: Colors.black.withOpacity(0.6),
                                //         fontSize: 15),
                                //   ),
                                //   isExpanded: true,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       _selectedValue2 = value;
                                //     });

                                //     // getShahrList();
                                //   },

                                //   onSaved: (value) {
                                //     setState(() {
                                //       _selectedValue2 = value;
                                //     });
                                //   },

                                //   // items: horof.map((var val) {
                                //   //   return DropdownMenuItem(
                                //   //     value: val,
                                //   //     child: Container(
                                //   //       // color: Colors.red,
                                //   //       child: Center(child: Text(val))),
                                //   //   );
                                //   // }).toList(),
                                //   // items: horoff.map((map) {
                                //   //   return DropdownMenuItem(
                                //   //     value: map,
                                //   //     child: Text(map.title),
                                //   //   );
                                //   // }).toList(),
                                // ),
                              ),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: mywidth * 0.18,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: TextFormField(
                                  autofocus: true,
                                  controller: p1_controller,
                                  onChanged: (value) {
                                    if (value.length == 2) {
                                      FocusScope.of(context)
                                          .setFirstFocus(secondFocus);
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 9, right: 10),
                                      counterText: '',
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: myheight * 0.08,
                    // color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // _showDatePicker();
                            },
                            child: Container(
                              height: myheight,
                              width: mywidth * 0.46,
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      //  color:Colors.red,
                                      child: TextFormField(
                                        // controller: birth_date_controller,
                                        enabled: false,
                                        decoration: InputDecoration(
                                            enabled: false,
                                            //  hintText: 'تاریخ تولد' + _dateStart.toString(),
                                            hintText: _dateStart == ""
                                                ? _dateStart
                                                : _dateStart,
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Icon(Icons.date_range,
                                        color: Colors.lightBlue.shade900)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedTime(context);
                            },
                            child: Container(
                              height: myheight,
                              width: mywidth * 0.46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      //  color:Colors.red,
                                      child: TextFormField(
                                        // controller: birth_date_controller,
                                        enabled: false,
                                        decoration: InputDecoration(
                                            enabled: false,
                                            //  hintText: 'تاریخ تولد' + _dateStart.toString(),
                                            hintText: _timePicked != null
                                                ? ' ${_timePicked!.format(context)}'
                                                : "ساعت",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Icon(Icons.timer,
                                        color: Colors.lightBlue.shade900)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: myheight * 0.2,
                      // color: Colors.red,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: double.infinity,
                              width: mywidth * 0.46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // _getImageNemoneKar(ImageSource.gallery);
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        height: myheight * 0.04,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('انتخاب عکس'),
                                              Icon(
                                                Icons.image,
                                                color:
                                                    Colors.lightBlue.shade900,
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        // _getImageNemoneKar(ImageSource.gallery);
                                      },
                                      child: userImage == ''
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.image,
                                                  color: Colors.grey.shade300,
                                                  size: 50,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Image.file(
                                                _imageUser!,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              height: double.infinity,
                              width: mywidth * 0.46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: Column(
                                children: [
                                  Container(
                                      width: double.infinity,
                                      height: myheight * 0.04,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('انتخاب ویدیو'),
                                            Icon(
                                              Icons.video_camera_back,
                                              color: Colors.lightBlue.shade900,
                                            )
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.video_camera_back,
                                          color: Colors.grey.shade300,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        height: myheight * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextFormField(
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      hintText: "توضیحات",
                                      suffixIcon: Icon(Icons.description,
                                          color: Colors.lightBlue.shade900),
                                      border: InputBorder.none),
                                ),
                              )),
                        ),
                      )),
                ],
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    // add_taxalof();
                  },
                  child: Container(
                    height: myheight * 0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue.shade900,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'ثبت',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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

  final FocusScopeNode secondFocus = FocusScopeNode();
  final FocusNode treeFocus = FocusNode();

  FocusNode textSecondFocusNode = FocusNode();

  // var horoff = [];
  // var horoff_backup = [];
  // Future<void> getHorof() async {
  //   String _url = Helper.url + "takhalof/get_p2_list";
  //   var res = await Helper.getApiToken(_url);
  //   print(res);
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     var x = json.decode(res.body);
  //     horoff = x.map((e) => Horof.fromJson(e)).toList();
  //     setState(() {
  //       horoff = horoff;
  //       horoff_backup = horoff;
  //       // idGozaresh=getGozaresh.id
  //     });
  //   } else {
  //     print('x');
  //   }
  // }

  // var getGozaresh = [];
  // var getGozaresh_backup = [];
  // int? idGozaresh;
  // Future<void> getGozareshat() async {
  //   String _url = Helper.url + "takhalof/get_gozaresh_type_list";

  //   var res = await Helper.getApiToken(_url);
  //   print(res);
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     var x = json.decode(res.body);
  //     getGozaresh = x.map((e) => Gozaresh.fromJson(e)).toList();
  //     setState(() {
  //       getGozaresh = getGozaresh;
  //       getGozaresh_backup = getGozaresh;
  //       // idGozaresh=getGozaresh.id
  //     });
  //   } else {
  //     print('x');
  //   }
  // }

  // var getidgozaresh = [];
  // var getidgozaresh_backup = [];
  // void getgozareshid() async {
  //   String _url = Helper.url + "takhalof/get_takhalof_type_list";
  //   var body = json.encode({"gozaresh_type_id": _selectedValue.id});
  //   var res = await Helper.postApiToken(_url, body);
  //   print(res);
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     var x = json.decode(res.body);
  //     getidgozaresh = x.map((e) => Gozareshid.fromJson(e)).toList();
  //     setState(() {
  //       getidgozaresh = getidgozaresh;
  //       getidgozaresh_backup = getidgozaresh;
  //       _key.currentState!.reset();
  //     });
  //   } else {
  //     print('x');
  //   }
  // }

  // void add_taxalof() async {
  //   String url = Helper.url + "takhalof/sabt_takhalof";
  //   var body = json.encode({
  //     "takhalof_type_id": _selectedValue1!.id,
  //     "p1": p1_controller!.text,
  //     "p2": _selectedValue2!.title,
  //     "p3": p3_controller!.text,
  //     "p4": p4_controller!.text,
  //     "lat": finalLocLat,
  //     "long": finalLocLong,
  //     "description": description_controller!.text,
  //     "takhalof_date": _dateStart,
  //     "takhalof_time":
  //         (_timePicked!.hour.toString() + ':' + _timePicked!.minute.toString()),
  //     "image_name": "sa",
  //     "image": userImage
  //   });
  //   print(body);
  //   LoadingDialog.showloadigDialog(context);
  //   var res = await Helper.postApiToken(url, body);
  //   LoadingDialog.stopShowingDialog(context);
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     // showOKToast();
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Home()));

  //     // saveToken(json.decode(res.body));
  //   } else {
  //     showErrorToast();
  //   }
  // }

  // // void saveToken(var res) async {
  // //   SharedPreferences pref = await SharedPreferences.getInstance();
  // //   String getToken = res["token"];
  // //   pref.setString("token", getToken);
  // //   // print(res["token"]);
  // //   // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  // // }

  // // void showOKToast() {
  // //   Fluttertoast.showToast(
  // //       msg: "ثبت با موفقیت انجام شد.",
  // //       toastLength: Toast.LENGTH_SHORT,
  // //       gravity: ToastGravity.CENTER,
  // //       timeInSecForIosWeb: 1,
  // //       backgroundColor: Colors.blue.withOpacity(0.6),
  // //       textColor: Colors.white,
  // //       fontSize: 15);
  // // }

  // void showErrorToast() {
  //   Fluttertoast.showToast(
  //       msg: "خطا در ثبت کاربر",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.blue.withOpacity(0.6),
  //       textColor: Colors.white,
  //       fontSize: 15);
  // }

  // startDate(String x) {
  //   setState(() {
  //     _format = x.toString();
  //     // monasebat_date_controller.text = x.toString();
  //   });
  // }

  // var getaddress = [];
  // var getaddress_backup = [];
  // void getAddress() async {
  //   String _url = Helper.url + "takhalof/get_address_by_long_lat";
  //   var body =
  //       json.encode({"lat": _selectedValue.id, "long": _selectedValue.id});
  //   var res = await Helper.postApiToken(_url, body);
  //   print(res);
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     var x = json.decode(res.body);
  //     getidgozaresh = x.map((e) => Gozareshid.fromJson(e)).toList();
  //     setState(() {
  //       getidgozaresh = getidgozaresh;
  //       getidgozaresh_backup = getidgozaresh;
  //       _key.currentState!.reset();
  //     });
  //   } else {
  //     print('x');
  //   }
  // }
}
