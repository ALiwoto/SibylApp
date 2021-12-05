import 'package:flutter/material.dart';
import 'package:sibyl_app/sibyl_client/sibyl_theme/sibyl_themes.dart';
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
			theme: getSibylLightTheme(),
			darkTheme: getSibylDarkTheme(),
			home: SibylHomePage(title: 'Sibyl System'),
		)
	{
		if (this.sibylVersion.isEmpty) {
			throw new Exception('Sibyl version should not be empty.');
		}
	}

	final String sibylVersion;
}
