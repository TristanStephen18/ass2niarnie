import 'package:assignment_2/models/cart.dart';
import 'package:assignment_2/models/products.dart';
import 'package:assignment_2/providers/cart_provider.dart';
import 'package:assignment_2/providers/products_provider.dart';
import 'package:assignment_2/screens/manageproducts.dart';
import 'package:assignment_2/screens/viewcart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Viewscreen extends StatefulWidget {
  Viewscreen({super.key});

  @override
  State<Viewscreen> createState() => _ViewscreenState();
}

class _ViewscreenState extends State<Viewscreen> {
  bool filter = false;

  List<Products> todisplay = [];
  List<Products> favs = [];

  @override
  Widget build(BuildContext context) {
    var provide = Provider.of<Product>(context, listen: false);
    todisplay = filter ? provide.favs : provide.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Products"),
        actions: [
          IconButton(
            tooltip: "Add a Product",
            onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Manageproduct()));
          }, icon: Icon(Icons.add)),
          PopupMenuButton(
            tooltip: "Filter",
            onSelected: (value) {
              if(value == 'All'){
               setState(() {
                  filter = false;
               });
              }
              if(value == 'Favourites'){
                setState(() {
                  filter = true;
                });
              }
            },
            itemBuilder: (_)=><PopupMenuEntry<String>>[
            PopupMenuItem(
              value: 'All',
              child: const Text("All"),
            ),
            PopupMenuItem(
              value: 'Favourites',
              child: const Text('Favourites'))
          ])
        ],
      ),
      body: Consumer<Product>(
        builder: (context, provider, child) => 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: ListView.builder(
                itemCount: todisplay.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                  key: Key(todisplay[index].productname), 
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete_forever)
                  ),
                  onDismissed: (direction){
                      if(todisplay[index].isFav){
                        setState(() {
                        provider.favs.removeAt(index);
                        provider.items.removeAt(index);
                      });
                      }else{
                        setState(() {
                          provider.items.removeAt(index);
                        });
                      }
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
                      tileColor: todisplay[index].isFav ? const Color.fromARGB(255, 243, 105, 95) : Colors.white,
                      title: Text(todisplay[index].productname),
                      subtitle: Text(todisplay[index].price.toString()),
                      leading: IconButton(onPressed: (){
                        provider.toggleisfav(index);
                        if (provider.favs.contains(todisplay[index])) {
                        provider.favs.remove(todisplay[index]);
                      } else {
                        provider.favs.add(todisplay[index]);
                      }
                      }, icon: Icon(
                        todisplay[index].isFav ?
                        Icons.favorite : Icons.favorite_outline
                        ),),
                      trailing: IconButton(onPressed: (){
                        Provider.of<Cart>(context, listen: false).add(CartItem(productCode: todisplay[index].code));
                      }, icon: Icon(Icons.shopping_basket)),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Manageproduct(index: index,)));
                      },
                    ),
                  ));
                },
              ),
              )
            ],
          ),
        ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Cartitems()));
        },
        tooltip: "View Cart",
        child: const Icon(Icons.shopping_cart),
        ),
    );
  }
}