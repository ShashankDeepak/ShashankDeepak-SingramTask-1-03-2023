import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/box.dart';

class MatrixPage extends StatefulWidget {
  const MatrixPage({super.key});

  @override
  State<MatrixPage> createState() => _MatrixPageState();
}
//I have used GetX state management tool for this. Thats why the list are marked with .obs

RxList<dynamic> boxes = [].obs; //Contains list of all the boxes at present
RxList<dynamic> currentlySelected =
    [].obs; // Contains list of boxes that are highleted

var height = Get.height; //Height of the screen
var width = Get.width; //Width of the screen

//This functions creates a total of 16 boxes and prodvide them with details
void initializeBox() {
  for (int i = 1; i <= 16; i++) {
    Box temp = Box(
      color: Colors.blue,
      index: i,
      isEnabledBlue: false,
      isRed: false,
      text: "Box #$i",
      textColor: Colors.blue,
    );
    boxes.add(temp);
  }
}

//This defines the layout of the box in the matrix
Widget box(Box box) {
  return Container(
    width: width / 4,
    height: 40,
    decoration: BoxDecoration(
      color: box.color,
      border: Border.all(),
    ),
    child: Align(
      alignment: Alignment.centerRight,
      child: Text(
        "Box #${box.index}",
        style: TextStyle(color: box.textColor),
      ),
    ),
  );
}

class _MatrixPageState extends State<MatrixPage> {
  @override
  void initState() {
    super.initState();
    initializeBox(); //All the boxes are initialized here
  }

  @override
  Widget build(BuildContext context) {
    //This is main controlling function, if the length of currently selected list
    //is greater than 2 it will automatically adjust the color and property of that box and delete the first selected box.
    //If the legth is 1 or 0 it will just add the box to the list just chnaging the properties
    void addToCurrent(Box box) {
      if (currentlySelected.length >= 2) {
        currentlySelected[0].color = Colors.blue;

        currentlySelected[0] = currentlySelected[1];
        currentlySelected[1] = box;

        currentlySelected[1].color = Colors.red;
        currentlySelected[1].textColor = Colors.white;
        setState(() {});
      }
      if (currentlySelected.length == 1) {
        currentlySelected.add(box);
        currentlySelected[1].color = Colors.red;
        currentlySelected[1].textColor = Colors.white;
        setState(() {});
      } else {
        currentlySelected.add(box);
        currentlySelected[0].color = Colors.red;
        currentlySelected[0].textColor = Colors.white;
        setState(() {});
      }
    }

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: boxes.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        addToCurrent(boxes[index]);
                      },
                      child: Obx(() => box(boxes[index])));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
