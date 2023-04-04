import 'package:flutter/material.dart';
import 'package:http_requests/http_helper.dart';

class EditPost extends StatefulWidget {
  EditPost(this.post, {required Key key}) : super(key: key);
  Map post;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

  @override
  initState() {
    super.initState();
    _controllerTitle.text = widget.post['title'];
    _controllerBody.text = widget.post['body'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controllerTitle,
              ),
              TextFormField(
                controller: _controllerBody,
              ),
              ElevatedButton(
                onPressed: () {
                  Map<String, String> data
                  HttpHelper().updateItem(data, widget.post['id'])
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
