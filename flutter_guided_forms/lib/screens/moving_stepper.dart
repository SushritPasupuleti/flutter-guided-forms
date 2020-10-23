import 'package:flutter/material.dart';

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>()
];

class MovingStepper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovingStepperScreenMode();
  }
}

class MyData {
  String name = '';
  String phone = '';
  String email = '';
  String age = '';
}

class MovingStepperScreenMode extends State<MovingStepper> {
  @override
  Widget build(BuildContext context) {
    return  StepperBody();
  }
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int _current;
  bool _nameError = false;
  List<StepState> _listState;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static MyData data = MyData();

  @override
  void initState() {
    _current = 0;
    _listState = [
      StepState.indexed,
      StepState.editing,
      StepState.complete,
      StepState.error,
    ];
    super.initState();
  }

  List<Step> _createSteps(BuildContext context) {
    List<Step> _steps = <Step>[
      new Step(
        // state: _current == 0
        //     ? _listState[1]
        //     : _current > 0 ? _listState[2] : _listState[0],
        state: _current == 0
            ? (_listState[1])
            : (_current > 0
                ? (_nameError ? (_listState[3]) : (_listState[2]))
                : _listState[0]),
        title: new Text('Step 1'),
        //subtitle: new Text('Description of Step 1'),
        content: Form(
          key: formKeys[0],
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {
                  data.name = value;
                  debugPrint("Saving");
                },
                maxLines: 1,
                //initialValue: 'Aseem Wangoo',
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    //_setNameError(true);
                    return 'Please enter name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Enter your name',
                    hintText: 'Enter a name',
                    //filled: true,
                    icon: const Icon(Icons.person),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
            ],
          ),
        ),
        isActive: true,
      ),
      new Step(
        state: _current == 1
            ? _listState[1]
            : _current > 1
                ? _listState[2]
                : _listState[0],
        title: new Text('Step 2'),
        //subtitle: new Text('Description of Step 2'),
        content: Form(
          key: formKeys[1],
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.phone,
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty || value.length < 10) {
                    return 'Please enter valid number';
                  }
                },
                onSaved: (String value) {
                  data.phone = value;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: 'Enter your number',
                    hintText: 'Enter a number',
                    icon: const Icon(Icons.phone),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
            ],
          ),
        ),
        isActive: true,
      ),
      new Step(
        state: _current == 2
            ? _listState[1]
            : _current > 2
                ? _listState[2]
                : _listState[0],
        title: new Text('Step 3'),
        //subtitle: new Text('Description of Step 3'),
        content: new Text('Do Something'),
        isActive: true,
      ),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    List<Step> _stepList = _createSteps(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Stepper Example'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Expanded(
                child: Stepper(
                  type: StepperType.horizontal,
                  steps: _stepList,
                  currentStep: _current,
                  onStepContinue: () {
                    setState(() {
                      if (formKeys[_current].currentState.validate()) {
                        if (_current < _stepList.length - 1) {
                          _current = _current + 1;
                          if (_current == 1) {
                            print('First Step False');
                            //print('object' + FocusScope.of(context).toStringDeep());
                            setState(() {
                              _nameError = false;
                            });
                          }
                        } else {
                          _current = 0;
                        }
                      } else {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('$_current')));

                        if (_current == 0) {
                          print('First Step True');
                          //print('object' + FocusScope.of(context).toStringDeep());
                          setState(() {
                            _nameError = true;
                          });
                        }
                      }
                    });
                  },
                  onStepCancel: () {
                    setState(() {
                      if (_current > 0) {
                        _current--;
                      } else {
                        _current = 0;
                      }
                      //_setStep(context);
                    });
                  },
                  onStepTapped: (int i) {
                    setState(() {
                      _current = i;
                    });
                    setState(() {
                      if (formKeys[_current].currentState.validate()) {
                        //_current = _current + 1;
                        if (_current == 1) {
                          print('First Step False');
                          //print('object' + FocusScope.of(context).toStringDeep());
                          setState(() {
                            _nameError = false;
                          });
                        }
                      } else {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('$_current')));

                        if (_current == 0) {
                          print('First Step True');
                          //print('object' + FocusScope.of(context).toStringDeep());
                          setState(() {
                            _nameError = true;
                          });
                        }
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
