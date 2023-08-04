import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notification_all_ppp/main.dart';
import 'package:provider/provider.dart';

class D4SearchPage extends StatefulWidget {
  const D4SearchPage({Key? key}) : super(key: key);

  @override
  State<D4SearchPage> createState() => _D4SearchPageState();
}

class _D4SearchPageState extends State<D4SearchPage> {
  @override
  void initState() {
    context.read<ProviderData>().dataGet();
    super.initState();
  }

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SerachlistData());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: providerData.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<ProviderData>(
              builder: (context, providerData, _) {
                print(providerData.searchdata.data.length);
                return Column(
                  children: [
                    TextField(
                      controller: controller,
                      onChanged: (v) {
                        providerData.searchNames(v);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: providerData.searchdata.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                providerData.searchdata.data[index].userName),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}

class ProviderData extends ChangeNotifier {
  bool loading = true;
  Pet pets = Pet(data: []);
  Pet searchdata = Pet(data: []);
  void dataGet() async {
    try {
      final res = await http.get(Uri.parse(
          "https://jatinderji.github.io/users_pets_api/users_pets.json"));
      pets = petFromJson(res.body);
      loading = false;
      updateData();
    } catch (e) {
      scaffoldState.currentState
          ?.showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e.toString());
    }
  }

  String searchName = "";
  updateData() {
    searchdata.data.clear();
    if (searchName.isEmpty) {
      searchdata.data.addAll(pets.data);
    } else {
      searchdata.data.addAll(pets.data
          .where(
              (element) => element.userName.toLowerCase().contains(searchName))
          .toList());
    }
    notifyListeners();
  }

  searchNames(String value) {
    print("Searchname--$value");
    searchName = value;
    updateData();
  }
}

class SerachlistData extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
            showSuggestions(context);
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchPageShowData(query: this.query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      context.read<ProviderData>().searchNames(query);
    }
    return Consumer<ProviderData>(
      builder: (context, providerData, _) {
        return ListView.builder(
          itemCount: providerData.searchdata.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                query = providerData.searchdata.data[index].userName;
                showResults(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(providerData.searchdata.data[index].userName),
              ),
            );
          },
        );
      },
    );
  }
}

class SearchPageShowData extends StatefulWidget {
  String query;
  SearchPageShowData({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchPageShowData> createState() => _SearchPageShowDataState();
}

class _SearchPageShowDataState extends State<SearchPageShowData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      loadingCheck();
    });
  }

  bool isLoading = true;
  loadingCheck() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            alignment: Alignment.center,
            child: Text(widget.query),
          );
  }
}

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));

String petToJson(Pet data) => json.encode(data.toJson());

class Pet {
  List<Datum> data;

  Pet({
    required this.data,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String userName;
  String petName;
  String petImage;
  bool isFriendly;

  Datum({
    required this.id,
    required this.userName,
    required this.petName,
    required this.petImage,
    required this.isFriendly,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userName: json["userName"],
        petName: json["petName"],
        petImage: json["petImage"],
        isFriendly: json["isFriendly"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "petName": petName,
        "petImage": petImage,
        "isFriendly": isFriendly,
      };
}

class AppException implements Exception {
  final message;
  final prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix--$message";
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super(message, "No Internet Found?!!");
}
