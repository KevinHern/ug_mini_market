import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFfff3e6),
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(
            'Flutter SP2',
            style: TextStyle(color: Colors.black.withOpacity(0.80)),
          ),
          backgroundColor: Color(0xFF00bcd4),
          leading: Icon(
            Icons.home,
            color: Colors.black.withOpacity(0.80),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Card(
              child: Text(
                'Titulo',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Card(
              child: Text('Aqui un gran parrafote'),
            ),
            SizedBox(
              height: 12.0,
            ),
            Divider(
              color: Colors.black.withOpacity(0.65),
            ),
            SizedBox(
              height: 12.0,
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.settings_cell),
                title: Text('Texto 1'),
                trailing: Icon(Icons.add),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.monitor),
                title: Text('Texto 2'),
                trailing: Icon(Icons.add),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Divider(
              color: Colors.black.withOpacity(0.65),
            ),
            SizedBox(
              height: 12.0,
            ),
            FlutterLogo(
              size: 100,
            ),
            SizedBox(
              height: 12.0,
            ),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.info),
                label: Text('Presiona aquí'))
          ],
        ),
      ),
    );
  }
}
