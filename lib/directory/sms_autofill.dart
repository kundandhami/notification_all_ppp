import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

class AutoFill extends StatefulWidget {
  const AutoFill({Key? key}) : super(key: key);

  @override
  State<AutoFill> createState() => _AutoFillState();
}

class _AutoFillState extends State<AutoFill> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto Fill SMS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final signature = await SmsAutoFill().getAppSignature;
                print("signcode---$signature");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewAutoFill(),
                    ));
                // otpSendPhone(otp: '123654');
              },
              child: Text("Send OTP"),
            ),
            SizedBox(
              height: 50,
            ),
            CupertinoButton(
                child: Text("date"),
                onPressed: () {
                  print("oh");
                }),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: CupertinoDatePicker(
                backgroundColor: Colors.white,
                initialDateTime: DateTime.now(),
                maximumDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  print(value);
                  DateTime pick = value;
                  a = (pick.difference(DateTime.now()).inDays) / 365;
                  print(a.floor());
                  data = a <= -18;
                  print(data);
                  setState(() {});
                },
              ),
            ),
            data
                ? Text("you are ${a.floor().abs()} year old")
                : Text(
                    "you are not use this appp",
                    style: TextStyle(color: Colors.red),
                  )
          ],
        ),
      ),
    );
  }

  double a = 0;
  bool data = false;
  String sms = "";

  Future<dynamic> otpSendPhone({required String otp}) async {
    final response = await http.get(Uri.parse(
        "http://api.msg91.com/api/sendotp.php?authkey=384544AWmJZcjsf6371c9f4P1&mobiles=919512829152&message=Activation code for Uday Sales. Your Account Activation Code: $otp&sender=UDAYSA&DLT_TE_ID=1207167851294968855&otp=$otp"));
    var res = response.body;
    print("====$res");
    return res;
  }
}

List month = [
  "Jan",
  'Feb',
  "Mar",
  "Apr",
  "May",
  "Jun",
  'Jul',
  "Aug",
  "Sep",
  'Oct',
  'Nov',
  'Dec'
];
List year = [
  1971,
  1972,
  1973,
  1974,
  1975,
  1976,
  1977,
  1978,
  1979,
  1980,
  1981,
  1982,
  1983,
  1984,
  1985,
  1986,
  1987,
  1988,
  1989,
  1990,
  1991,
  1992,
  1993,
  1994,
  1995,
  1996,
  1997,
  1998,
  1999,
  2000,
  2001,
  2002,
  2003,
  2004,
  2005,
  2006,
  2007,
  2008,
  2009,
  2010,
  2011,
  2012,
  2013,
  2014,
  2015,
  2016,
  2017,
  2018,
  2019,
  2020,
  2021,
  2022,
  2023,
  2024,
  2025,
  2026,
  2027,
  2028,
  2029,
  2030,
  2031,
  2032,
  2033,
  2034,
  2035,
  2036,
  2037,
  2038,
  2039,
  2040
];
List date = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31
];

class NewAutoFill extends StatefulWidget {
  NewAutoFill({
    Key? key,
  }) : super(key: key);

  @override
  State<NewAutoFill> createState() => _NewAutoFillState();
}

class _NewAutoFillState extends State<NewAutoFill> with CodeAutoFill {
  @override
  void initState() {
    super.initState();

    listenCode();
  }

  void listenCode() async {
    SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  String codes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: PinFieldAutoFill(
              textInputAction: TextInputAction.done,
              decoration: UnderlineDecoration(
                  colorBuilder: FixedColorBuilder(Colors.transparent),
                  bgColorBuilder:
                      FixedColorBuilder(Colors.grey.withOpacity(.2))),
              onCodeSubmitted: (code) {},
              codeLength: 6,
              currentCode: codes,
              onCodeChanged: (code) {
                print(code);
              },
            ),
          ),
          ElevatedButton(onPressed: listenCode, child: Text("Resend"))
        ],
      ),
    );
  }

  @override
  void codeUpdated() {}
}
