import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:mass_pro/tree_examples/tree1.dart';

class NodeDataUpdate extends StatefulWidget {
  const NodeDataUpdate({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NodeDataUpdate> {
  int stateCount = 0;

  void _nextTree() {
    setState(() {
      if (stateCount < testTrees.length - 1) {
        stateCount++;
      } else {
        stateCount = 0;
      }
    });
    Future.microtask(
      () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(testTrees[stateCount].key),
          duration: const Duration(seconds: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextTree,
        child: const Icon(Icons.fast_forward),
      ),
      body: TreeView.simple(
        tree: testTrees[stateCount].value,
        expansionBehavior: ExpansionBehavior.none,
        shrinkWrap: true,
        showRootNode: true,
        builder: (context, node) => Card(
          color: colorMapper[node.level.clamp(0, colorMapper.length - 1)],
          child: ListTile(
            title: Text('Item ${node.level}-${node.key}'),
            subtitle: Text('Data ${node.data}'),
          ),
        ),
      ),
    );
  }
}

class StringTreeNode extends TreeNode<String> {
  StringTreeNode({super.data, super.parent});
}

final testTrees = <MapEntry<String, TreeNode<dynamic>>>[
  MapEntry('Default tree', defaultTree),
  MapEntry('Updated tree', updatedTree),
  MapEntry('Updated tree 2', updatedTree2),
];

final defaultTree = TreeNode.root()
  ..addAll([
    TreeNode(key: '0A', data: 'd_0A')
      ..add(TreeNode(key: '0A1A', data: 'd_0A1A')),
    TreeNode(key: '0C', data: 'd_0C')
      ..addAll([
        TreeNode(key: '0C1A', data: 'd_0C1A'),
        TreeNode(key: '0C1B', data: 'd_0C1B'),
        TreeNode(key: '0C1C', data: 'd_0C1C')
          ..addAll([TreeNode(key: '0C1C2A', data: 'd_0C1C2A')]),
      ]),
    TreeNode(key: '0D', data: 'd_0D'),
    TreeNode(key: '0E', data: 'd_0E'),
  ]);

final updatedTree = TreeNode.root()
  ..addAll([
    TreeNode(key: '0A', data: 'd_0A2')
      ..add(TreeNode(key: '0A1A', data: 'd_0A1A2')),
    TreeNode(key: '0C', data: 'd_0C2')
      ..addAll([
        TreeNode(key: '0C1A', data: 'd_0C1A2'),
        TreeNode(key: '0C1B', data: 'd_0C1B2'),
        TreeNode(key: '0C1C', data: 'd_0C1C2')
          ..addAll([TreeNode(key: '0C1C2A', data: 'd_0C1C2A2')]),
      ]),
    TreeNode(key: '0D', data: 'd_0D2'),
    TreeNode(key: '0E', data: 'd_0E2'),
  ]);

final updatedTree2 = TreeNode.root()
  ..addAll([
    TreeNode(key: '0A', data: 'd_0A3')
      ..add(TreeNode(key: '0A1A', data: 'd_0A1A3')),
    TreeNode(key: '0C', data: 'd_0C23')
      ..addAll([
        TreeNode(key: '0C1A', data: 'd_0C1A3'),
        TreeNode(key: '0C1B', data: 'd_0C1B3'),
        TreeNode(key: '0C1C', data: 'd_0C1C3')
          ..addAll([TreeNode(key: '0C1C2A', data: 'd_0C1C2A3')]),
      ]),
    TreeNode(key: '0D', data: 'd_0D3'),
    TreeNode(key: '0E', data: 'd_0E3'),
  ]);
