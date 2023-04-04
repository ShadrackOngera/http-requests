import 'package:flutter/material.dart';
import 'package:http_requests/http_helper.dart';
import 'package:http_requests/screens/edit_post.dart';

class PostDetails extends StatelessWidget {
  PostDetails(this.itemId, {super.key}) {
    _futurePost = HttpHelper().getItem((itemId));
  }

  String itemId;

  late Future<Map> _futurePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => EditPost(post)));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              //Delete
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder<Map>(
        future: _futurePost,
        builder: (context, snapshot) {
          //check for erros
          if (snapshot.hasError) {
            return Center(
                child: Text('An error has occured ${snapshot.error}'));
          }

          //Data
          if (snapshot.hasData) {
            Map post = snapshot.data!;

            return Column(
              children: [
                Text(
                  '${post['title']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${post['body']}'),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
