// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with ClipboardListener {
  @override
  void initState() {
    clipboardWatcher.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
              child: const Text('start'),
              onPressed: () {
                clipboardWatcher.start();
              },
            ),
            ElevatedButton(
              child: const Text('stop'),
              onPressed: () {
                clipboardWatcher.stop();
              },
            ),
          ],
        )),
      ),
    );
  }

  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    print(newClipboardData?.text ?? "");
  }
}
