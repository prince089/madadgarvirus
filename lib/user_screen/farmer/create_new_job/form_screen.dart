// import 'package:flutter/material.dart';
//
// class FormScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return FormScreenState();
//   }
// }
//
// class FormScreenState extends State<FormScreen> {
//   String _myActivity = '';
//   String _myActivityResult = '';
//   _saveForm() {
//     var form = _formKey.currentState;
//     if (form.validate()) {
//       form?.save();
//       setState(() {
//         _myActivityResult = _myActivity;
//       });
//     }
//   }
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dropdown Formfield Example'),
//       ),
//       body: Center(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child: DropDownFormField(
//                   titleText: 'My workout',
//                   hintText: 'Please choose one',
//                   value: _myActivity,
//                   onSaved: (value) {
//                     setState(() {
//                       _myActivity = value;
//                     });
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       _myActivity = value;
//                     });
//                   },
//                   dataSource: [
//                     {
//                       "display": "Running",
//                       "value": "Running",
//                     },
//                     {
//                       "display": "Climbing",
//                       "value": "Climbing",
//                     },
//                     {
//                       "display": "Walking",
//                       "value": "Walking",
//                     },
//                     {
//                       "display": "Swimming",
//                       "value": "Swimming",
//                     },
//                     {
//                       "display": "Soccer Practice",
//                       "value": "Soccer Practice",
//                     },
//                     {
//                       "display": "Baseball Practice",
//                       "value": "Baseball Practice",
//                     },
//                     {
//                       "display": "Football Practice",
//                       "value": "Football Practice",
//                     },
//                   ],
//                   textField: 'display',
//                   valueField: 'value',
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: RaisedButton(
//                   child: Text('Save'),
//                   onPressed: _saveForm,
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 child: Text(_myActivityResult),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
