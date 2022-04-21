const keyId = "id";
const keyName = "pizzaName";
const keyDescription = "description";
const keyPrice = "price";
const keyImage = "imageUrl";

class Pizza {
  late int id;
  late String pizzaName;
  late String description;
  late double price;
  late String imageUrl;

  // this is a contstructor - a named cosntructor, or static coonstructor?
  // Pizza.fromJson(Map<String, dynamic> json) {
  //   id = json["id"];
  //   pizzaName = json["pizzaName"].toString();
  //   description = json["description"].toString();
  //   price = json["price"];
  //   imageUrl = json["imageUrl"].toString();
  // }

  // this is some kind of factory constructor
  Pizza();
  factory Pizza.fromJsonOrNull(Map<String, dynamic> json) {
    // notice how here we actually initialize it before
    Pizza pizza = Pizza();

// so here, we get some if, we get it to string, and then we actually again try parse as ineger
    // pizza.id = (json["id"] != null) ? int.parse(json["id"].toString()) : 0;
    // pizza.id = int.tryParse(json["id"]) ?? 0;
    pizza.id = json[keyId] ?? 0;
    pizza.pizzaName = json[keyName].toString();
    pizza.description = json[keyDescription].toString();
    // pizza.price = double.tryParse(json["id"]) ?? 0;
    pizza.price = json[keyPrice] ?? 0;
    pizza.imageUrl = json[keyImage].toString();

    if (pizza.id == 0 ||
        pizza.pizzaName.trim() == "" ||
        pizza.pizzaName == "null") {
      print("is something wrong?!!!");
      throw "Something went wrong";

      // return null;
    }

    return pizza;
  }

  Pizza.fromJson(Map<String, dynamic> json) {
    // id = int.tryParse(json["id"].toString());
    id = json["id"];
    pizzaName = json["pizzaName"].toString();
    description = json["description"].toString();
    price = json["price"];
    imageUrl = json["imageUrl"].toString();
  }

  // needed to be able to serialize class into json later
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "pizzaName": pizzaName,
      "description": description,
      "price": price,
      "imageUrl": imageUrl,
    };
  }
}
