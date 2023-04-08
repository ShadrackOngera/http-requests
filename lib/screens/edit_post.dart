import 'package:flutter/material.dart';
import 'package:http_requests/http_helper.dart';

class EditPost extends StatefulWidget {
  EditPost(this.post, {Key? key}) : super(key: key);

  Map post;
  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

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
                onPressed: () async {
                  Map<String, String> dataToUpdate = {
                    'titel': _controllerTitle.text,
                    'body': _controllerBody.text,
                  };

                  bool status = await HttpHelper()
                      .updateItem(dataToUpdate, widget.post['id'].toString());

                  if (status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post Updated')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to Update')));
                  }
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
