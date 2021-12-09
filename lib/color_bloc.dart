import 'dart:async';
import 'package:flutter/material.dart';

enum ColorEvent { to_amber, to_light_blue }

class ColorBloc {
  // bikin variabel untuk simpan statenya, dalam hal ini adalah warnanya
  Color _color = Colors.amber;

// controller event
  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();
  // eventSink dibikin public supaya bisa dikonsumsi UI
  StreamSink<ColorEvent> get eventSink => _eventController.sink;

// diprivate karena di dalam mapEventToState
  StreamController<Color> _stateController = StreamController<Color>();
  StreamSink<Color> get _stateSink => _stateController.sink;
  // get = selangnya
  // Stream<Color> = ini adalah outputnya
  // stateStream dibikin public supaya bisa dikonsumsi UI
  // UI terima state yg terbaru
  Stream<Color> get stateStream => _stateController.stream;

  // kita bikin private karena di dalam
  // input yang masuk ke eventController akan diproses di dalam _mapeventToState
  void _mapEventToState(ColorEvent colorEvent) {
    // berdasarkan event yg dipilih, state akan diubah
    if (colorEvent == ColorEvent.to_amber) {
      _color = Colors.amber;
    } else {
      _color = Colors.lightBlue;
    }
    // state yang baru dimasukkan lagi ke dalam keran yang namanya stateSink
    _stateSink.add(_color);
  }

// untuk hubungin streamEventController ke method _mapEventToState, maka kita hubungkan di constructor bloc
  ColorBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

// fungsinya ngeberesin selang-selang tadi
// streamcontroller itu makan memori, kalo udah dipake lagi misal page ditutup atau bloc udah beres, colorbloc harus di dispose, kalo gak, si streamcontroller akan terus makan memori, aplikasi makin besar
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
