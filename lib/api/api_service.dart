import 'package:http/http.dart' as http;
import 'dart:convert';
import './api.dart';

class ApiService {
  final String _baseUrl = ApiConfig.baseUrl;

  // Helper function to create a Uri based on HTTP or HTTPS
  Uri _buildUri(String endpoint) {
    if (_baseUrl.startsWith('https://')) {
      return Uri.https(_baseUrl.replaceFirst('https://', ''), endpoint);
    } else {
      return Uri.http(_baseUrl.replaceFirst('http://', ''), endpoint);
    }
  }

  Future<dynamic> getRequest(String endpoint) async {
    var url = _buildUri(endpoint);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<dynamic> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    var url = _buildUri(endpoint);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Decode the response once, instead of multiple times
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData; // Return the decoded response data
      } else {
        return responseData; // Return the decoded response for error handling as well
      }
    } else {
      // Handle other HTTP status codes
      return {
        "status": "error",
        "message": "Request failed with status: ${response.statusCode}"
      };
    }
  }
}
