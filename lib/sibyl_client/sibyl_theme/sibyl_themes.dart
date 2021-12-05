import 'package:flutter/material.dart';

ThemeData getSibylLightTheme() {
	return new ThemeData(
		primarySwatch: Colors.green,
		brightness: Brightness.light,
		backgroundColor: Colors.black26,
	);
}


ThemeData getSibylDarkTheme() {
	return new ThemeData(
		brightness: Brightness.dark,
		primarySwatch: Colors.blueGrey,
		backgroundColor: Colors.black12,
		secondaryHeaderColor: Colors.deepPurple,
	);
}
