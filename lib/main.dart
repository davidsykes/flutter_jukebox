import 'package:flutter/material.dart';
import 'package:flutter_jukebox/pages/homepage/homepage.dart';
import 'package:flutter_jukebox/potentiallibrary/widgets/futurebuilder.dart';
import 'package:flutter_jukebox/tests/alltests.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';
import 'dependencies.dart';
import 'pages/logspage/logspage.dart';
import 'pages/searchpage/searchpage.dart';
import 'potentiallibrary/testframework/testresults.dart';
import 'version.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: Version().mainTitle(),
        mp3PlayerAccess: dependencies.mp3PlayerAccess,
        jukeboxDatabaseApiAccess: dependencies.jukeboxDatabaseApiAccess,
        microServiceController: dependencies.microServiceController,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.mp3PlayerAccess,
    required this.jukeboxDatabaseApiAccess,
    required this.microServiceController,
  });

  final String title;
  final IMP3PlayerAccess mp3PlayerAccess;
  final IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
  final IMicroServiceController microServiceController;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _shouldSidebarBeExpanded = false;
  var selectedIndex = Version().version.selectedTabOnStartUp;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _shouldSidebarBeExpanded = !_shouldSidebarBeExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage(widget.mp3PlayerAccess, widget.jukeboxDatabaseApiAccess,
            widget.microServiceController);
        break;
      case 1:
        page = SearchPage(widget.microServiceController);
        break;
      case 2:
        page = const LogsPage();
        break;
      case 3:
        page = Text(_counter.toString());
        break;
      case 4:
        page = createFutureBuilder(
            dataFetcher: testRunner(), pageMaker: testPageMaker);
        break;
      default:
        throw AssertionError('no widget for main page index $selectedIndex');
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
              extended: shouldSideBarBeExtended(),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.library_music),
                  label: Text('Home 23'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.find_in_page),
                  label: Text('T Search'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history),
                  label: Text('Logs'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('TO DO'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.question_mark),
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
    var widgets = List<Widget>.empty(growable: true);
    widgets.add(Text(results.summary));
    widgets.addAll(results.results.map((e) => Text(e)));
    return Column(
      children: widgets,
    );
  }

  bool shouldSideBarBeExtended() {
    return _shouldSidebarBeExpanded;
  }
}
