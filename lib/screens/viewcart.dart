import 'package:assignment_2/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartitems extends StatefulWidget {
  const Cartitems({super.key});

  @override
  State<Cartitems> createState() => _CartitemsState();
}

class _CartitemsState extends State<Cartitems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: Consumer<Cart>(
        builder: (context, cartprovider, child) => Column(
          children: [
            Expanded(child: ListView.builder(
              itemCount: cartprovider.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(cartprovider.items[index].productCode), 
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete),
                  ),
                  onDismissed: (direction){
                    setState(() {
                      cartprovider.items.removeAt(index);
                    });
                  },
                  confirmDismiss: (direction) async {
                    return await showDialog(context: context, builder: (_)=>
                    AlertDialog(
                      title: Text('Confirm Delete?'),
                      content: const Text('You are about to delete this item?'),
                      actions: [
                        ElevatedButton(onPressed: ()=> Navigator.of(context).pop(true), child: Text('Yes')),
                        ElevatedButton(onPressed: ()=> Navigator.of(context).pop(false), child: Text('No')),
                      ],
                    )
                    );
                  },
                  child: Card(
                  child: ListTile(
                    title: Text(cartprovider.items[index].productCode),
                    trailing: Text(cartprovider.items[index].quantity.toString()),
                  ),
                ));
              },
            ),)
          ],
        )
        ),
    );
  }
}