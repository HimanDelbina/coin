class OlhcModel {
  OlhcModel({
    required this.time,
    this.open,
    this.high,
    this.low,
    this.close,
  });

  int time;
  double? open;
  double? high;
  double? low;
  double? close;


  factory OlhcModel.fromJson(List l){
    // DateTime? t = DateTime?.fromMillisecondsSinceEpoch(l[0]! * 1000) ;
    DateTime t = DateTime(2019,01,01);
    print(t.toString());
    return  OlhcModel(
        // time: t,
        // time: ,
        time: l[0] == null ? null : l[0]!,
        open: l[1] == null ? null : l[1]!,
        high: l[2] == null ? null : l[2]!,
        low: l[3] == null ? null : l[3]!,
        close: l[4] == null ? null : l[4]!,
      );
  }
  // factory OlhcModel.fromJson(List l) => OlhcModel(
  //       time: l[0] == null ? null :  DateTime?.fromMillisecondsSinceEpoch(l[0]! * 1000) ,
  //       open: l[1] == null ? null : l[1]!,
  //       high: l[2] == null ? null : l[2]!,
  //       low: l[3] == null ? null : l[3]!,
  //       close: l[4] == null ? null : l[4]!,
  //     );
}
