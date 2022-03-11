import 'package:expances_planner/model/Transcation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  const TransactionList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assest/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          '\$${transaction[index].amount}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(
                      transaction[index].date,
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transaction[index].id),
                          icon: const Icon(
                            Icons.delete,
                          ),
                          label: const Text(
                            'Delete',
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () => deleteTx(transaction[index].id),
                        ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
