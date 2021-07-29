import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class RosterRulesPage extends StatefulWidget {
  const RosterRulesPage({Key? key}) : super(key: key);

  @override
  _RosterRulesPageState createState() => _RosterRulesPageState();
}

class _RosterRulesPageState extends State<RosterRulesPage> {
  String? _selection;

  List options = ['Option 1', 'Option 2'];

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
                    Icons.menu,
                    size: 30,
                  ),
                ),
                title: DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  hint: Text("Select Option"),
                  value: _selection,
                  onChanged: (value) {
                    setState(() {
                      _selection = value.toString();
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
