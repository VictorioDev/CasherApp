class ApiResponse {
  String _data;
  int _statusCode;

  ApiResponse(this._data, this._statusCode);

  get data => _data;
  get statusCOde => _statusCode;
}
