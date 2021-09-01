class Todo {
  final int _id;
  final int _taskId;
  final String _description;
  int _isDone;
  Todo({id, required taskId, required description, required isDone})
      : _id = id ?? new DateTime.now().millisecondsSinceEpoch,
        _taskId = taskId,
        _description = description,
        _isDone = isDone;
  getTodo() {
    return {
      'id': _id,
      'taskId': _taskId,
      'description': _description,
      'isDone': _isDone
    };
  }

  setCompletion(val) {
    _isDone = val;
  }
}
