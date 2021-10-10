import 'package:flutter/material.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({ Key? key }) : super(key: key);

  @override
  _EndDrawerState createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.close), 
                color: Theme.of(context).iconTheme.color,
                iconSize: Theme.of(context).iconTheme.size!,
                onPressed: (){ Navigator.of(context).pop(); }
                ),
            ),
          )
        ],
        centerTitle: true,
        title: Text('Settings', style: Theme.of(context).textTheme.headline6,),
      )
    );
  }
}