import 'package:belajarulang/controllers/DataHelper.dart';
import 'package:belajarulang/models/student_models.dart';
import 'package:belajarulang/thema.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatedData extends StatefulWidget {
  final Student? student;
  const UpdatedData({Key? key, this.student}) : super(key: key);

  @override
  State<UpdatedData> createState() => _UpdatedDataState();
}

class _UpdatedDataState extends State<UpdatedData> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  final judul = TextEditingController();
  final isi = TextEditingController();
  @override
  void dispose() {
    judul.dispose();
    isi.dispose();
    super.dispose();
  }

  @override
  void initState() {
    judul.text = widget.student!.judul.toString();
    isi.text = widget.student!.isi.toString();
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Ubah",
          style: textAppbar,
        ),
        actions: const [],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30),
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 202, 229),
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Colors.black),
              ),
              child: TextFormField(
                maxLines: 2,
                // cursorColor: Colors.pink,
                keyboardAppearance: Brightness.dark,
                restorationId: AutofillHints.addressState,
                // smartQuotesType: SmartQuotesType.enabled,
                // textAlign: TextAlign.center,
                style: textForm,
                controller: judul,
                decoration: InputDecoration(
                  prefixText: 'Judul :  ',
                  // hintText: 'Judul',
                  border: InputBorder.none,
                  // labelText: 'Judul : ',
                  fillColor: Colors.white,
                  labelStyle: textForm,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 30),
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 202, 229),
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Colors.black),
              ),
              child: TextFormField(
                style: textForm,
                maxLines: 2,
                controller: isi,
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  border: InputBorder.none,
                  prefixText: 'Isi :  ',
                  fillColor: Colors.white,
                  labelStyle: textForm,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: (Colors.cyan),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () async {
                  await databaseInstance.updateStudent(widget.student!.id!, {
                    'judul': judul.text,
                    'isi': isi.text,
                    'updatedAt': formattedDate.toString(),
                  });
                  Get.back();
                },
                child: Text(
                  'simpan',
                  style: textAction,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
