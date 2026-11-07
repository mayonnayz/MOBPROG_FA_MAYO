import 'package:fa4_reverse_engineering/model/parameter.dart';
import 'package:flutter/material.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({super.key});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final nameController = TextEditingController();
  final classController = TextEditingController();

  Color selectedColor = Colors.black;

  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.black,
    Colors.white,
  ];

  @override
  void dispose() {
    nameController.dispose();
    classController.dispose();
    super.dispose();
  }

  void reset() {
    setState(() {
      nameController.clear();
      classController.clear();
      selectedColor = Colors.black;
    });
  }

  InputDecoration lineStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      counterText: '',
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF73342C),
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF73342C),
        ),
      ),
    );
  }

  void addParameter() {
    if (nameController.text.trim().isEmpty ||
        classController.text.trim().isEmpty) {
      return;
    }

    Navigator.pop(
      context,
      Parameter(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        parameterName: nameController.text.trim(),
        parameterClass: classController.text.trim(),
        color: selectedColor,
      ),
    );
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
                  'Add a new parameter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        labelText: 'Parameter Name',
                      ),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Color Picker',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: colors.map((color) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedColor == color
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: classController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              labelText: 'Parameter Class',
                              counterText: '',
                            ),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: selectedColor,
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outline,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '#${selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                                  style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor,),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: reset,
                          child: const Text('Reset'),
                        ),
                        ElevatedButton(
                          onPressed: addParameter,
                          child: const Text('Add Parameter'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
