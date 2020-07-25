import 'package:aula_24_flutter_exercicio/data/db.dart';
import 'package:aula_24_flutter_exercicio/entites/task.dart';
import 'package:aula_24_flutter_exercicio/repositories/task_repository.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _taskController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final Task _task = Task();
  TaskRepository taskRepository;
  @override
  void initState() {
    super.initState();
    taskRepository = TaskRepository(Db());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('To do List'),
      ),
      body: FutureBuilder<List<Task>>(
        future: taskRepository.recoverTask(),
        initialData: null,
        builder: (ctx, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData && snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 50,
                      child: Form(
                        key: _form,
                        child: TextFormField(
                          controller: _taskController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'adicionar tarefa',
                          ),
                          validator: (value) {
                            if (value.length < 3) return 'Tarefa muito curta';
                            if (value.length > 30) return 'Tarefa muito longo';
                            return null;
                          },
                          onSaved: (newValue) {
                            _task.task = newValue;
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 20,
                      child: RaisedButton(
                        child: Text('Adicionar'),
                        onPressed: () {
                          if (!_form.currentState.validate()) {
                            showSnackBar('Dados inválidos!');
                            return;
                          }
                          _form.currentState.save();
                          if (_task.id != null) {
                            updateTask();
                            return;
                          }
                          setState(() {
                            saveTask();
                          });

                          _taskController.clear();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Todo',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: Checkbox(
                              value: snapshot.data[index].finish,
                              onChanged: (value) {
                                setState(() {
                                  snapshot.data[index].finish = value;
                                  taskRepository.updateTask(_task);
                                });
                              }),
                          onLongPress: () {
                            setState(() {
                              taskRepository
                                  .deleteTask(snapshot.data[index].id);
                            });
                          },
                          title: Text(snapshot.data[index].task),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void saveTask() async {
    final saved = await taskRepository.saveTask(_task);
    taskRepository.recoverTask();

    if (!saved) {
      showSnackBar('Não foi possível salvar a tarefa!');
      return;
    }
  }

  void updateTask() async {
    final update = await taskRepository.updateTask(_task);
    if (!update) {
      showSnackBar('Não foi possível atualizar atarefa!');
      return;
    }
  }

  void showSnackBar(String mensage) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(
            seconds: 2,
          ),
          content: Text(
            mensage,
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.red,
        ),
      );
  }
}
