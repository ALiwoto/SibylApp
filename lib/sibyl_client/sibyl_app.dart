import 'package:flutter/material.dart';
import 'homepage/sibyl_homepage.dart';

class SibylApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) => 
		new SibylMaterialApp('1.0.0');
}

class SibylMaterialApp extends MaterialApp {
	SibylMaterialApp(this.sibylVersion) : super(
			title: 'Sibyl System',
			theme: ThemeData(
				primarySwatch: Colors.green,
				backgroundColor: Colors.black26,
			),
			darkTheme: ThemeData(
				primarySwatch: Colors.blueGrey,
				backgroundColor: Colors.black12,
				secondaryHeaderColor: Colors.deepPurple,
			),
			home: SibylHomePage(title: 'Sibyl System'),
		)
	{
		if (this.sibylVersion.isEmpty) {
			throw new Exception('Sibyl version should not be empty.');
		}
	}

	final String sibylVersion;

//	SibylMaterialApp operator +(SibylMaterialApp other) {
//		return null;
//	}
}
