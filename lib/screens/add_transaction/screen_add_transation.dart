//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pj1/db/category/category_db.dart';
import 'package:pj1/db/transactions/transaction_db.dart';
import 'package:pj1/models/catogories/catogories_model.dart';
import 'package:pj1/models/trandactions/transactions_%20model.dart';

class screenaddtransation extends StatefulWidget {
  static const routename = 'add-transaction';

  const screenaddtransation({super.key});

  @override
  State<screenaddtransation> createState() => _screenaddtransationState();
}

class _screenaddtransationState extends State<screenaddtransation> {
  DateTime? _selecteddate;

  categorytype? _selectedcategorytype;

  categorymodel? _selectedcategorymodel;

  String? _categoryid;

  final _purposetexteditingcontoller = TextEditingController();
  final _amount = TextEditingController();

  @override
  void initState() {
    _selectedcategorytype = categorytype.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _purposetexteditingcontoller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Purpose'),
              ),
              TextFormField(
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Amount'),
              ),
              TextButton.icon(
                onPressed: () async {
                  final _selecteddatetemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (_selecteddatetemp == null) {
                    return;
                  } else {
                    print(_selecteddatetemp.toString());
                    setState(
                      () {
                        _selecteddate = _selecteddatetemp;
                      },
                    );
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _selecteddate == null
                      ? 'select date'
                      : _selecteddate.toString(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: categorytype.income,
                        groupValue: _selectedcategorytype,
                        onChanged: (newvalue) {
                          setState(
                            () {
                              _selectedcategorytype = categorytype.income;
                              _categoryid = null;
                            },
                          );
                        },
                      ),
                      Text('Income')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: categorytype.expence,
                        groupValue: _selectedcategorytype,
                        onChanged: (newvalue) {
                          setState(
                            () {
                              _selectedcategorytype = categorytype.expence;
                              _categoryid = null;
                            },
                          );
                        },
                      ),
                      Text('Expense')
                    ],
                  ),
                ],
              ),
              DropdownButton(
                value: _categoryid,
                hint: Text('Selected Category'),
                items: (_selectedcategorytype == categorytype.income
                        ? categorydb().incomecatogorylist
                        : categorydb().expencecatogorylist)
                    .value
                    .map(
                  (e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectedcategorymodel = e;
                      },
                    );
                  },
                ).toList(),
                onChanged: (seletedvalue) {
                  print(seletedvalue);
                  setState(
                    () {
                      _categoryid = seletedvalue;
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  addtransaction();
                },
                //  icon: Icon(Icons.add),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addtransaction() async {
    final _purposetext = _purposetexteditingcontoller.text;
    final _amounttext = _amount.text;
    if (_purposetext.isEmpty) {
      return;
    }

    if (_amounttext.isEmpty) {
      return;
    }

    // if (_categoryid == null) {
    //   return;
    // }

    if (_selecteddate == null) {
      return;
    }

    final _parsedamount = double.tryParse(_amounttext);

    if (_parsedamount == null) {
      return;
    }
    if (_selectedcategorymodel == null) {
      return;
    }

    final _model = transactionmodel(
      purpose: _purposetext,
      amount: _parsedamount,
      date: _selecteddate!,
      type: _selectedcategorytype!,
      category: _selectedcategorymodel!,
    );
    await transactiondb.instance.addtransaction(_model);
    Navigator.of(context).pop();
    transactiondb.instance.refresh();
  }
}
