import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pj1/screens/home/screen_home.dart';

class moneybottumnavigation extends StatelessWidget {
  const moneybottumnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: screenhome.selectedindexnotifier,
      builder: (BuildContext ctx, int updatedindex, Widget? _) {
        return BottomNavigationBar(
            currentIndex: updatedindex,
            onTap: (newindex) {
              screenhome.selectedindexnotifier.value = newindex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Catogories ',
              ),
            ]);
      },
    );
  }
}
