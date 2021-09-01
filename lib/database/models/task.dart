class Task {
  final int _id;
  String _title;
  final String _description;
  Task({id, required title, description})
      : _id = id ?? new DateTime.now().millisecondsSinceEpoch,
        _title = title,
        _description = description ?? '';
  getTask() {
    return {'id': _id, 'title': _title, 'description': _description};
  }

  void setTitle(String title) {
    _title = title;
  }
}
