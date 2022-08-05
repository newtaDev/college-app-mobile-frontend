class StatusCodeHelper {
  /// statuscode = `100 - 101`
  static bool isInformational(int code) {
    if (code == 100 || code == 101) {
      return true;
    }
    return false;
  }

  /// statuscode = `200 - 226`
  static bool isSuccess(int code) {
    if (code >= 200 && code <= 226) {
      return true;
    }
    return false;
  }

  /// statuscode = `300 - 308`
  static bool isRedirect(int code) {
    if (code >= 300 && code <= 308) {
      return true;
    }
    return false;
  }

  /// statuscode = `400 - 541`
  static bool isClintError(int code) {
    if (code >= 400 && code <= 451) {
      return true;
    }
    return false;
  }

  /// statuscode = `500 - 511`
  static bool isServerError(int code) {
    if (code >= 500 && code <= 511) {
      return true;
    }
    return false;
  }
}
