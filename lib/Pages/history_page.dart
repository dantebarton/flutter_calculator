import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key, required this.historyData}) : super(key: key);
  final List<String> historyData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: ListView.builder(
          itemCount: historyData.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                  title: Text(historyData[index]),
                  onTap: () {
                    Navigator.of(context).pop(index);
                  }),
            );
          },
        ));
  }
}
