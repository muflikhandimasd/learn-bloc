import 'package:flutter/material.dart';
import 'package:learn_bloc/color_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ColorBloc bloc = ColorBloc();
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                bloc.eventSink.add(ColorEvent.to_amber);
              },
              backgroundColor: Colors.amber,
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                bloc.eventSink.add(ColorEvent.to_light_blue);
              },
              backgroundColor: Colors.lightBlue,
            )
          ],
        ),
        appBar: AppBar(
          title: Text('Bloc Tanpa Library'),
        ),
        body: Center(
          // StreamBuilder itu fungsinya untuk membuild widget setiap kali dia mendapat update dari stream
          child: StreamBuilder(
            stream: bloc.stateStream,
            initialData: Colors.amber,
            // kita bikin satu method yg nerima context lalu snapshotnya
            // snapshot = data yang dikirimkan dari si stream
            // setiap stream update, method builder akan dipanggil
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: 100,
                height: 100,
                // datanya akan berupa color. karena si statestreamnya adalah stream<Color>
                color: snapshot.data,
              );
            },
          ),
        ),
      ),
    );
  }
}
