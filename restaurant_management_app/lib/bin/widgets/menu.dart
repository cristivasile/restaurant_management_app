import 'package:flutter/material.dart';
import 'package:restaurant_management_app/bin/constants.dart';

List<String> sections = [
  "Appetizers",
  "Main courses",
  "Sides",
  "Soft drinks",
  "Spirits"
];

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      itemBuilder: (BuildContext context, int index) {
        return MenuSection(title: sections[index]);
      },
      itemCount: sections.length,
    );
  }
}

class MenuSection extends StatefulWidget {
  final String title;

  const MenuSection({Key? key, required this.title}) : super(key: key);

  @override
  _MenuSectionState createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget>[
          Container(
            color: accent1Color,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        color: mainColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          expandFlag
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    }),
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: mainColor),
                )
              ],
            ),
          ),
          MenuSectionContent(
              expanded: expandFlag,
              child: ListView.builder(
                controller: ScrollController(),
                itemBuilder: (BuildContext context, int index) {
                  return MenuItem(index: index);
                },
                itemCount: 15,
              ))
        ],
      ),
    );
  }
}

class MenuSectionContent extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  const MenuSectionContent({
    Key? key,
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 400.0,
    this.expanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        child: child,
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final int index;

  const MenuItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: accent1Color),
          color: accent2Color),
      child: ListTile(
        title: Text(
          "Cool $index",
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: const Icon(
          Icons.local_pizza,
          color: Colors.white,
        ),
      ),
    );
  }
}
