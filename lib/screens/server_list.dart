import 'package:flutter/material.dart';
import 'package:validator/validator.dart';
import 'webview_login.dart';

class ServerList extends StatefulWidget {
  @override
  createState() => new ServerListState();
}

class ServerListState extends State<ServerList> {
  final formKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  String server;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _performLogin();
    }
  }

  void _performLogin() async {

    debugPrint("Server: $server");

    final code = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new WebviewLogin(server)),
    );

    debugPrint("Code $code");

    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text('Code: $code'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('Connect to server'),
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.vpn_key),
              title: new Text('Server 1'),
              trailing: new Icon(Icons.edit),
            ),
            new ListTile(
              leading: new Icon(Icons.vpn_key),
              title: new Text('Server 2'),
              trailing: new Icon(Icons.edit),
            ),
            new ListTile(
              leading: new Icon(Icons.vpn_key),
              title: new Text('Server 3'),
              trailing: new Icon(Icons.edit),
            ),
            new ListTile(
                leading: new Icon(Icons.add_circle_outline),
                title: new Form(
                  key: formKey,
                  child: new Column(
                    children: [
                      new TextFormField(
                        decoration: new InputDecoration(
                            labelText: 'Link to new server'),
                        validator: (val) {
                          if (!isURL(val.toLowerCase(), {
                            'protocols': ['http', 'https']
                          })) {
                            return 'Link is not a valid URL';
                          }
                          return null;
                        },
                        onSaved: (val) => server = val,
                        keyboardType: TextInputType.url,
                      ),
                    ],
                  ),
                ),
                trailing: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () {
                      _submit();
                    })),
          ],
        ));
  }
}
