// ignore_for_file: sort_constructors_first

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:mass_pro/main_app.dart';

class TreeViewCustomObject extends StatefulWidget {
  const TreeViewCustomObject({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TreeViewCustomObjectState createState() => _TreeViewCustomObjectState();
}

class _TreeViewCustomObjectState extends State<TreeViewCustomObject> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TreeView.simpleTyped<UserName, TreeNode<UserName>>(
        tree: tree,
        expansionBehavior: ExpansionBehavior.collapseOthersAndSnapToTop,
        shrinkWrap: true,
        builder: (context, node) => Card(
          color: colorMapper[node.level.clamp(0, colorMapper.length - 1)],
          child: ListTile(
            title: Text('Item ${node.level}-${node.key}'),
            subtitle: Text('${node.data?.firstName} ${node.data?.lastName}'),
          ),
        ),
      ),
    );
  }
}

class UserName {
  final String firstName;
  final String lastName;

  UserName(this.firstName, this.lastName);
}

final tree = TreeNode<UserName>.root(data: UserName('User', 'Names'))
  ..addAll([
    TreeNode<UserName>(key: '0A', data: UserName('Sr. John', 'Doe'))
      ..add(TreeNode(key: '0A1A', data: UserName('Jr. John', 'Doe'))),
    TreeNode<UserName>(key: '0C', data: UserName('General', 'Lee'))
      ..addAll([
        TreeNode<UserName>(key: '0C1A', data: UserName('Major', 'Lee')),
        TreeNode<UserName>(key: '0C1B', data: UserName('Happy', 'Lee')),
        TreeNode<UserName>(key: '0C1C', data: UserName('Busy', 'Lee'))
          ..addAll([
            TreeNode<UserName>(key: '0C1C2A', data: UserName('Jr. Busy', 'Lee'))
          ]),
      ]),
    TreeNode<UserName>(key: '0D', data: UserName('Mr. Anderson', 'Neo')),
    TreeNode<UserName>(key: '0E', data: UserName('Mr. Smith', 'Agent')),
  ]);
