import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:provider/provider.dart';

class RosterRulesPage extends StatefulWidget {
  const RosterRulesPage({Key? key}) : super(key: key);

  @override
  _RosterRulesPageState createState() => _RosterRulesPageState();
}

class _RosterRulesPageState extends State<RosterRulesPage> {
  //String? _selection;

  _RosterRulesPageState() {
    this._totalNumberOfEmployees = new Map();

    _totalNumberOfEmployees.putIfAbsent("S", () => 10);
    _totalNumberOfEmployees.putIfAbsent("J", () => 10);
    _totalNumberOfEmployees.putIfAbsent("JS", () => 5); //JS
    _totalNumberOfEmployees.putIfAbsent("T", () => 0);

    _shiftedEmployees.putIfAbsent("NS", () => 1);
    _shiftedEmployees.putIfAbsent("NJ", () => 1);
    _shiftedEmployees.putIfAbsent("NT", () => 0);
    _shiftedEmployees.putIfAbsent("DS", () => 1);
    _shiftedEmployees.putIfAbsent("DJ", () => 1);
    _shiftedEmployees.putIfAbsent("DT", () => 0);
    _shiftedEmployees.putIfAbsent("ES", () => 1);
    _shiftedEmployees.putIfAbsent("EJ", () => 1);
    _shiftedEmployees.putIfAbsent("ET", () => 0);

    print("_totalNumberOfEmployees: " + _totalNumberOfEmployees.toString());

    ctext = _getText();
    _total = TextEditingController();
    _nightSin = TextEditingController();
    _nightJun = TextEditingController();
    _nightTri = TextEditingController();
    _daySin = TextEditingController();
    _dayJun = TextEditingController();
    _dayTri = TextEditingController();
    _evSin = TextEditingController();
    _evJun = TextEditingController();
    _evTri = TextEditingController();
    _maximumShiftCountInAWeek = TextEditingController();
    _maximumNightShiftInAWeek = TextEditingController();

    _total.text = ctext;
    _nightSin.text = _shiftedEmployees["NS"].toString();
    _nightJun.text = _shiftedEmployees["NJ"].toString();
    _nightTri.text = _shiftedEmployees["NT"].toString();
    _daySin.text = _shiftedEmployees["DS"].toString();
    _dayJun.text = _shiftedEmployees["DJ"].toString();
    _dayTri.text = _shiftedEmployees["DT"].toString();
    _evSin.text = _shiftedEmployees["ES"].toString();
    _evJun.text = _shiftedEmployees["EJ"].toString();
    _evTri.text = _shiftedEmployees["ET"].toString();

    _maxNightShift = 4;
    _maxShiftInAWeek = 5;
    _maximumShiftCountInAWeek.text = _maxShiftInAWeek.toString();
    _maximumNightShiftInAWeek.text = _maxNightShift.toString();
    _unitID = "UNIT_ID";
  }

  Map<String, int> _totalNumberOfEmployees = new Map();

  Map<String, int> _shiftedEmployees = new Map();

  int _maxNightShift = 0;
  int _maxShiftInAWeek = 0;
  String? _nightShiftMode;
  String _unitID = "";

  String _text = "0";

  List options = [
    '1. Night shift in priority',
    '2. Employees leave in priority'
  ];

  final _titleCtrlr = TextEditingController();

  TextEditingController _nightSin = TextEditingController();
  TextEditingController _nightJun = TextEditingController();
  TextEditingController _nightTri = TextEditingController();
  TextEditingController _daySin = TextEditingController();
  TextEditingController _dayJun = TextEditingController();
  TextEditingController _dayTri = TextEditingController();
  TextEditingController _evSin = TextEditingController();
  TextEditingController _evJun = TextEditingController();
  TextEditingController _evTri = TextEditingController();

  TextEditingController _maximumShiftCountInAWeek = TextEditingController();
  TextEditingController _maximumNightShiftInAWeek = TextEditingController();

  String ctext = "";

  TextEditingController _total = TextEditingController();

  Widget myRuleSetter({
    TextEditingController? controller,
    String? controllerType,
    String? labelText,
    Color primary = Colors.yellow,
  }) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        fontSize: 18,
        height: 2,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primary, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () => {
              if (controllerType == 'maxShiftCount')
                controller!.text = _getShiftCount(false).toString()
              else if (controllerType == 'maxNightShift')
                controller!.text = _getNightShiftEmployeeCount(false).toString()
              else if (controllerType == 'nightSeniors')
                controller!.text =
                    _controlEmployeeCount("S", "NS", false).toString()
              else if (controllerType == 'nightJuniors')
                controller!.text =
                    _controlEmployeeCount("J", "NJ", false).toString()
              else if (controllerType == 'nightTrainees')
                controller!.text =
                    _controlEmployeeCount("T", "NT", false).toString()
              else if (controllerType == 'morningSeniors')
                controller!.text =
                    _controlEmployeeCount("S", "DS", false).toString()
              else if (controllerType == 'morningJuniors')
                controller!.text =
                    _controlEmployeeCount("J", "DJ", false).toString()
              else if (controllerType == 'morningTrainees')
                controller!.text =
                    _controlEmployeeCount("T", "DT", false).toString()
              else if (controllerType == 'eveningSeniors')
                controller!.text =
                    _controlEmployeeCount("S", "ES", false).toString()
              else if (controllerType == 'eveningJuniors')
                controller!.text =
                    _controlEmployeeCount("J", "EJ", false).toString()
              else if (controllerType == 'eveningTrainees')
                controller!.text =
                    _controlEmployeeCount("T", "ET", false).toString()
            },
            child: Text('<'),
            //other properties
          ),
          Container(
            height: 50,
            width: 150,
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                  labelText: labelText, fillColor: Colors.black),
              textAlign: TextAlign.center,
              onChanged: (v) => setState(() {
                _text = v;
              }),
              controller: controller,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primary, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () => {
              if (controllerType == 'maxShiftCount')
                controller!.text = _getShiftCount(true).toString()
              else if (controllerType == 'maxNightShift')
                controller!.text = _getNightShiftEmployeeCount(true).toString()
              else if (controllerType == 'nightSeniors')
                controller!.text =
                    _controlEmployeeCount("S", "NS", true).toString()
              else if (controllerType == 'nightJuniors')
                controller!.text =
                    _controlEmployeeCount("J", "NJ", true).toString()
              else if (controllerType == 'nightTrainees')
                controller!.text =
                    _controlEmployeeCount("T", "NT", true).toString()
              else if (controllerType == 'morningSeniors')
                controller!.text =
                    _controlEmployeeCount("S", "DS", true).toString()
              else if (controllerType == 'morningJuniors')
                controller!.text =
                    _controlEmployeeCount("J", "DJ", true).toString()
              else if (controllerType == 'morningTrainees')
                controller!.text =
                    _controlEmployeeCount("T", "DT", true).toString()
              else if (controllerType == 'eveningSeniors')
                controller!.text =
                    _controlEmployeeCount("S", "ES", true).toString()
              else if (controllerType == 'eveningJuniors')
                controller!.text =
                    _controlEmployeeCount("J", "EJ", true).toString()
              else if (controllerType == 'eveningTrainees')
                controller!.text =
                    _controlEmployeeCount("T", "ET", true).toString()
            },
            child: Text('>'),
          ),
        ]),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //_totalNumberOfEmployees.putIfAbsent(key, () => null);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Rules'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.edit,
                    size: 30,
                  ),
                ),
                title: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Rule Name",
                  ),
                  controller: _titleCtrlr,
                ),
              ),
              ListTile(
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.alt_route_outlined,
                    size: 30,
                  ),
                ),
                title: DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  hint: Text("Select Night Shift Mode"),
                  value: _nightShiftMode,
                  onChanged: (value) {
                    setState(() {
                      _nightShiftMode = value.toString();
                    });
                  },
                  items: options.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              myRuleSetter(
                  controller: _maximumShiftCountInAWeek,
                  controllerType: 'maxShiftCount',
                  labelText: "Max continue shift "),
              myRuleSetter(
                  controller: _maximumNightShiftInAWeek,
                  controllerType: 'maxNightShift',
                  labelText: "Max Night shift ",
                  primary: Colors.purple),

              /// total employee
              DefaultTextStyle.merge(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 18,
                  height: 2,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 200,
                          child: TextField(
                            readOnly: true,
                            style: TextStyle(color: Colors.red),
                            decoration: new InputDecoration(
                              labelText: "Total employee ",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),

                            //text : "_getText( map )",
                            controller: _total,
                          ),
                        ),
                      ]),
                ),
              ),

              ///Night shift

              myRuleSetter(
                  controller: _nightSin,
                  controllerType: 'nightSeniors',
                  labelText: "Night Seniors",
                  primary: Colors.red),

              myRuleSetter(
                  controller: _nightJun,
                  controllerType: 'nightJuniors',
                  labelText: "Night Juniors",
                  primary: Colors.red),

              myRuleSetter(
                  controller: _nightTri,
                  controllerType: 'nightTrainees',
                  labelText: "Night Trainees",
                  primary: Colors.red),

              /// Morning shift

              myRuleSetter(
                  controller: _daySin,
                  controllerType: 'morningSeniors',
                  labelText: "Morning Seniors",
                  primary: Colors.green),

              myRuleSetter(
                  controller: _dayJun,
                  controllerType: 'morningJuniors',
                  labelText: "Morning Juniors",
                  primary: Colors.green),

              myRuleSetter(
                  controller: _dayTri,
                  controllerType: 'morningTrainees',
                  labelText: "Morning Trainees",
                  primary: Colors.green),

              /// evening shift

              myRuleSetter(
                  controller: _evSin,
                  controllerType: 'eveningSeniors',
                  labelText: "Evening Seniors",
                  primary: Colors.orange),

              myRuleSetter(
                  controller: _evJun,
                  controllerType: 'eveningJuniors',
                  labelText: "Evening Juniors",
                  primary: Colors.orange),

              myRuleSetter(
                  controller: _evTri,
                  controllerType: 'eveningTrainees',
                  labelText: "Evening Trainees",
                  primary: Colors.orange),

              ElevatedButton(
                onPressed: () => {
                  _uploadDataToServer(),
                },
                child: Text('UPLOAD RULES'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getText() {
    Map<String, int> totalMap = _totalNumberOfEmployees;
    Map<String, int> addedMap = _shiftedEmployees;

    int s = totalMap["S"]!,
        js = totalMap["JS"]!,
        j = totalMap["J"]!,
        t = totalMap["T"]!;

    int addedS = addedMap["NS"]! + addedMap["DS"]! + addedMap["ES"]!;
    int addedJ = addedMap["NJ"]! + addedMap["DJ"]! + addedMap["EJ"]!;
    int addedT = addedMap["NT"]! + addedMap["DT"]! + addedMap["ET"]!;

    int remainingValueS = s;
    int remainingValueSJ = js;
    int remainingValueJ = j;
    int remainingValueT = t;

    int seniorMaxValue = 0;
    int juniorMaxValue = 0;

    if (addedS > s) {
      remainingValueS = 0;
      seniorMaxValue = addedS - s;
    } else {
      remainingValueS = s - addedS;
    }
    if (addedJ > j) {
      remainingValueJ = 0;
      juniorMaxValue = addedJ - j;
    } else {
      remainingValueJ = j - addedJ;
    }

    remainingValueSJ = js - (seniorMaxValue + juniorMaxValue);
    remainingValueT = t - addedT;

    String result = "Senior : " +
        remainingValueS.toString() +
        " out of " +
        s.toString() +
        "\n" +
        "JuSen : " +
        remainingValueSJ.toString() +
        " out of " +
        js.toString() +
        "\n" +
        "Junior : " +
        remainingValueJ.toString() +
        " out of " +
        j.toString() +
        "\n" +
        "Trainee : " +
        remainingValueT.toString() +
        " out of " +
        t.toString();

    print("result : " + result);

    return result;
  }

  int _controlEmployeeCount(String parentField, String field, bool addOnField) {
    int totalEmployee = 0;
    int totalInSeniorJunior = 0;
    int addedEmployee = 0;

    totalInSeniorJunior = _totalNumberOfEmployees["JS"]!;
    totalEmployee = _totalNumberOfEmployees[parentField]!;

    int consumed = _shiftedEmployees["N" + parentField]! +
        _shiftedEmployees["D" + parentField]! +
        _shiftedEmployees["E" + parentField]!;

    int s = _totalNumberOfEmployees["S"]!;
    int j = _totalNumberOfEmployees["J"]!;
    int js = _totalNumberOfEmployees["JS"]!;

    int addedS = _shiftedEmployees["NS"]! +
        _shiftedEmployees["DS"]! +
        _shiftedEmployees["ES"]!;
    int addedJ = _shiftedEmployees["NJ"]! +
        _shiftedEmployees["DJ"]! +
        _shiftedEmployees["EJ"]!;

    addedEmployee = _shiftedEmployees[field]!;

    print("remainingEmployee: $totalEmployee");
    print("addedEmployee: $addedEmployee");
    print("totalInSeniorJunior: $totalInSeniorJunior");

    if (addOnField) {
      /// addition
      if ((totalEmployee - consumed) > 0) {
        addedEmployee++;
      } else if ((parentField == "S") || ((parentField == "J"))) {
        int incrementValueJ = 0;
        int incrementValueS = 0;

        if (addedJ > j) {
          incrementValueJ = addedJ - j;
        }
        if (addedS > s) {
          incrementValueS = addedS - s;
        }

        if (js > (incrementValueJ + incrementValueS)) {
          addedEmployee++;
        }
      }
    } else {
      /// subtraction
      if ((addedEmployee) > 0) {
        addedEmployee--;
      }
    }

    _shiftedEmployees[field] = addedEmployee;

    _total.text = _getText();

    return addedEmployee;
  }

  int _getNightShiftEmployeeCount(bool addOnField) {
    int currentValue = _maxNightShift;

    if (addOnField) {
      if (currentValue < 5) {
        currentValue++;
      }
    } else {
      if (currentValue > 3) {
        currentValue--;
      }
    }

    _maxNightShift = currentValue;
    return currentValue;
  }

  int _getShiftCount(bool addOnField) {
    int currentValue = _maxShiftInAWeek;

    if (addOnField) {
      if (currentValue < 6) {
        currentValue++;
      }
    } else {
      if (currentValue > 3) {
        currentValue--;
      }
    }

    _maxShiftInAWeek = currentValue;
    return currentValue;
  }

  Future<void> _uploadDataToServer() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('E005_Unit');

    // _shiftedEmployees.putIfAbsent("NS", () => 1);
    // _shiftedEmployees.putIfAbsent("NJ", () => 1);
    // _shiftedEmployees.putIfAbsent("NT", () => 0);
    // _shiftedEmployees.putIfAbsent("DS", () => 1);
    // _shiftedEmployees.putIfAbsent("DJ", () => 1);
    // _shiftedEmployees.putIfAbsent("DT", () => 0);
    // _shiftedEmployees.putIfAbsent("ES", () => 1);
    // _shiftedEmployees.putIfAbsent("EJ", () => 1);
    // _shiftedEmployees.putIfAbsent("ET", () => 0);

    String nightShiftModeValue = "NPM";
    if (_nightShiftMode == '2. Employees leave in priority') {
      nightShiftModeValue = "ELPM";
    }

    var data = {
      'day_shift_employee':
          'S:${_shiftedEmployees["DS"]},J:${_shiftedEmployees["DJ"]}',
      'evening_shift_employee':
          'S:${_shiftedEmployees["ES"]},J:${_shiftedEmployees["EJ"]}',
      'night_shift_employee':
          'S:${_shiftedEmployees["NS"]},J:${_shiftedEmployees["NJ"]}',
      'roster_rules': '1:$_maxNightShift,2:$_maxShiftInAWeek',
      "night_shift_mode": nightShiftModeValue
    };

    print("data: " + data.toString());

    users
        .doc(_unitID)
        .update(data)
        .then((value) => {print("to add user: ")})
        .catchError((error) => print("Failed to add user: $error"));
  }
}
