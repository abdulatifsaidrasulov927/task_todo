class UniversalData {
  final dynamic data;
  final bool success;
  final String? message;
  final String? error;

  UniversalData({
    this.data,
    this.success = true,
    this.message,
    this.error,
  });
}
