import 'package:database_app/product.dart';
import 'package:database_app/product_db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
      ),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showProductDialogBox(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // =================== show product dialog box ..... Name, price, quantity ........
  showProductDialogBox(BuildContext context){

    Widget saveButton = OutlinedButton(onPressed: (){
      if(_nameController.text.isNotEmpty && _priceController.text.isNotEmpty && _quantityController.text.isNotEmpty)
      {
        Product product = Product();
        product.name = _nameController.text;
        product.price = _priceController.text;
        product.quantity = int.parse(_quantityController.text);

        ProductDBHelper.instance.insertProduct(product).then((value){
          ProductDBHelper.instance.getProductList().then((value){

          });

          Navigator.pop(context);
        });
      }
    }, child: Text('Save'));

    Widget cancelButton = OutlinedButton(onPressed: (){
      Navigator.of(context).pop();
    }, child: Text('Cancel'));

    AlertDialog productDetailsBox = AlertDialog(
      title: Text('Add new Product'),
      content: Container(
        child: Wrap(
          children: [
            Container(
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Prodcut Name'
                ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Prodcut Price'
                ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Prodcut Quantity'
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        saveButton,
        cancelButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context){
      return productDetailsBox;
    });

  }
}
