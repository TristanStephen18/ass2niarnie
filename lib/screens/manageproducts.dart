import 'package:assignment_2/models/products.dart';
import 'package:assignment_2/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Manageproduct extends StatefulWidget {
   Manageproduct({super.key, this.index});

   int? index;

  @override
  State<Manageproduct> createState() => _ManageproductState();
}

class _ManageproductState extends State<Manageproduct> {
  final formKey = GlobalKey<FormState>();
  var codecon = TextEditingController();

  var namecon = TextEditingController();

  var pricecon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Product>(context, listen: false);
    if(widget.index!=null){
      namecon.text = provider.items[widget.index!].productname;
      codecon.text = provider.items[widget.index!].code;
      pricecon.text = provider.items[widget.index!].price.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index != null ? 'Edit Product': 'Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(30),
              TextFormField(
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return "Please fill up this field";
                  }
                  return null;
                },
                controller: codecon,
                readOnly: widget.index == null ? false : true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: const Text('Product Code'),
                ),
              ),
              Gap(10),
              TextFormField(
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return "Please fill up this field";
                  }
                  return null;
                },
                controller: namecon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: const Text('Product Name'),
                ),),
              Gap(10),
              TextFormField(
                validator: (value){
                   if (value == null || value.isEmpty) {
                  return '*Required field.';
                }
                var ans = double.tryParse(value);
                if (ans == null) {
                  return '*Enter a valid amount';
                }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: pricecon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: const Text('Price'),
                ),),
              Gap(20),
              ElevatedButton(onPressed: (){
                if (formKey.currentState!.validate()) {
                  var p = Products(code: codecon.text, productname: namecon.text, price: double.parse(pricecon.text));
                  if(widget.index != null){
                    provider.ediproduct(p, widget.index!);
                  }else{
                  provider.addproduct(p);
                  }
                  Navigator.of(context).pop();
                }
              }, child: Text(widget.index == null ? 'Add' : 'Edit')),
            ],
          ),)
        ),
      ),
    );
  }
}