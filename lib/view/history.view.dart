import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:fitopatologia_app/view/components/historyItem.dart';
import 'package:fitopatologia_app/view/previewPageNetwork.view.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'components/alertDialog.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool uploading = false;
  double total = 0;
  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Background(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore
                  .collection('diagnosticos')
                  .where('uid', isEqualTo: auth.currentUser!.uid)
                  //.orderBy('dataUltimaMensagem', descending: true)
                  .snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Erro");
                }

                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      if (snapshot.data!.docs[index].data()['id'] ==
                          auth.currentUser!.uid) {
                        return Text("");
                      } else {
                        var date = DateFormat("dd/MM/yyyy").format(
                            snapshot.data!.docs[index].data()['data'].toDate());
                        return  HistoryItem(
                              data: date,
                              diag: snapshot.data!.docs[index]
                                  .data()['diagnostico'],
                              photoLink:
                                  snapshot.data!.docs[index].data()['link'],
                            );
                      }
                    });
              },
            ),
          ),
        ));
  }
}
