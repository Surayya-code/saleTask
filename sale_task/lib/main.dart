import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'widgets/custom_button.dart';
import 'widgets/product_size.dart';
//import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Sale Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(
        initials: '',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.initials});
  final String initials;

  @override
  State<HomePage> createState() => _HomePageState();
}

/////ColorItem///
class ColorItem {
  ColorItem(this.name, this.color);
  final String name;
  final Color color;
}

class _HomePageState extends State<HomePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeinput = TextEditingController();

  ColorSwatch? _tempMainColor;
  Color? _tempShadeColor;
  ColorSwatch? _mainColor = Colors.blue;
  Color? _shadeColor = Colors.blue[800];

  XFile? _image;

/////ColorItem///
   final List<ColorItem> items = [
    ColorItem("red", Colors.red),
    ColorItem("pink", Colors.pink),
    ColorItem("grey", Colors.grey),
    ColorItem("green", Colors.green),
    ColorItem("yellow", Colors.yellow),
    ColorItem("amber", Colors.amber),
    ColorItem("blue", Colors.blue),
    ColorItem("black", Colors.black,),
    ColorItem("white", Colors.white),
    ColorItem("orange", Colors.deepOrange),
  ];
  late ColorItem currentChoice;



  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      //final  imageTemporary = image;

      setState(() {
        _image = image;
        //this._image=imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }

    //   Future<File> saveFilePermanently(String imagePath)async{
    //     final directory=await getApplicationDocumentsDirectory();
    //     final name=basename(imagePath);
    //     final image= File('${directory.path}/$name');

    //     return File(directory,name);
    // }
  }

  @override
  void initState() {
    super.initState();
    timeinput.text = "";
    dateController.text = '';
    currentChoice = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Order'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              width: 250,
              // height: 150,
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Enter product Order date:"),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat("yyyy-MM-dd").format(pickedDate);
                    setState(() {
                      dateController.text = formattedDate.toString();
                    });
                  } else {
                    //print('Not selected');
                  }
                },
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: timeinput,
                decoration: const InputDecoration(
                    icon: Icon(Icons.timer),
                    labelText: "Order start time :"),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (pickedTime != null) {
                    // print(pickedTime.format(context));
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());
                    String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);

                    setState(() {
                      timeinput.text = formattedTime;
                    });
                  } else {
                    // print("Time is not selected");
                  }
                },
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: timeinput,
                decoration: const InputDecoration(
                    icon: Icon(Icons.timer),
                    labelText: "Order end time:"),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (pickedTime != null) {
                    //  print(pickedTime.format(context));
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());
                    //print(parsedTime);
                    String formattedTime = DateFormat(
                      'HH:mm',
                    ).format(parsedTime);
                    //print(formattedTime);

                    setState(() {
                      timeinput.text = formattedTime;
                    });
                  } else {
                    //print("Time is not selected");
                  }
                },
              ),
            ),
            SizedBox(
              width: 250,
              child: Column(
                mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 22.0),
                  Text(
                    "Choose Product Color:",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 12.0),
                  // ElevatedButton(
                  //   onPressed: _openColorPicker,
                  //   style:
                  //       ElevatedButton.styleFrom(backgroundColor: _mainColor),
                  //   child: const Text('Məhsulun Rəngi'),
                  // ),
            //       Icon(
            //   Icons.face,
            //   color: currentChoice.color,
            //   size: 100.0,
            // ),
            // Image.network(
            //   'https://images-na.ssl-images-amazon.com/images/I/318wxAI2mBL._SL500_._AC_SL500_.jpg'),
            Container(
              width: 150,
              child: DropdownButton(
                isExpanded: true,
                style: Theme.of(context).textTheme.headline6,
                value: currentChoice,
                selectedItemBuilder: (BuildContext context) => items
                 .map<Widget>((ColorItem item) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.square, color: item.color)
                  ),
              Text(item.name),
            ],
          ))
                 .toList(),
              items: items
      .map<DropdownMenuItem<ColorItem>>(
          (ColorItem item) => DropdownMenuItem<ColorItem>(
                value: item,
                child: Container(
                  alignment: Alignment.center,
                  constraints:const  BoxConstraints(minHeight: 48.0),
                  color: item.color,
                  child: Text(item.name),
                ),
              ))
      .toList(),
  onChanged: (ColorItem? value) =>
      setState(() => currentChoice = value!),
              ),
            ),
                  
                ],
                
              ),
            ),
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  const SizedBox(height: 22.0),
                  Text(
                    "Product Sizes:",
                    //style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    children: const [
                      ProductSize(
                        labelText: 'Wide:',
                      ),
                      ProductSize(labelText: 'Lenght:'),
                    ],
                  ),
                  const SizedBox(height: 22.0),
                  Text(
                    "Product Image:",
                    //style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.network(
                          'https://images-na.ssl-images-amazon.com/images/I/318wxAI2mBL._SL500_._AC_SL500_.jpg'),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          icon: Icons.image_outlined,
                          title: 'Gallery',
                          onClick:() =>getImage(ImageSource.gallery)),
                      CustomButton(
                          icon: Icons.camera, title: 'Camera', onClick: () =>getImage(ImageSource.camera)),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('İMTİNA'),
            ),
            TextButton(
              child: const Text('SEÇ'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Rəng seçin",
      MaterialColorPicker(
        selectedColor: _shadeColor,
        onColorChange: (color) => setState(() => _tempShadeColor = color),
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        //onBack: () => print("Geri"),
      ),
    );
  }
}
