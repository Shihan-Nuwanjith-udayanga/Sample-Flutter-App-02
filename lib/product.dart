class Product{

  int ? id;
  String ? name;
  String ? price;
  int ? quantity;

  Product({ this.id ,  this.name ,  this.price ,  this.quantity});

  // ==== From map ...... Map => Product Object
  static Product fromMap(Map<dynamic, dynamic>query){
    Product product = Product();
    product.id = query['id'];
    product.name = query['name'];
    product.price = query['price'];
    product.quantity = query['quantity'];
    return product;
  }

  // ========= To Map ----------- Product => Map
  static Map<String, dynamic> toMap(Product product){
    return <String, dynamic>{
      'id' : product.id,
      'name' : product.name,
      'price' : product.price,
      'quantity' : product.quantity,
    };
  }

  // =========== From map List --------- Map List => Product List
  static List<Product> fromMapList(List<Map<dynamic, dynamic>> query){
    List<Product> products = <Product>[];
    for(Map mp in query){
      products.add(fromMap(mp));
    }
    return products;
  }

}