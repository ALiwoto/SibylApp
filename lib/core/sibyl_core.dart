

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sibyl_app/core/sibyl_exceptions.dart';
import 'package:sibyl_app/core/sibyl_response.dart';
import 'package:sibyl_app/core/sibyl_results.dart';


SibylCore? sibylClient;

class SibylCore {
	static const String DefaultUrl = 'https://psychopass.animekaizoku.com/';

	String token = '';
	String _hostUrl = DefaultUrl;
	HttpClient _httpClient = new HttpClient();

	SibylCore(this.token, String? theUrl) {
		if (this.token.isEmpty) {
			throw new EmptyTokenException();
		}

		if (!this.token.contains(':') || this.token.length < 3) {
			throw new InvalidTokenException();
		}

		if (theUrl != null) {
			if (theUrl.length < 3) {
				throw new InvalidUrlException();
			}

			this._hostUrl = theUrl;
		}
	}

	
	static String validateHostUrl(String value) {
		/**
		 * Based on Go logic:
			func validateHostUrl(value string) string {
				if len(value) < 3 {
					return DefaultUrl
				}

				if value[len(value)-1] != '/' {
					value += "/"
				}

				if strings.HasPrefix(value, "http://") || strings.HasPrefix(value, "https://") {
					return value
				}

				// animekaizoku's domains are mostly protected by cloudflare shit,
				// so we need to use https:// for them.
				if strings.Contains(value, "animekaizoku") {
					return "https://" + value
				}

				return "http://" + value
			}
		 */

		if (value.length < 3) {
			return DefaultUrl;
		}

		if (value[value.length-1] != '/') {
			value += "/";
		}

		if (value.startsWith('http://') || value.startsWith('https://')) {
			return value;
		}

		// animekaizoku's domains are mostly protected by cloudflare shit,
		// so we need to use https:// for them.
		if (value.contains('animekaizoku')) {
			return "https://" + value;
		}

		return "http://" + value;
	}
	
	void changeToken(final String newToken) {
		if (newToken.isEmpty) {
			throw new EmptyTokenException();
		}

		if (!newToken.contains(':') || newToken.length < 3) {
			throw new InvalidTokenException();
		}
	}

	void changeHostUrl(final String hostUrl) {
		if (hostUrl.length < 3) {
			throw new InvalidUrlException();
		}

		this._hostUrl = validateHostUrl(hostUrl);
	}

	void changeToDefaultUrl() {
		this._hostUrl = DefaultUrl;
	}

	Uri getSuitableUri(String endpoint, Map<String, String> params) {
		var theUri = Uri.parse(this._hostUrl + endpoint);
		params.addAll(theUri.queryParameters);

		return theUri.replace(
			queryParameters: params,
		);
	}

	String? getHostUrl() => this._hostUrl;

	// ban-related methods:

	Future<BanResult?> banAsync(
		final int userId, 
		final String reason,
		final String message,
		final String srcUrl,
		final bool isBot,
	) async {
		var resp = await this.revokeAsync<BanResult>(
			'addBan',
			{
				'token': this.token,
				'user-id': userId.toString(),
				'reason': reason,
				'message': message,
				'src-url': srcUrl,
				'is-bot': isBot.toString(),
			},
		);

		if (resp.error != null) {
			throw resp.error!;
		}

		if (resp.result is BanResult) {
			return resp.result! as BanResult;
		}

		return null;
	}

	Future<BanResult?> banUserAsync(
		final int userId, 
		final String reason,
		final String message,
		final String srcUrl,
	) async => this.banAsync(userId, reason, message, srcUrl, false);

	Future<BanResult?> banBotAsync(
		final int userId, 
		final String reason,
		final String message,
		final String srcUrl,
	) async => this.banAsync(userId, reason, message, srcUrl, true);

	Future<StringResult?> removeBanAsync(final int userId) async {
		var resp = await this.revokeAsync<StringResult>(
			'removeBan',
			{
				'token': this.token,
				'user-id': userId.toString(),
			},
		);

		if (resp.error != null) {
			throw resp.error!;
		}

		if (resp.result is StringResult) {
			return resp.result! as StringResult;
		}

		return null;
	}

	Future<GetInfoResult?> getInfoAsync(final int userId) async {
		var resp = await this.revokeAsync<GetInfoResult>(
			'getInfo',
			{
				'token': this.token,
				'user-id': userId.toString(),
			},
		);

		if (resp.error != null) {
			throw resp.error!;
		}

		if (resp.result is GetInfoResult) {
			return resp.result! as GetInfoResult;
		}

		return null;
	}

	Future<GeneralInfoResult?> getGeneralAsync(final int userId) async {
		var resp = await this.revokeAsync<GeneralInfoResult>(
			'getGeneralInfo',
			{
				'token': this.token,
				'user-id': userId.toString(),
			},
		);

		if (resp.error != null) {
			throw resp.error!;
		}

		if (resp.result is GeneralInfoResult) {
			return resp.result! as GeneralInfoResult;
		}

		return null;
	}

	
	Future<BoolResult?> checkTokenAsync() async {
		var resp = await this.revokeAsync<BoolResult>(
			'checkToken',
			{
				'token': this.token,
			},
		);

		if (resp.error != null) {
			throw resp.error!;
		}

		if (resp.result is BoolResult) {
			return resp.result! as BoolResult;
		}

		return null;
	}


	Future<SibylResponse> revokeAsync<T extends SibylResultable>(
			String endpoint,
			Map<String, String> params,
		) async {
		var theUri = this.getSuitableUri(endpoint, params);

		var req = await this._httpClient.getUrl(theUri);
		var resp = await req.close();
		var myStream = resp.transform(utf8.decoder);
		String myData = '';
		await myStream.listen((String contents) {
			myData = contents;
		}).asFuture();

		return SibylResponse.fromJson<T>(jsonDecode(myData));
	}

}
