import 'package:flutter/material.dart';
import 'package:notification_all_ppp/directory/search_datas/provider_datas.dart';
import 'package:provider/provider.dart ';

class SearchCity extends StatefulWidget {
  const SearchCity({Key? key}) : super(key: key);

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProviderDataCity>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City/State"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchFilter());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Consumer<ProviderDataCity>(
        builder: (context, value, child) {
          return value.loadings
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: value.dataAll.data.length,
                  itemBuilder: (context, index) {
                    final data = value.dataAll.data[index];
                    return Card(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(data.name),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

class SearchFilter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
            showSuggestions(context);
          },
          icon: Icon(Icons.close))
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
    return Container(
      child: Column(
        children: [
          Text(this.query),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future.delayed(Duration.zero, () {
      context.read<ProviderDataCity>().searchData(this.query);
    });
    return Consumer<ProviderDataCity>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.states.length,
          itemBuilder: (context, index) {
            final data = value.states[index];
            return GestureDetector(
              onTap: () {
                this.query = data.name;
                print(data.toString());
                showResults(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Column(
                  children: [Text(data.name), Text(data.stateCode.toString())],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
