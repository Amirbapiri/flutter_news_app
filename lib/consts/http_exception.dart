class HttpException implements Exception {
  final String codeMessage;

  HttpException(this.codeMessage);

  String get getNewsAPIErrorMessage {
    if (codeMessage.contains("apiKeyDisabled")) {
      return "Your API key has been disabled.";
    } else if (codeMessage.contains("apiKeyExhausted")) {
      return "Your API key has no more requests available.";
    } else if (codeMessage.contains("apiKeyInvalid")) {
      return "Your API key hasn't been entered correctly. Double check and try again";
    } else if (codeMessage.contains("apiKeyMissing")) {
      return "Your API key hasn't been entered correctly. Double check and try again";
    } else if (codeMessage.contains("parameterInvalid")) {
      return "You've included a parameter in your request which is currently not supported.";
    } else if (codeMessage.contains("parameterMissing")) {
      return "Required parameters are missing from the request.";
    } else if (codeMessage.contains("rateLimited")) {
      return "You've been rate limited.";
    } else if (codeMessage.contains("sourcesTooMany")) {
      return "You've requested too many sources in a single request. try splitting the request.";
    } else if (codeMessage.contains("sourceDoesNotExist")) {
      return "You've requested a source which doesn't exist.";
    }
    return "Unknown error occurred!";
  }

  @override
  String toString() {
    return codeMessage;
  }
}
