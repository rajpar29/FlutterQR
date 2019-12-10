import 'dart:async';

import 'package:flutter/material.dart';


class AssetHistory extends StatefulWidget {
  final String assetId;

  AssetHistory(this.assetId);
  int _index = 0;

  @override
  _AssetHistoryState  createState() => _AssetHistoryState ();
}

class _AssetHistoryState extends State<AssetHistory> {


  List assets = [
    {
      'id': "123456",
      'name': "basmati Rice",
      'owner': 'raju',
      'ctype': 'rice',
      'grownBy': 'raju',
      'methodUsed': 'organic',
      'productionPlace': 'Amreli'
    },
    {
      'id': "222222",
      'name': "Wheat",
      'owner': 'Raju Parlia',
      'methodUsed': 'Non-organic',
      'ctype': 'whole Grain',
      'grownBy': 'Shyam',
    'productionPlace': 'Nimbahera'
    },
    {
      'id': "559875",
      'name': "Oats",
      'owner': 'Ramu',
      'methodUsed': 'organic',
      'ctype': 'Whole Grain',
      'grownBy': 'Ghanshyam',
    'productionPlace': 'Vadodara'
    }
  ];

  @override
  Widget build(BuildContext context) {
    var assetObj;


    assets.forEach((asset) {
      if (asset['id'] == widget.assetId) {
        assetObj = asset;
      }
    });
    List<Step> steps = [];
    assetObj.keys.forEach((key) => steps.add(
        Step(title: Text(key + ' : ' + assetObj[key]), content: Container())));
    print(steps);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Asset History"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stepper(

          steps: steps,
          controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
              Container(),
          currentStep: widget._index,
          onStepTapped: (index) {
            print(index);
            setState(() {
              widget._index = index;
            });
          },
        ),
      ),
    );
  }
}
