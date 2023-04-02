import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/project.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _imageUrlsController = TextEditingController();
  final _skillsController = TextEditingController();
  final _feelingController = TextEditingController();
  final _importanceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _summaryController = TextEditingController();

  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final project = Project(
        name: _nameController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
        startDate: DateTime.parse(_startDateController.text),
        endDate: DateTime.parse(_endDateController.text),
        imageUrls: _imageUrlsController.text.split(','),
        skills: _skillsController.text
            .split(',')
            .map((skill) => skill.trim())
            .toList(),
        impression: _feelingController.text,
        importance: _importanceController.text,
        category:  _categoryController.text,
        summary:  _summaryController.text.split(',')
            .map((skill) => skill.trim())
            .toList(),
      );

      try {
        await FirebaseFirestore.instance.collection('Projects').add({
          'projectName': project.name,
          'description': project.description,
          'imageUrl': project.imageUrl,
          'startDate': project.startDate,
          'endDate': project.endDate,
          'imageUrls': project.imageUrls,
          '주요기술': project.skills,
          '느낀점': project.impression,
          '중요도': project.importance,
          'category' : project.category,
          'summary' : project.summary,
        });
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading project'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Project'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submitForm,
            child: Text(
              'Upload',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          labelText: 'category',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _startDateController,
                        decoration: InputDecoration(
                          labelText: 'Start Date (yyyy-mm-dd)',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a start date';
                          }
                          if (DateTime.tryParse(value) == null) {
                            return 'Please enter a valid date format';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _endDateController,
                        decoration: InputDecoration(
                          labelText: 'End Date (yyyy-mm-dd)',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an end date';
                          }
                          if (DateTime.tryParse(value) == null) {
                            return 'Please enter a valid date format';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _imageUrlsController,
                        decoration: InputDecoration(
                          labelText: 'Comma-separated Image URLs',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter at least one image URL';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _skillsController,
                        decoration: InputDecoration(
                          labelText: 'Comma-separated Skills',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter at least one skill';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _feelingController,
                        decoration: InputDecoration(
                          labelText: 'Feeling',
                        ),
                      ),
                      SizedBox(height: 16,),
                      TextFormField(
                        controller: _importanceController,
                        decoration: InputDecoration(
                          labelText: '중요도',
                        ),
                      ),
                      SizedBox(height: 16,),
                      TextFormField(
                        controller: _summaryController,
                        decoration: InputDecoration(
                          labelText: 'comma-seperated summary',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
