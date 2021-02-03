import 'package:flight/models/plan.dart';
import 'package:flutter/material.dart';

class PlansList extends StatelessWidget {
  final List<Plan> plans;

  PlansList({Key key, this.plans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Table(children: [
                  TableRow(children: [
                    buildTable1(),
                    buildTable2(),
                    buildTable3(),
                    buildTable4(),
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Center(
                          child: Text(
                        plans[index].id.toString(),
                        style: TextStyle(fontSize: 20),
                      )),
                      verticalAlignment: TableCellVerticalAlignment.bottom,
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                          child: Text(plans[index].fromICAO,
                              style: TextStyle(fontSize: 20))),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                          child: Text(plans[index].toICAO,
                              style: TextStyle(fontSize: 20))),
                    ),
                    TableCell(
                      child: Center(
                          child: Text(
                              plans[index].downloads.toString() + "indirme",
                              style: TextStyle(fontSize: 20))),
                      verticalAlignment: TableCellVerticalAlignment.top,
                    ),
                  ]),
                ]),
                buildDetailButton(),
              ],
            ));
      },
    );
  }

  Widget buildTable1() {
    return TableCell(
        child: Center(
            child: Text(
      'Rota Id',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    )));
  }

  Widget buildTable2() {
    return TableCell(
      child: Center(
          child: Text('Kalkış',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
    );
  }

  Widget buildTable3() {
    return TableCell(
        child: Center(
            child: Text('Varış',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))));
  }

  Widget buildTable4() {
    return TableCell(
        child: Center(
            child: Text('İndirme',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))));
  }

  Widget buildDetailButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
      child: Text("detaylar", style: TextStyle(fontSize: 15)),
      onPressed: () {},
    );
  }
}
