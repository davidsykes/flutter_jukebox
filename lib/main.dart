import 'package:flutter/material.dart';
import 'package:flutter_jukebox/homepage.dart';
import 'package:flutter_jukebox/potentiallibrary/widgets/futurebuilder.dart';
import 'package:flutter_jukebox/tests/alltests.dart';
import 'dependencies.dart';
import 'potentiallibrary/testframework/testresults.dart';
import 'webaccess/jukeboxdatabaseapiaccess.dart';
import 'webaccess/mp3playeraccess.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var dependencies = Dependencies();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Lynda\'s Super Jukebox',
        mp3PlayerAccess: dependencies.mp3PlayerAccess,
        jukeboxDatabaseApiAccess: dependencies.jukeboxDatabaseApiAccess,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.mp3PlayerAccess,
      required this.jukeboxDatabaseApiAccess});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final IMP3PlayerAccess mp3PlayerAccess;
  final IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var selectedIndex = 4;
  var testResults = AllTests().runTests();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page =
            HomePage(widget.mp3PlayerAccess, widget.jukeboxDatabaseApiAccess);
        break;
      case 1:
        page = const Text('TO DO');
        break;
      case 2:
        page = const Text('TO DO2');
        break;
      case 3:
        page = Text(_counter.toString());
        break;
      case 4:
        page = createFutureBuilder(testRunner, testPageMaker);
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.amber,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: true,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home 222'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('TO DO'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('TO DO'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('TO DO'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Tests'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<TestResults> testRunner() {
    return AllTests().runTests();
  }

  Widget testPageMaker(TestResults results) {
    return Text(results.summary);
  }
}
