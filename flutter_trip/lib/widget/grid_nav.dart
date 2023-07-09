 import 'package:flutter/material.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class GridView extends StatelessWidget {

  final GridNavModel gridNavModel;

   const GridView({super.key, required this.gridNavModel});

   @override
   Widget build(BuildContext context) {
     return Text('GridNav');
   }
 }
