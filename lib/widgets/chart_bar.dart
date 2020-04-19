import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.15,
                  child: FittedBox(
                    child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  color: Colors.white,
                  width: constraints.maxWidth * 0.25,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: spendingPctOfTotal,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.15,
                  child: FittedBox(child: Text(label)),
                ),
              ],
            );
          },
        ));
  }
}
