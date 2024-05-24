import 'package:flutter/material.dart';

class TextFieldListPage extends StatefulWidget {
  @override
  _TextFieldListPageState createState() => _TextFieldListPageState();
}

class _TextFieldListPageState extends State<TextFieldListPage> {
  List<String> textList = [''];
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text Field List'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: textList.length,
                itemBuilder: (context, index) {
                  if (index == textList.length - 1) {
                    return Column(
                      children: [
                        TextField(
                          controller: textController,
                          onChanged: (value) {
                            textList[index] = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Enter Text',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              textList.add('');
                              textController.clear();
                              print(
                                  'Added empty string to the list: $textList');
                            });
                          },
                          child: Text('Add'),
                        ),
                      ],
                    );
                  } else {
                    textController = TextEditingController();
                    return Card(
                      child: ListTile(
                        title: Text(textList[index]),
                      ),
                    );
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  List<String> filteredList =
                      textList.where((element) => element.isNotEmpty).toList();
                  print('Filtered list: $filteredList');
                },
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
