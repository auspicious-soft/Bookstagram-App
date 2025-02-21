 enum NetworkAPIStatus {
  success,
  failedToProcess,
  internetFailed,
  noData, retryRequest,
}

extension NetworkAPIStatusExtension on NetworkAPIStatus {
  String get value {
    switch (this) {
      case NetworkAPIStatus.success:return "";
      case NetworkAPIStatus.failedToProcess:
        return "Unabel to process now.";
        case NetworkAPIStatus.retryRequest:
        return "retry";
      case NetworkAPIStatus.internetFailed:
        return "No Internet.";
      case NetworkAPIStatus.noData:
        return "No Data.";
    }
  }
}
 