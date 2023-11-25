import 'dart:convert';
import 'package:http/http.dart' as http;

var postapiurl ='http://88.85.248.3:5002/Employee/Postemployee';
var getapiurl = 'http://88.85.248.3:5002/Employee/Getemployee';


Future<dynamic> post(String id,String name,String position ,String phone,String birth) async {
  try {
    var result ='';

    http.Response response = await http.post(
      Uri.parse(postapiurl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        
      },
      body: jsonEncode(<String, String>{
          "emp_cd": position,
          "fullname": name,
          "birth_dt": birth,
          "mobile_no": phone,
          "comp_id": id
       }
),
    );

    if (response.statusCode == 201) {
      // Successfully posted data
      print('Data posted successfully');
      print('Response body: ${response.body}');
      print('${response.statusCode}');
      result ='success';
      
    } else {
      // Handle error
      print('Failed to post data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      result = 'failed';
    }
    return result;
  } catch (e) {
    // Handle exception
    print('An error occurred while making the request: $e');
  }
  
}

Future<dynamic> get() async {
  try {
    http.Response response = await http.get(
      Uri.parse(getapiurl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Successful GET request
      var responseBody = jsonDecode(response.body);
      print('got data ✅');
      print('Response body: ${responseBody}');
      return responseBody;
    } else {
      // Handle error
      print('Failed to get data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null; // or throw an exception if desired
    }
  } catch (e) {
    // Handle exception
    print('An error occurred while making the request: $e');
    return null; // or throw an exception if desired
  }
}

// {
//   "emp_cd": "string",
//   "fullname": "string",
//   "birth_dt": "2023-11-23T07:47:25.928Z",
//   "mobile_no": "string",
//   "comp_id": "string"
// }
