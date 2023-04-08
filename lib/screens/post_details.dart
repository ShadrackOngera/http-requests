import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_requests/http_helper.dart';
import 'package:http_requests/screens/edit_post.dart';

class PostDetails extends StatelessWidget {
  PostDetails(this.itemId, { Key? key}) : super(key: key) {
    _futurePost = HttpHelper().getItem(itemId);
  }

  final String itemId;
  late final Future<Map> _futurePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              _futurePost.then((post) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditPost(post)));
              });
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              // Delete
              bool deleted = await HttpHelper().deleteItem(itemId);

              if (deleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post Deleted')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to Delete')));
                  }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder<Map>(
        future: _futurePost,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred ${snapshot.error}'),
            );
          }

          // Data
          if (snapshot.hasData) {
            final post = snapshot.data!;

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

          // Loading
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}