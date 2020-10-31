import 'package:flutter/material.dart';
import 'package:flutterprojectgitapi/class/Repository.dart';
import 'package:flutterprojectgitapi/class/UserInformation.dart';
import 'package:flutterprojectgitapi/viewModel/getUserInformation.dart';

class ShowUserRepository extends StatefulWidget {
  final UserInformation userInformation;

  ShowUserRepository({@required this.userInformation});

  @override
  _ShowUserRepositoryState createState() => _ShowUserRepositoryState();
}

class _ShowUserRepositoryState extends State<ShowUserRepository> {
  bool _loading = true;
  bool internetFail = false;
  List<Repository> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('show user repository'),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    if (internetFail) {
      return new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              'مشکلی در دریافت اطلاعات وجود دارد',
              style:
                  new TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            new MaterialButton(
              onPressed: () {
                _setData();
              },
              color: Colors.indigo,
              child: new Text(
                'تلاش مجدد',
                style: new TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return new Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: new ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.indigo[100]),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: new ListTile(
                  title: new Text(
                    'name: ' + data[index].name.toString(),
                    style: new TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  subtitle: new Text(
                    'fullname: ' + data[index].fullName.toString(),
                    style: new TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
              );
            }),
      );
    }
  }

  void _setData() async {
    setState(() {
      _loading = true;
      internetFail = false;
    });
    try {
      var result = await new GetUserInformation()
          .getUserRepos(userName: widget.userInformation.login);
      data = result;
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        internetFail = true;
      });
    }
  }
}
