enum ApiErrorsEnum {
  badRequestError,
  unauthorizedError,
  forbiddenError,
  notFoundError,
  conflictError,
  internalServerError,
  badResponse,
  connectionError,
  connectionTimeout,
  receiveTimeout,
  sendTimeout,
  cancel,
  unknownError;

  static ApiErrorsEnum fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return ApiErrorsEnum.badRequestError;
      case 401:
        return ApiErrorsEnum.unauthorizedError;
      case 403:
        return ApiErrorsEnum.forbiddenError;
      case 404:
        return ApiErrorsEnum.notFoundError;
      case 409:
        return ApiErrorsEnum.conflictError;
      case 500:
        return ApiErrorsEnum.internalServerError;
      default:
        return ApiErrorsEnum.badResponse;
    }
  }
}
