import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Sale Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const  HomePage(initials: '',),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key,
  required this.initials});
  final String initials;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeinput = TextEditingController();

  ColorSwatch? _tempMainColor;
  Color? _tempShadeColor;
  ColorSwatch? _mainColor = Colors.blue;
  Color? _shadeColor = Colors.blue[800];

  XFile? _image;
  //  XFileBase(String? path);


  Future getImage() async{
    try{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) return;

  final  imageTemporary = image;
  


    setState(() {
     // _image=image;
      this._image=imageTemporary;
    });
    }on PlatformException catch(e){
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Məhsul Sifarişi'),
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
                    labelText: "Sifarişin tarixini daxil edin:"),
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
                    labelText: "Sifarişin başlanğıc saatı:"),
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
                    //print(parsedTime);
                    String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);
                    //print(formattedTime);

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
                    labelText: "Sifarişin bitmə saatı:"),
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
                    String formattedTime =
                        DateFormat('HH:mm',).format(parsedTime);
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
                children: [
                  const SizedBox(height: 22.0),
                  Text(
                    "Məhsulun rəngini seçin:",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: _openColorPicker,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: _mainColor),
                    child: const Text('Məhsulun Rəngi'),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 300,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 22.0),
                  Text(
                    "Məhsulun ölçüləri:",
                    //style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        margin: const EdgeInsets.all(20),
                        child: TextField(
                          decoration: const InputDecoration(labelText: "En:"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: const EdgeInsets.all(10),
                        child: TextField(
                          decoration:
                              const InputDecoration(labelText: "Uzunluq:"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22.0),
                  Text(
                    "Məhsulun şəkli:",
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
                          title: 'Qaleriya',
                          onClick: getImage),
                      CustomButton(
                          icon: Icons.camera,
                          title: 'Kamera',
                          onClick: () {}),
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

  Widget CustomButton(
      {required String title,
      required IconData icon,
      required void Function()? onClick
      }) {
    return Container(
        width: 280,
        child: ElevatedButton(
            onPressed: onClick,
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 20,
                ),
                Text(title),
              ],
            )));
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
