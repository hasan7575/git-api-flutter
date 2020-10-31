import 'package:flutter/material.dart';
import 'package:flutterprojectgitapi/class/UserInformation.dart';
import 'package:flutterprojectgitapi/view/showUserRepos.dart';

// ignore: must_be_immutable
class ShowUserInformation extends StatelessWidget {
  final UserInformation userInformation;

  ShowUserInformation({@required this.userInformation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('show user information'),
    );
  }

  Widget _buildBody(BuildContext context) {
    // ignore: non_constant_identifier_names
    List Keys = userInformation.toJson().keys.toList();
    List values = userInformation.toJson().values.toList();
    return new Container(
      child: new ListView.builder(
          itemCount: userInformation.toJson().length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              shape: RoundedRectangleBorder(
                side: new BorderSide(
                    color: Colors.indigo[100]
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 2,
              child: new ListTile(
                title: new Text(
                  Keys[index].toString(),
                  style: new TextStyle(fontSize: 13,color: Colors.black),
                ),
                subtitle: new Text(
                  values[index].toString().toString(),
                  style: new TextStyle(fontSize: 13,color: Colors.black54),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return new FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return new ShowUserRepository(userInformation: userInformation);
        }));

      },
      child: new Icon(Icons.navigation),
    );
  }
}
