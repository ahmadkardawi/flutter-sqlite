import 'package:belajarulang/controllers/DataHelper.dart';
import 'package:belajarulang/models/student_models.dart';
import 'package:belajarulang/screens/buatdata.dart';
import 'package:belajarulang/screens/updateddata.dart';
import 'package:belajarulang/thema.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseInstance? databaseInstance;

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  Future _refresh() async {
    setState(() {});
  }

  Future delete(int id) async {
    await databaseInstance!.delete(id);
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(
            'Catatan Pinjaman',
            style: textAppbar,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null
            ? FutureBuilder<List<Student>>(
                future: databaseInstance!.all(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final students = snapshot.data!;
                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        // Build UI for each student
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(
                              student.judul.toString().toUpperCase(),
                              style: textNama,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.isi.toString(),
                                  maxLines: 1, // Batasi jumlah baris menjadi 2
                                  overflow: TextOverflow
                                      .ellipsis, // Tampilkan tanda "..." jika teks lebih panjang
                                  style: textIsi,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  student.cretedAt.toString(),
                                  style: textTgl,
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Get.to(UpdatedData(
                                  student: student,
                                ));
                              },
                              icon: const Icon(
                                Icons.save_as_rounded,
                                color: Colors.cyan,
                              ),
                            ),
                            leading: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade400,
                              ),
                              onPressed: () => delete(student.id!),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text('No data available');
                  }
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: IconButton(
          color: Colors.white,
          onPressed: () {
            Get.to(const BuatData())!.then((value) {
              setState(() {});
            });
          },
          icon: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
    );
  }
}
