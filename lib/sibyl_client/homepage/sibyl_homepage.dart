
import 'package:flutter/material.dart';
import 'package:sibyl_app/core/sibyl_core.dart';

class SibylHomePage extends StatefulWidget {
	SibylHomePage({Key? key, required this.title}) : super(key: key);

	// This widget is the home page of your application. It is stateful, meaning
	// that it has a State object (defined below) that contains fields that affect
	// how it looks.

	// This class is the configuration for the state. It holds the values (in this
	// case the title) provided by the parent (in this case the App widget) and
	// used by the build method of the State. Fields in a Widget subclass are
	// always marked "final".

	final String title;

	@override
	_SibylHomePageState createState() => _SibylHomePageState();
}

class _SibylHomePageState extends State<SibylHomePage> {
	//int _counter = 0;

	void _incrementCounter() {
		setState(() {
			// This call to setState tells the Flutter framework that something has
			// changed in this State, which causes it to rerun the build method below
			// so that the display can reflect the updated values. If we changed
			// _counter without calling setState(), then the build method would not be
			// called again, and so nothing would appear to happen.
		 // _counter++;
		});
	}

	@override
	Widget build(BuildContext context) {
		// This method is rerun every time setState is called, for instance as done
		// by the _incrementCounter method above.
		//
		// The Flutter framework has been optimized to make rerunning build methods
		// fast, so that you can just rebuild anything that needs updating rather
		// than having to individually change instances of widgets.
		return _onSibylUpdate(context);
	}

	Widget _onSibylUpdate(BuildContext context) {
		// check if sibyl client is already initialized or not;
		// if not, let the user enters their token.
		if (sibylClient == null) {
			return SibylFirstScaffold.buildFirstScaffold(context, widget);
		}

		return SibylFirstScaffold.buildFirstScaffold(context, widget);
	}
}

class SibylFirstScaffold extends Scaffold {
	SibylFirstScaffold(BuildContext context, SibylHomePage widget) : 
	super(
			appBar: AppBar(
				// Here we take the value from the MyHomePage object that was created by
				// the App.build method, and use it to set our appbar title.
				title: Text(widget.title, textAlign: TextAlign.center),
			),
			body: Center(
				// Center is a layout widget. It takes a single child and positions it
				// in the middle of the parent.
				child: Column(
					// Column is also a layout widget. It takes a list of children and
					// arranges them vertically. By default, it sizes itself to fit its
					// children horizontally, and tries to be as tall as its parent.
					//
					// Invoke "debug painting" (press "p" in the console, choose the
					// "Toggle Debug Paint" action from the Flutter Inspector in Android
					// Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
					// to see the wireframe for each widget.
					//
					// Column has various properties to control how it sizes itself and
					// how it positions its children. Here we use mainAxisAlignment to
					// center the children vertically; the main axis here is the vertical
					// axis because Columns are vertical (the cross axis would be
					// horizontal).
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(
							'Welcome to Sibyl System!',
							style: Theme.of(context).textTheme.headline4,
						),
						Text(
							"Please enter your login token:",
							style: Theme.of(context).textTheme.headline5,
						),
						TextField(
							textDirection: TextDirection.ltr,
							enableSuggestions: false,
							style: Theme.of(context).textTheme.headline6,
							textAlign: TextAlign.center,
							autocorrect: false,
						),
					],
				),
			),
			//floatingActionButton: FloatingActionButton(
			//	onPressed: _incrementCounter,
			//	tooltip: 'Increment',
			//	child: Icon(Icons.assignment_turned_in_rounded),
			//), // This trailing comma makes auto-formatting nicer for build methods.
		);

	static SibylFirstScaffold buildFirstScaffold(BuildContext context, SibylHomePage widget) {
		return SibylFirstScaffold(context, widget);
	}
}
