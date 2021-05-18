import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerappdemo/models/playermodel.dart';
import 'package:providerappdemo/screens/playerview.dart';

void main(){
//  runApp(MaterialApp(
//    title: 'Provider Demo',
//    home: PlayerView(),
//  ));
  runApp(ChangeNotifierProvider(
    create: (ctx) => PlayerModel(),
    child: MaterialApp(
      title: 'Provider Example',
      home: PlayerView(),
    ),
  ));
}