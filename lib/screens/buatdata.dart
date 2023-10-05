import 'package:belajarulang/controllers/DataHelper.dart';
import 'package:belajarulang/thema.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuatData extends StatefulWidget {
  const BuatData({Key? key}) : super(key: key);

  @override
  State<BuatData> createState() => _BuatDataState();
}

class _BuatDataState extends State<BuatData> {
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
          "Buat Data",
          style: textAppbar,
        ),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 202, 229),
                borderRadius: BorderRadius.circular(20),
                // border: Border.all(color: Colors.cyan),
              ),
              child: TextFormField(
                // maxLines: 3,
                // cursorColor: Colors.pink,
                keyboardAppearance: Brightness.dark,
                restorationId: AutofillHints.addressState,
                // smartQuotesType: SmartQuotesType.enabled,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white),
                controller: judul,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Judul : ',
                  fillColor: Colors.white,
                  labelStyle: textForm,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 202, 229),
                borderRadius: BorderRadius.circular(20),
                // border: Border.all(color: Colors.cyan),
              ),
              child: TextFormField(
                // maxLines: 5,
                controller: isi,
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  border: InputBorder.none,
                  labelText: 'Isi : ',
                  fillColor: Colors.white,
                  labelStyle: textForm,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: (Colors.cyan),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () async {
                  await databaseInstance.insert({
                    'judul': judul.text,
                    'isi': isi.text,
                    'cretedAt': formattedDate.toString(),
                  });
                  // .then((value) =>
                  //     Get.snackbar('Sukses', 'Berhasil Ditambahkan'))
                  // .catchError((eror) => Get.snackbar('Error', '$eror'));
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
