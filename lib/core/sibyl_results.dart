
abstract class SibylResultable {

	const SibylResultable();

	static SibylResultable? fromJson<T extends SibylResultable>(final dynamic value) {
		if (value == null) {
			return null;
		}
		
		switch (T) {
			case StringResult:
				return StringResult.fromJson(value);
			case BanInfo:
				return BanInfo.fromJson(value);
			case BanResult:
				return BanResult.fromJson(value);
			case GetInfoResult:
				return GetInfoResult.fromJson(value);
			case BoolResult:
				return BoolResult.fromJson(value);
		}
		
		return null;
	}
}

enum UserPermission {
	NormalUser,
	Enforcer,
	Inspector,
	Owner,
}

class StringResult implements SibylResultable {
	final String theValue;

	const StringResult(this.theValue);

	@override
	String toString() => theValue;

	static StringResult? fromJson(final dynamic value) {
		if (value is String) {
			return new StringResult(value);
		}

		if (value != null) {
			var str = value.toString();
			if (str.length > 0) {
			  return new StringResult(value);
			}
		}
		return null;
	}
}


class BoolResult implements SibylResultable {
	final bool theValue;

	const BoolResult(this.theValue);

	@override
	String toString() => theValue.toString();

	static BoolResult? fromJson(final dynamic value) {
		if (value is bool) {
			return new BoolResult(value);
		}

		if (value != null) {
			var str = value.toString();
			if (str.length > 0) {
				return new BoolResult(value);
			}
		}
		return null;
	}
}


class BanInfo extends SibylResultable {
	final int userId;
	final bool banned;
	final String? reason;
	final String? message;
	final String? banSrcUrl;
	final int? bannedBy;
	final int crimeCoefficient;
	final String date;
	final List<String>? banFlags;
	final bool isBot;

	/**
	 * Go declaration:
		type BanInfo struct {
			UserId           int64    `json:"user_id"`
			Banned           bool     `json:"banned"`
			Reason           string   `json:"reason"`
			Message          string   `json:"message"`
			BanSourceUrl     string   `json:"ban_source_url"`
			BannedBy         int64    `json:"banned_by"`
			CrimeCoefficient int64    `json:"crime_coefficient"`
			Date             string   `json:"date"`
			BanFlags         []string `json:"ban_flags"`
			IsBot            bool     `json:"is_bot"`
		}
	 */

	///
	const BanInfo({
		this.userId = 0,
		this.banned = false,
		this.reason,
		this.message,
		this.banSrcUrl,
		this.bannedBy,
		this.crimeCoefficient = 0,
		this.date = '',
		this.banFlags,
		this.isBot = false,
	});

	/// 
	static BanInfo? fromJson(final dynamic value) {
		if (value is Map<String, dynamic>) {
			return new BanInfo(
				userId: value['user_id'],
				banned: value['banned'],
				reason: value['reason'],
				message: value['message'],
				banSrcUrl: value['ban_source_url'],
				bannedBy: value['banned_by'],
				crimeCoefficient: value['crime_coefficient'],
				date: value['date'],
				banFlags: value['ban_flags'],
				isBot: value['is_bot'],
			);
		}

		return null;
	}
}

class BanResult extends SibylResultable {

	final BanInfo? previousBan;
	final BanInfo? currentBan;

	const BanResult({
		this.previousBan,
		this.currentBan,
	});

	/**
	 * Go declaration:
		type BanResult struct {
			PreviousBan *BanInfo `json:"previous_ban"`
			CurrentBan  *BanInfo `json:"current_ban"`
		}
	 */


	///
	static BanResult? fromJson(final dynamic value) {
		if (value is Map<String, dynamic>) {
			return BanResult(
				previousBan: BanInfo.fromJson(value['previous_ban']),
				currentBan: BanInfo.fromJson(value['current_ban'])
			);
		}

		return null;
	}

}

class GetInfoResult extends SibylResultable {
	final int userId;
	final bool banned;
	final String? reason;
	final String? message;
	final String? banSrcUrl;
	final int? bannedBy;
	final int crimeCoefficient;
	final String date;
	final List<String>? banFlags;
	final bool isBot;

	/**
	 * Go declaration:
		type GetInfoResult struct {
			UserId           int64    `json:"user_id"`
			Banned           bool     `json:"banned"`
			Reason           string   `json:"reason"`
			Message          string   `json:"message"`
			BanSourceUrl     string   `json:"ban_source_url"`
			BannedBy         int64    `json:"banned_by"`
			CrimeCoefficient int64    `json:"crime_coefficient"`
			Date             string   `json:"date"`
			BanFlags         []string `json:"ban_flags"`
			IsBot            bool     `json:"is_bot"`
		}
	 */

	///
	const GetInfoResult({
		this.userId = 0,
		this.banned = false,
		this.reason,
		this.message,
		this.banSrcUrl,
		this.bannedBy,
		this.crimeCoefficient = 0,
		this.date = '',
		this.banFlags,
		this.isBot = false,
	});

	/// 
	static GetInfoResult? fromJson(final dynamic value) {
		if (value is Map<String, dynamic>) {
			return new GetInfoResult(
				userId: value['user_id'],
				banned: value['banned'],
				reason: value['reason'],
				message: value['message'],
				banSrcUrl: value['ban_source_url'],
				bannedBy: value['banned_by'],
				crimeCoefficient: value['crime_coefficient'],
				date: value['date'],
				banFlags: value['ban_flags'],
				isBot: value['is_bot'],
			);
		}

		return null;
	}
}


class GeneralInfoResult extends SibylResultable {
	final int userId;
	final int division;
	final int assignedBy;
	final String assignedReason;
	final String assignedAt;
	final UserPermission permission;

	/**
	 * Go declaration:
		type GeneralInfoResult struct {
			UserId         int64          `json:"user_id"`
			Division       int            `json:"division"`
			AssignedBy     int64          `json:"assigned_by"`
			AssignedReason string         `json:"assigned_reason"`
			AssignedAt     string         `json:"assigned_at"`
			Permission     UserPermission `json:"permission"`
		}
	 */

	///
	const GeneralInfoResult({
		this.userId = 0,
		this.division = 0,
		this.assignedBy = 0,
		this.assignedReason = '',
		this.assignedAt = '',
		this.permission = UserPermission.Enforcer,
	});

	/// 
	static GeneralInfoResult? fromJson(final dynamic value) {
		if (value is Map<String, dynamic>) {
			return new GeneralInfoResult(
				userId: value['user_id'],
				division: value['division'],
				assignedBy: value['assigned_by'],
				assignedReason: value['assigned_reason'],
				assignedAt: value['assigned_at'],
				permission: value['permission'] as UserPermission,
			);
		}

		return null;
	}
}




