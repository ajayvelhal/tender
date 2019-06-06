import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TenderState();
  }
}

class TenderState extends StatelessWidget {
  //final String title;
  //TenderState(this.title);
  int diffdays;
  final color = Color(0xff0b3a66);
  final color1 = Color(0xffCBC6C6);

  Widget dateremain(BuildContext context) {
    if (diffdays == 0) {
      return Text(
        "Today",
        style: TextStyle(color: Colors.green),
      );
    } else if (diffdays < 0) {
      return Text(
        "Missed",
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Text(diffdays.toString()+"  Days Left");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(diffdays);
    // TODO: implement build
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance.document('list/tenderlist').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              //if (!snapshot.hasData) return const Text('Loading...');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                /*case ConnectionState.active:
                  print("BC");*/
                default:
                  debugPrint(snapshot.data['list'].toString());
                  var lst = snapshot.data['list']
                      .where((f) => f['status'] != 'Draft')
                      .toList();
                  /*var date= snapshot.data['enddate'].toString();
                  print(date);*/

                  return ListView.builder(
                      itemCount: lst.length,
                      itemBuilder: (BuildContext context, int index) {
                        var tender = lst[index];
                        var date = tender['enddate'];
                        print(date);
                        DateTime dt = DateTime.parse(date);
                        print(dt);
                        DateTime dn = DateTime.now();
                        print(dn);
                        diffdays = dt.difference(dn).inDays;
                        /*if(diffdays==0){
                          return Text("Today",style: TextStyle(color: Colors.green),);
                        }
                        else if(diffdays<0){
                          return Text("Missed",style: TextStyle(color: Colors.red),);
                        }
                        else{
                          return Text(diffdays.toString());
                        }*/

                        print(diffdays);

                        // var endate=date[index];
                        //debugPrint(endate);
                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 10.0,
                                right: 10.0,
                                bottom: 5.0),
                            child: Container(
                                //height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    //border: Border.all(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 5.0)
                                    ]),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: Text("Project name:"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 5.0),
                                        child: Text(
                                          tender['tendername'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7.0),
                                                      child: Icon(
                                                        Icons.add_alert,
                                                        color:
                                                            Colors.deepOrange,
                                                      )),
                                                  dateremain(context)
                                                ],
                                              ),
                                            )),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 7.0),
                                                        child: Icon(
                                                          IconData(0xe801,
                                                              fontFamily:
                                                                  'Maindart'),
                                                          color:
                                                              Colors.deepOrange,
                                                        )),
                                                    Text(tender['status'])
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      ExpansionTile(
                                          backgroundColor: color,
                                          title: Text(
                                            "more details..",
                                          ),
                                          children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, bottom: 10.0),
                                                child: StreamBuilder<
                                                        DocumentSnapshot>(
                                                    stream: Firestore.instance
                                                        .document(
                                                            'TenderDet/${tender['idno']}')
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {

                                                      switch (snapshot
                                                          .connectionState) {
                                                        case ConnectionState
                                                            .waiting:
                                                          return new Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                          break;
                                                        default:
                                                          var details =
                                                              snapshot.data;
                                                          debugPrint('called ' +
                                                              details.toString()                                                                  .toString());
                                                          return Column(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          7),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                        Icons
                                                                            .date_range,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                5.0,
                                                                            right:
                                                                                3.0),
                                                                        child:
                                                                            Text(
                                                                          'Due Date: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        details[
                                                                            'enddate'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          7.0),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                        IconData(
                                                                            0xf156,
                                                                            fontFamily:
                                                                                'MyFlutterApp'),
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                5.0,
                                                                            right:
                                                                                3.0),
                                                                        child:
                                                                            Text("Emd Cost:"
                                                                          ,
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        details['Emd']['emdamt'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          7.0),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                        IconData(
                                                                            0xe801,
                                                                            fontFamily:
                                                                                'Maindart'),
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                5.0,
                                                                            right:
                                                                                3.0),
                                                                        child:
                                                                            Text(
                                                                          'Project cost: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        details['projcost'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          7.0),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                        Icons
                                                                            .location_on,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                5.0,
                                                                            right:
                                                                                3.0),
                                                                        child:
                                                                            Text(
                                                                          'Location: ',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        details['address']['location'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            7.0),
                                                                    child: Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                            Icons.person_outline,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 5.0, right: 3.0),
                                                                            child:
                                                                                Text(
                                                                              'Authority: ',
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                          Text(details['authority'],
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          )
                                                                        ]))
                                                              ]);
                                                      }
                                                    }))
                                          ])
                                    ])));
                      });
              }
            }));
  }
}
