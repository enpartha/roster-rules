import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class RosterRulesPage extends StatefulWidget {
  const RosterRulesPage({Key? key}) : super(key: key);

  @override
  _RosterRulesPageState createState() => _RosterRulesPageState();
}

class _RosterRulesPageState extends State<RosterRulesPage> {
  //String? _selection;
  String? _day_shift_employee;
  String? _evening_shift_employee;
  String? _night_shift_employee;
  String? _roster_rules;
  String? _night_shift_mode;
  String? _shift_duration_map;


  List options = ['1. Night shift in priority', '2. Employees leave in priority'];

  final _titleCtrlr = TextEditingController();
  final _numCtrlr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  value: _night_shift_mode,
                  onChanged: (value) {
                    setState(() {
                      _night_shift_mode = value.toString();
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
              ListTile(
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.collections,
                    size: 30,
                  ),
                ),
                title: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Number Input",
                  ),
                  controller: _numCtrlr,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
