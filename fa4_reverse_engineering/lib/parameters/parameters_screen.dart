import 'package:fa4_reverse_engineering/data/parameters.dart';
import 'package:fa4_reverse_engineering/model/parameter.dart';
import 'package:fa4_reverse_engineering/parameters/add_parameters.dart';
import 'package:flutter/material.dart';

class ParametersScreen extends StatefulWidget {
  const ParametersScreen({super.key});

  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  final searchController = TextEditingController();

  List<Parameter> get filteredParameters {
    return parameters.where((item) {
    final searchText = searchController.text.toLowerCase();

    return item.parameterName.toLowerCase().contains(searchText) ||
        item.parameterClass.toLowerCase().contains(searchText);
  }).toList();
  }

  void addParameter() async {
    final result = await Navigator.push<Parameter>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddClassScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        parameters.add(result);
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  'Parameter Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: addParameter,
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search by Class',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                itemCount: filteredParameters.length,
                itemBuilder: (context, index) {
                  final item = filteredParameters[index];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 20,
                      height: 20,
                      color: item.color,
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.parameterName,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          item.parameterClass.toUpperCase(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 10,
                            ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
