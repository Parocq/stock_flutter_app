import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stock_flutter_app/entity/Driver.dart';
import 'package:stock_flutter_app/NavigationDrawer.dart';
import 'package:stock_flutter_app/network/Networker.dart';
import 'package:stock_flutter_app/table_entity/TableDriver.dart';

class MyDriversPage extends StatefulWidget {
  MyDriversPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DriversPageState createState() => _DriversPageState();
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
              removeDriver();
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
// String idInsertDialog = "";
String fioInsertDialog = "";
String numberInsertDialog = "";

// TextEditingController idTextEdAddController = new TextEditingController();
TextEditingController fioTextEdAddController = new TextEditingController();
TextEditingController phoneTextEdAddController = new TextEditingController();

void setInsertDialValues() {
  // idTextEdAddController.text = idInsertDialog;
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
        title: Text('Adding new driver'),
        content: new Column(
          children: [
            // new Expanded(
            //     child: new TextField(
            //   controller: idTextEdAddController,
            //   autofocus: true,
            //   decoration: new InputDecoration(
            //       labelText: 'id', hintText: 'Input number'),
            //   onChanged: (value) {
            //     idInsertDialog = value;
            //   },
            // )),
            new Expanded(
                child: new TextField(
              controller: fioTextEdAddController,
              autofocus: true,
              decoration:
                  new InputDecoration(labelText: 'FIO', hintText: 'Input fio'),
              onChanged: (value) {
                fioInsertDialog = value;
              },
            )),
            new Expanded(
                child: new TextField(
              controller: phoneTextEdAddController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Phone number', hintText: 'Input phone number'),
              onChanged: (value) {
                numberInsertDialog = value;
              },
            ))
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
              insertDriver(Driver(0, fioInsertDialog, numberInsertDialog));
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

void setDefaultValuesForUpdateDialog(String id, String fio, String phone) {
  idUpdateDialog = id;
  fioUpdateDialog = fio;
  numberUpdateDialog = phone;
}

TextEditingController idTextEdController = new TextEditingController();
TextEditingController fioTextEdController = new TextEditingController();
TextEditingController phoneTextEdController = new TextEditingController();

void setUnchangedValues() {
  idTextEdController.text = idUpdateDialog;
  fioTextEdController.text = fioUpdateDialog;
  phoneTextEdController.text = numberUpdateDialog;
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
            ))
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
              updateDriver(Driver(int.parse(idUpdateDialog), fioUpdateDialog,
                  numberUpdateDialog));
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
List<TableDriver> items = new List();

Future<void> selectAllDrivers() async {
  TableDriver tableDriver = new TableDriver(false,Driver(1,"",""));
  Response response = await Networker.instance.getAllDrivers();
  //получаем ответ от сервера
  final itemsq = json.decode(response.body).cast<Map<String, dynamic>>();
  //преобразуем ответ в список водителей
  List<Driver> list = itemsq.map<Driver>((json) {
    return Driver.fromJson(json);
  }).toList();

  //заполнение нового списка
  items.clear();
  list.forEach((element) {
    items.add(tableDriver.fromDriver(element));
  });
}

Future<void> insertDriver(Driver driver) async {
  String jsonDriver = driver.toJson(driver);
  await Networker.instance.insertDriver(jsonDriver);
}

Future<void> updateDriver(Driver driver) async {
  String jsonDriver = driver.toJson(driver);
  await Networker.instance.updateDriver(jsonDriver);
}

Future<void> removeDriver() async {
  List<int> list = new List();
  items.forEach((element) {
    if (element.checked == true){
      list.add(element.driver.id);
    }
  });
  await Networker.instance.removeDrivers(list);
}

class _DriversPageState extends State<MyDriversPage> {
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
        title: Text("Drivers"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  selectAllDrivers();
                  setState(() {
                    items = items;
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
                    onSortColumnId(0, sortId);
                  }),
              DataColumn(
                  label: Center(child: Text('FIO')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortFio = !sortFio;
                      sort = sortFio;
                      sortColIndex = 1;
                    });
                    onSortColumnFio(1, sortFio);
                  }),
              DataColumn(
                  label: Center(child: Text('Phone number')),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortNumber = !sortNumber;
                      sort = sortNumber;
                      sortColIndex = 2;
                    });
                    onSortColumnNumber(2, sortNumber);
                  }),
              DataColumn(
                label: Center(child: Text('Edit')),
              ),
            ],
            rows: getDriverListWidget(),
          ),
        ),
      ),
    );
  }

  /**-------------------------------------------------------------------- SORTS ON COLUMNS --------------------------------------------------------------------**/
  onSortColumnId(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        items.sort((a, b) => a.driver.id.compareTo(b.driver.id));
      } else {
        items.sort((a, b) => b.driver.id.compareTo(a.driver.id));
      }
    }
  }

  onSortColumnFio(int columnIndex, bool ascending) {
    if (ascending) {
      items.sort((a, b) => a.driver.fio.compareTo(b.driver.fio));
    } else {
      items.sort((a, b) => b.driver.fio.compareTo(a.driver.fio));
    }
  }

  onSortColumnNumber(int columnIndex, bool ascending) {
    if (sortNumber) {
      items
          .sort((a, b) => a.driver.phoneNumber.compareTo(b.driver.phoneNumber));
    } else {
      items
          .sort((a, b) => b.driver.phoneNumber.compareTo(a.driver.phoneNumber));
    }
  }

  /**-------------------------------------------------------------------- SORTS ON COLUMNS END --------------------------------------------------------------------**/

  /**-------------------------------------------------------------------- FILLING TABLE WITH VALUES --------------------------------------------------------------------**/
  List<DataRow> getDriverListWidget() {
    List<DataRow> list = new List();

    if (items.isEmpty) {
      list.add(new DataRow(
        cells: [
          DataCell(Text("-")),
          DataCell(Text("-")),
          DataCell(Text("-")),
          DataCell(Text("-")),
        ],
        selected: false,
        onSelectChanged: (bool value) {
          setState(() {
            getDriverListWidget();
          });
        },
      ));
      return list;
    } else
      list.clear();

    for (int i = 1; i < items.length; i++) {
      print("On cycle. i = "+i.toString()+"Items.length = "+items.length.toString()+"\n");
      print("Item i="+i.toString()+" == "+items[i].toString());
      list.add(DataRow(
        cells: [
          DataCell(Text('id:${items[i].driver.id}')),
          DataCell(Text('fio:\n${items[i].driver.fio}')),
          DataCell(Text('phone number:\n${items[i].driver.phoneNumber}')),
          DataCell(IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              /**---------------------------editing element dialog + sending request to update------------------------------**/
              setDefaultValuesForUpdateDialog(items[i].driver.id.toString(),
                  items[i].driver.fio, items[i].driver.phoneNumber);
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
