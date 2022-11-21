import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pj1/db/category/category_db.dart';
import 'package:pj1/models/catogories/catogories_model.dart';

ValueNotifier<categorytype> selectedcategorynotifier =
    ValueNotifier(categorytype.income);
Future<void> showcategoryaddpopup(BuildContext context) async {
  final _nameEditingcontroller = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingcontroller,
                decoration: InputDecoration(
                    hintText: "Category name", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  radiobutton(title: ('Income'), type: categorytype.income),
                  radiobutton(title: ('Expence'), type: categorytype.expence)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameEditingcontroller.text;
                    if (_name.isEmpty) {
                      return;
                    }
                    final _type = selectedcategorynotifier.value;
                    final _category = categorymodel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                    categorydb().insertcategory(_category);
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Add')),
            )
          ],
        );
      });
}

class radiobutton extends StatelessWidget {
  final String title;
  final categorytype type;
  radiobutton({required this.title, required this.type, super.key});
  categorytype? _type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedcategorynotifier,
          builder: (BuildContext ctx, categorytype newcategory, Widget? _) {
            return Radio<categorytype>(
              value: type,
              groupValue: newcategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedcategorynotifier.value = value;
                selectedcategorynotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
