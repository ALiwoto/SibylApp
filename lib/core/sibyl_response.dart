

import 'package:sibyl_app/core/sibyl_results.dart';

class SibylResponse<T extends SibylResultable> {
	final bool success;
	final T? result;
	final SibylError? error;

	const SibylResponse(this.success, this.result, this.error);


	static SibylResponse fromJson<T extends SibylResultable>(final Map<String, dynamic> value) {
		return SibylResponse(
			value['success'] as bool,
			SibylResultable.fromJson<T>(value['result']),
			SibylError.fromJson(value['error']),
		);
	}
	
}

class SibylError implements Exception {
	final int code;
	final String message;
	final String origin;
	final String date;

	const SibylError({
		this.code = 0x0, 
		this.message = '', 
		this.origin = '', 
		this.date = '',
	});

	static SibylError? fromJson(dynamic value) {
		if (value == null) {
			return null;
		}

		if (value is Map<String, dynamic>) {
			return new SibylError(
				code: value['code'], 
				message: value['message'], 
				origin: value['origin'],
				date: value['date'],
			);
		}
		return null;
	}
}
