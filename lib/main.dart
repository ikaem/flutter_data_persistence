import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_data_persistence/pizza.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter JSON Demo",
      theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = "";

  @override
  void initState() {
    _readJsonFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON"),
      ),
      body: Container(
        // child: Text(pizzaString),
        child: FutureBuilder(
          future: _readJsonFile(),
          builder: (BuildContext context, AsyncSnapshot<List<Pizza>> pizzas) {
            if (pizzas.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return ListView.builder(
                itemCount: (pizzas.data == null) ? 0 : pizzas.data?.length,
                itemBuilder: (BuildContext context, int position) {
                  // if (pizzas.data == null) {
                  //   return Text("");
                  // }
                  //else {

                  print("this is pizza: ${pizzas.data?[position].pizzaName}");

                  String pizzaName = pizzas.data?[position].pizzaName ?? "";
                  String pizzaDescription =
                      pizzas.data?[position].description ?? "";
                  String pizzaPrice =
                      pizzas.data?[position].price.toString() ?? "";

                  return ListTile(
                    title: Text(pizzaName),
                    subtitle: Text("$pizzaDescription - \$$pizzaPrice"),
                  );
                  // }
                });
          },
        ),
      ),
    );
  }

  Future<List<Pizza>> _readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context)
        .loadString("assets/pizzalist.json");

    List myMap = jsonDecode(myString);
    // print("this is my map: $myMap");

    List<Pizza> myPizzas = [];

    myMap.forEach((pizza) {
      try {
        // Pizza myPizza = Pizza.fromJson(pizza);
        Pizza myPizza = Pizza.fromJsonOrNull(pizza);
        myPizzas.add(myPizza);
      } catch (e) {
        print("there was an error");
      }
    });
    // print("this is my map: $myPizzas");

    // setState(() {
    //   pizzaString = myString;
    // });

// test
    String json = convertToJson(myPizzas);
    print("json: $json");

    return myPizzas;
  }

  String convertToJson(List<Pizza> pizzas) {
    // this is so clumsy
    String json = "[";

    pizzas.forEach((pizza) {
      json += jsonEncode(pizza);
    });

    json += "]";

    return json;
  }
}
