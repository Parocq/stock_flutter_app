import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stock_flutter_app/NavigationDrawer.dart';
import 'package:stock_flutter_app/entity/Account.dart';
import 'package:stock_flutter_app/network/Networker.dart';
import 'package:stock_flutter_app/table_entity/TableOperator.dart';

import 'entity/Operator.dart';

class MyOperatorsPage extends StatefulWidget {
  MyOperatorsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OperatorsPageState createState() => _OperatorsPageState();
}

/**-------------------------------------------------------------------- DELETE SELECTED ITEMS DIALOG --------------------------------------------------------------------**/
Future _asyncConfirmDeleteDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Removing dialog'),
        content: new Text("Do you really want to delete all selected items?"),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Remove'),
            onPressed: () {
              /**----------------------------------------request to remove elements from DB----------------------------------------------**/
              removeOperator();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
/**-------------------------------------------------------------------- DELETE SELECTED ITEMS DIALOG END --------------------------------------------------------------------**/

/**-------------------------------------------------------------------- ADD NEW ITEM DIALOG --------------------------------------------------------------------**/

String fioInsertDialog = "";
String numberInsertDialog = "";
String accLoginInsertDialog = "";
String accPassInsertDialog = "";

TextEditingController fioTextEdAddController = new TextEditingController();
TextEditingController phoneTextEdAddController = new TextEditingController();
TextEditingController accLoginTextEdAddController = new TextEditingController();
TextEditingController accPassTextEdAddController = new TextEditingController();

void setInsertDialValues() {
  accLoginTextEdAddController.text = accLoginInsertDialog;
  accPassTextEdAddController.text = accPassInsertDialog;
  fioTextEdAddController.text = fioInsertDialog;
  phoneTextEdAddController.text = numberInsertDialog;
}

Future _asyncInputDialog(BuildContext context) async {
  String teamName = '';
  return showDialog(
    context: context,
    barrierDismissible: false,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Adding new operator'),
        content: new Column(
          children: [
            new Expanded(
                child: new TextField(
              controller: fioTextEdAddController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input fio'),
              onChanged: (value) {
                fioInsertDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: phoneTextEdAddController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input phone number'),
              onChanged: (value) {
                numberInsertDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: accLoginTextEdAddController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input account login'),
              onChanged: (value) {
                accLoginInsertDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: accPassTextEdAddController,
              autofocus: true,
              decoration:
                  new InputDecoration(hintText: 'Input account password'),
              onChanged: (value) {
                accPassInsertDialog = value;
              },
            )),
          ],
        ),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
          FlatButton(
            child: Text('Add'),
            onPressed: () {
              /**----------------------------------------request to add element to DB----------------------------------------------**/
              setInsertDialValues();
              print(Operator(
                  0,
                  fioInsertDialog,
                  numberInsertDialog,
                  Account(0, accLoginInsertDialog, accPassInsertDialog,
                      "operator")));
              insertOperator(Operator(
                  0,
                  fioInsertDialog,
                  numberInsertDialog,
                  Account(0, accLoginInsertDialog, accPassInsertDialog,
                      "operator")));
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}
/**-------------------------------------------------------------------- ADD NEW ITEM DIALOG END--------------------------------------------------------------------**/

/**-------------------------------------------------------------------- UPDATE ITEM DIALOG --------------------------------------------------------------------**/
String idUpdateDialog = "";
String fioUpdateDialog = "";
String numberUpdateDialog = "";
String accIdUpdateDialog = "";
String accLoginUpdateDialog = "";
String accPassUpdateDialog = "";
String accRoleUpdateDialog = "";

void setDefaultValuesForUpdateDialog(String id, String fio, String phone,
    String accId, String accLogin, String accPass, String accRole) {
  idUpdateDialog = id;
  fioUpdateDialog = fio;
  numberUpdateDialog = phone;
  accIdUpdateDialog = accId;
  accPassUpdateDialog = accLogin;
  accPassUpdateDialog = accPass;
  accRoleUpdateDialog = accRole;
}

TextEditingController idTextEdController = new TextEditingController();
TextEditingController fioTextEdController = new TextEditingController();
TextEditingController phoneTextEdController = new TextEditingController();
TextEditingController accIdTextEdController = new TextEditingController();
TextEditingController accLoginTextEdController = new TextEditingController();
TextEditingController accPassTextEdController = new TextEditingController();
TextEditingController accRoleTextEdController = new TextEditingController();

void setUnchangedValues() {
  idTextEdController.text = idUpdateDialog;
  fioTextEdController.text = fioUpdateDialog;
  phoneTextEdController.text = numberUpdateDialog;
  accIdTextEdController.text = accIdUpdateDialog;
  accLoginTextEdController.text = accLoginUpdateDialog;
  accPassTextEdController.text = accPassUpdateDialog;
  accRoleTextEdController.text = accRoleUpdateDialog;
}

Future _asyncUpdateDialog(BuildContext context) async {
  String teamName = '';
  return showDialog(
    context: context,
    barrierDismissible: false,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update'),
        content: new Column(
          children: [
            new Expanded(
                child: new TextField(
              readOnly: true,
              controller: idTextEdController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input number'),
              onChanged: (value) {
                idUpdateDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: fioTextEdController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input fio'),
              onChanged: (value) {
                fioUpdateDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: phoneTextEdController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input phone number'),
              onChanged: (value) {
                numberUpdateDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: accIdTextEdController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input account id'),
              onChanged: (value) {
                accIdUpdateDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: accLoginTextEdController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input account login'),
              onChanged: (value) {
                accLoginUpdateDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: accPassTextEdController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input account pass'),
              onChanged: (value) {
                accPassUpdateDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: accRoleTextEdController,
              autofocus: true,
              decoration: new InputDecoration(hintText: 'Input account role'),
              onChanged: (value) {
                accRoleUpdateDialog = value;
              },
            )),
          ],
        ),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
          FlatButton(
            child: Text('Update'),
            onPressed: () {
              /**----------------------------------------request to update element on DB----------------------------------------------**/
              updateOperator(Operator(
                  int.parse(idUpdateDialog),
                  fioUpdateDialog,
                  numberUpdateDialog,
                  Account(int.parse(accIdUpdateDialog), accLoginUpdateDialog,
                      accPassUpdateDialog, accRoleUpdateDialog)));
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}

/**-------------------------------------------------------------------- UPDATE ITEM DIALOG END--------------------------------------------------------------------**/
// ignore: deprecated_member_use
List<TableOperator> items = new List();

Future<void> insertOperator(Operator operator) async {
  String jsonOperator = operator.toJson(operator);
  await Networker.instance.insertOperator(jsonOperator);
}

Future<void> updateOperator(Operator operator) async {
  String jsonOperator = operator.toJson(operator);
  await Networker.instance.updateOperator(jsonOperator);
}

Future<void> removeOperator() async {
  List<int> list = new List();
  items.forEach((element) {
    if (element.checked == true) {
      list.add(element.operator.id);
    }
  });
  await Networker.instance.removeOperators(list);
}

class _OperatorsPageState extends State<MyOperatorsPage> {
  @override
  void initState() {
    super.initState();
    // fetchData();
    selectAllOperators();
  }

  Future<void> selectAllOperators() async {
    TableOperator tableOperator =
        new TableOperator(false, Operator(1, "", "", Account(1, "", "", "")));
    Response response = await Networker.instance.getAllOperators();
    final itemsq = json.decode(response.body).cast<Map<String, dynamic>>();
    print(itemsq);
    List<Operator> list = itemsq.map<Operator>((json) {
      return Operator.fromJson(json);
    }).toList();

    items.clear();
    setState(() {
      list.forEach((element) {
        items.add(tableOperator.fromOperator(element));
      });
    });
  }

  bool sort = true;
  bool sortId = true;
  bool sortFio = true;
  bool sortNumber = true;
  int sortColIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one_rounded),
        onPressed: () async {
          await _asyncInputDialog(context);
        },
      ),
      drawer: NavigationDrawer().getNavigationDrawer(context),
      appBar: AppBar(
        title: Text("Operators"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  selectAllOperators();
                  setState(() {
                    getOperatorsListWidget();
                  });
                },
                child: Icon(
                  Icons.refresh,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _asyncConfirmDeleteDialog(context);
                },
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            sortAscending: sort,
            sortColumnIndex: sortColIndex,
            columns: [
              DataColumn(
                  label: Center(child: Text('ID')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortId = !sortId;
                      sort = sortId;
                      sortColIndex = 0;
                    });
                    onSortColumn(0, sortId);
                  }),
              DataColumn(
                  label: Center(child: Text('FIO')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortFio = !sortFio;
                      sort = sortFio;
                      sortColIndex = 1;
                    });
                    onSortColumn(1, sortFio);
                  }),
              DataColumn(
                  label: Center(child: Text('Phone number')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortNumber = !sortNumber;
                      sort = sortNumber;
                      sortColIndex = 2;
                    });
                    onSortColumn(2, sortNumber);
                  }),
              DataColumn(
                  label: Center(child: Text('ID (account)')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortNumber = !sortNumber;
                      sort = sortNumber;
                      sortColIndex = 3;
                    });
                    onSortColumn(3, sortNumber);
                  }),
              DataColumn(
                  label: Center(child: Text('Login')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortNumber = !sortNumber;
                      sort = sortNumber;
                      sortColIndex = 4;
                    });
                    onSortColumn(4, sortNumber);
                  }),
              DataColumn(
                  label: Center(child: Text('Password')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortNumber = !sortNumber;
                      sort = sortNumber;
                      sortColIndex = 5;
                    });
                    onSortColumn(5, sortNumber);
                  }),
              DataColumn(
                  label: Center(child: Text('Role')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortNumber = !sortNumber;
                      sort = sortNumber;
                      sortColIndex = 6;
                    });
                    onSortColumn(6, sortNumber);
                  }),
              DataColumn(
                label: Center(child: Text('Edit')),
              ),
            ],
            rows: getOperatorsListWidget(),
          ),
        ),
      ),
    );
  }

  /**-------------------------------------------------------------------- SORTS ON COLUMNS --------------------------------------------------------------------**/
  onSortColumn(int columnIndex, bool ascending) {
    switch (columnIndex) {
      case 0:
        {
          if (ascending) {
            items.sort((a, b) => a.operator.id.compareTo(b.operator.id));
          } else {
            items.sort((a, b) => b.operator.id.compareTo(a.operator.id));
          }
          break;
        }
      case 1:
        {
          if (ascending) {
            items.sort((a, b) => a.operator.fio.compareTo(b.operator.fio));
          } else {
            items.sort((a, b) => b.operator.fio.compareTo(a.operator.fio));
          }
          break;
        }
      case 2:
        {
          if (ascending) {
            items.sort((a, b) =>
                a.operator.phoneNumber.compareTo(b.operator.phoneNumber));
          } else {
            items.sort((a, b) =>
                b.operator.phoneNumber.compareTo(a.operator.phoneNumber));
          }
          break;
        }
      case 3:
        {
          if (ascending) {
            items.sort((a, b) =>
                a.operator.account.id.compareTo(b.operator.account.id));
          } else {
            items.sort((a, b) =>
                b.operator.account.id.compareTo(a.operator.account.id));
          }
          break;
        }
      case 4:
        {
          if (ascending) {
            items.sort((a, b) =>
                a.operator.account.login.compareTo(b.operator.account.login));
          } else {
            items.sort((a, b) =>
                b.operator.account.login.compareTo(a.operator.account.login));
          }
          break;
        }
      case 5:
        {
          if (ascending) {
            items.sort((a, b) => a.operator.account.password
                .compareTo(b.operator.account.password));
          } else {
            items.sort((a, b) => b.operator.account.password
                .compareTo(a.operator.account.password));
          }
          break;
        }
      case 6:
        {
          if (ascending) {
            items.sort((a, b) =>
                a.operator.account.role.compareTo(b.operator.account.role));
          } else {
            items.sort((a, b) =>
                b.operator.account.role.compareTo(a.operator.account.role));
          }
          break;
        }
    }
  }

  /**-------------------------------------------------------------------- SORTS ON COLUMNS END --------------------------------------------------------------------**/

  /**-------------------------------------------------------------------- FILLING TABLE WITH VALUES --------------------------------------------------------------------**/
  List<DataRow> getOperatorsListWidget() {
    List<DataRow> list = new List();

    if (items.isEmpty) {
      list.add(new DataRow(
        cells: [
          DataCell(Text("-")),
          DataCell(Text("-")),
          DataCell(Text("-")),
          DataCell(Text("-")),
          DataCell(Text("-")),
          DataCell(Text("-")),
          DataCell(Text("-")),
          DataCell(Text("-")),
        ],
        selected: false,
        onSelectChanged: (bool value) {
          setState(() {
            getOperatorsListWidget();
          });
        },
      ));
      return list;
    } else
      list.clear();

    for (int i = 0; i < items.length; i++) {
      list.add(DataRow(
        cells: [
          DataCell(Text('id:${items[i].operator.id}')),
          DataCell(Text('fio:\n${items[i].operator.fio}')),
          DataCell(Text('phone number:\n${items[i].operator.phoneNumber}')),
          DataCell(Text('account.id:\n${items[i].operator.account.id}')),
          DataCell(Text('account.login:\n${items[i].operator.account.login}')),
          DataCell(
              Text('account.password:\n${items[i].operator.account.password}')),
          DataCell(Text('account.role:\n${items[i].operator.account.role}')),
          DataCell(IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              /**---------------------------editing element dialog + sending request to update------------------------------**/
              setDefaultValuesForUpdateDialog(
                  items[i].operator.id.toString(),
                  items[i].operator.fio,
                  items[i].operator.phoneNumber,
                  items[i].operator.account.id.toString(),
                  items[i].operator.account.login,
                  items[i].operator.account.password,
                  items[i].operator.account.role);
              setUnchangedValues();
              _asyncUpdateDialog(context);
            },
          )),
        ],
        selected: items[i].checked,
        onSelectChanged: (bool value) {
          setState(() {
            items[i].checked = !items[i].checked;
            print("in set state method");
          });
        },
      ));
    }
    return list;
  }
/**-------------------------------------------------------------------- FILLING TABLE WITH VALUES END --------------------------------------------------------------------**/
}
