import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  // Fetching all items
  Future<List<Map>> fetchItems() async {
    List<Map> items = [];

    //Get data from the API
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      //get data from the response
      String jsonString = response.body;

      //convert the List<Map>
      List data = jsonDecode(jsonString);
      items = data.cast<Map>();

    }

    return items;
  }

  //Fetching one item
  Future<Map> getItem(itemId) async {
    Map item = {};

    //Get Item from the API
    http.Response response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));

    if (response.statusCode == 200) {
      //get data from the response
      String jsonString = response.body;

      //convert the List<Map>
      item = jsonDecode(jsonString);
    }

    return item;
  }

  //Add new Item
  Future<bool> addItem(Map data) async {
    bool status = false;

    //Add Item to the database, call the API
    http.Response response = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: jsonEncode(data),
        headers: {'content-type': 'application/json'});

    if (response.statusCode == 201) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  //Update new Item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    //Update Item the API
    http.Response response = await http.put(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"),
        body: jsonEncode(data),
        headers: {'content-type': 'application/json'});

    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  //Delete new Item
  Future<bool> deleteItem(String itemId) async {
    bool status = false;

    //Delete Item from the Database
    http.Response response = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));

    if (response.statusCode == 200) {
      status = true;
    }

    return status;
  }
}
