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
        centerTitle: false,
        title: Text('App settings', style: Theme.of(context).textTheme.headline5!.merge(TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.brightness == Brightness.dark ? const Color(0xFFa8a7a8) : const Color(0XFF1C1C1C)),)),
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.language_outlined),
            title: Text('Language preferences'),
          ),
          RadioListTile<String>(
            title: const Text('Device\'s language'),
            groupValue: null, 
            value: 'default',
            onChanged: (value) {

            }, 
          ),
          RadioListTile<String>(
            title: const Text('Spanish'),
            groupValue: null, 
            value: 'es',
            onChanged: (value) {

            }, 
          ),
          RadioListTile<String>(
            title: const Text('English'),
            groupValue: null, 
            value: 'en',
            onChanged: (value) {

            }, 
          ),
          const ListTile(
            leading: Icon(Icons.wb_twilight_outlined),
            title: Text('Theme mode'),
          ),
          RadioListTile<String>(
            title: const Text('System default'),
            groupValue: null, 
            value: 'default',
            onChanged: (value) {

            }, 
          ),
          RadioListTile<String>(
            title: const Text('Dark mode'),
            groupValue: null, 
            value: 'dark_mode',
            onChanged: (value) {

            }, 
          ),
          RadioListTile<String>(
            title: const Text('Light mode'),
            groupValue: null, 
            value: 'light_mode',
            onChanged: (value) {

            }, 
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('App info'),
            subtitle: Text('Version, technologies, repository'),
          ),
        ],
      )
    );
  }
}