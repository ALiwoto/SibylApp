
class EmptyTokenException implements Exception {
	late final String message;

	EmptyTokenException() {
		this.message = 'token cannot be empty';
	}
}

class InvalidTokenException implements Exception {
	late final String message;

	InvalidTokenException() {
		this.message = 'token is invalid';
	}
}

class InvalidUrlException implements Exception {
	late final String message;

	InvalidUrlException() {
		this.message = 'host url is invalid';
	}
}
