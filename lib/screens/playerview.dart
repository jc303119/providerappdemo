import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerappdemo/models/playermodel.dart';
import 'package:providerappdemo/screens/playeredit.dart';
class PlayerView extends StatefulWidget {
  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  final GlobalKey<ScaffoldState> skey = new GlobalKey<ScaffoldState>();
  String name = '';
  String photo = 'https://3team.cricket/images/png/header_2_dop.png';
  moveToNextScreen(){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => PlayerEdit()));
  }
  getDataFromServer(){
    PlayerModel playerModel = Provider.of<PlayerModel>(context, listen: false);
    playerModel.loadFromServer();
    showSnackBar("Data is coming from the server");
  }

  shareData() {
    String myData = tc.text;
    PlayerModel playerModel = Provider.of<PlayerModel>(context, listen: false);
    playerModel.player.desc = myData;
    showSnackBar('Data has been shared....');
  }
  showSnackBar(String msg){
    skey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }
  TextEditingController tc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skey,
      appBar: AppBar(title: Text('Player View'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              moveToNextScreen();
            },
            icon: Icon(
              Icons.forward,
              size: 30, color:
            Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Fetch'),
              onPressed: (){
                getDataFromServer();
              },
            ),
            Consumer<PlayerModel>(
              builder: (context, playerModelObject, child){
                return Column(
                  children: <Widget>[
                    Container(
                      child: Image.network(playerModelObject.player.photo??photo),
                      width: 300,
                      height: 300,
                    ),
                    Text('Name is ${playerModelObject.player.name??name}'),
                  ],
                );
              },
            ),
            TextField(
              controller: tc,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Type to Share'),
            ),
            RaisedButton(
              onPressed: () {
                shareData();
              },
              child: Text('Send Data to Another Screen'),
            )
          ],
        ),
      ),
    );
  }
}
