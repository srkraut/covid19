import 'package:corona/Models/brief.dart';

import 'package:flutter/material.dart';

import 'Network/server.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Tracker',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: MyHomePage(title: 'Covid-19 Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  covidService cvds = new covidService();
  Brief _brief = new Brief(confirmed: 0, deaths: 0, recovered: 0);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    return cvds.fetchbrief().then((brief) {
      setState(() => _brief = brief);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("COVID-19 Tracker By ITsoch"))),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView(children: [
            // body of above

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                //Confirmed
                Confirmed(brief: _brief),
                //Recovered
                Recovered(brief: _brief),

                //Deaths
                Deaths(brief: _brief),

                //Fatality Rate
                Rate(brief: _brief),
              ]),
            ),
          ])),
    );
  }
}

class Rate extends StatelessWidget {
  const Rate({
    Key key,
    @required Brief brief,
  })  : _brief = brief,
        super(key: key);

  final Brief _brief;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.network_check,
              size: 50,
              color: Colors.orange,
            ),
            title: Text('Fatality rate'),
            subtitle: Text(
                (((_brief.deaths / _brief.confirmed) * 100).toStringAsFixed(2))
                    .toString(),
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
          ),
        ],
      ),
    );
  }
}

class Deaths extends StatelessWidget {
  const Deaths({
    Key key,
    @required Brief brief,
  })  : _brief = brief,
        super(key: key);

  final Brief _brief;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.airline_seat_flat,
              size: 50,
              color: Colors.red,
            ),
            title: Text('Deaths'),
            subtitle: Text(_brief.deaths.toString(),
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
          ),
        ],
      ),
    );
  }
}

class Recovered extends StatelessWidget {
  const Recovered({
    Key key,
    @required Brief brief,
  })  : _brief = brief,
        super(key: key);

  final Brief _brief;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.local_hospital,
              size: 50,
              color: Colors.green,
            ),
            title: Text('Recovered'),
            subtitle: Text(_brief.recovered.toString(),
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
          ),
        ],
      ),
    );
  }
}

class Confirmed extends StatelessWidget {
  const Confirmed({
    Key key,
    @required Brief brief,
  })  : _brief = brief,
        super(key: key);

  final Brief _brief;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.people,
              size: 50,
              color: Colors.blue,
            ),
            title: Text('Confirmed'),
            subtitle: Text(_brief.confirmed.toString(),
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
          ),
        ],
      ),
    );
  }
}
