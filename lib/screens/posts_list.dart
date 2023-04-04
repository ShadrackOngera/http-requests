import 'package:flutter/material.dart';
import 'package:http_requests/http_helper.dart';
import 'package:http_requests/screens/post_details.dart';

class PostsList extends StatelessWidget {
  PostsList({super.key});

  Future<List<Map>> _futurePosts = HttpHelper().fetchItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts List'),
      ),
      body: FutureBuilder<List<Map>>(
        future: _futurePosts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text('Some error has occured ${snapshot.error}'),
            );
          }

          //Has data arrived
          if (snapshot.hasData) {
            List<Map> posts = snapshot.data;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Map thisItem = posts[index];
                return ListTile(
                  title: Text('${thisItem['title']}'),
                  subtitle: Text('${thisItem['body']}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PostDetails(thisItem['id'].toString())),
                    );
                  },
                );
              },
            );
          }
          //Display a loader
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
