// ignore_for_file: prefer_const_constructors
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mymusic/Nextsinglepage.dart';
import 'package:mymusic/model/modepage.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Datum _datum = Datum();
  List? storelist = [];
  Future dataFetch() async {
    String mylink = "https://ayat-app.com/api/v2/mp3";
    var httpresponse = await http.get(Uri.parse(mylink));
    print(httpresponse.body);
    if (httpresponse.statusCode == 200) {
      var mydata = jsonDecode(httpresponse.body);
      for (var i in mydata['data']) {
        _datum = Datum.fromJson(i);
        setState(() {
          storelist?.add(_datum);
        });
      }
    }
  }

  // :NetworkImage("https://images.unsplash.com/photo-1520496938502-73e942d08cc3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")
  List<String> mylist = [
    "https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand3.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav"
        "https://ayat-app.com/public/uploads/all/Xtdm4MdXtJVf5feL7rS5yquq18mnpceOEMPpJvGb.mp3"
  ];
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration();
  Duration postion = Duration();
  String url =
      "https://ayat-app.com/public/uploads/all/Xtdm4MdXtJVf5feL7rS5yquq18mnpceOEMPpJvGb.mp3";

  @override
  void initState() {
    dataFetch();
    // TODO: implement initState
    super.initState();
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        postion = event;
      });
    });
    audioPlayer.setSourceUrl(url);

    this.audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String baseUrl = "https://ayat-app.com/public";
    double value = 0;
    int indexOfSong = 0;
    bool isPlaying = false;
    bool isclick = false;
    var height = MediaQuery.of(context).size.height;
    var weight = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {}, child: Icon(Icons.arrow_back_ios_new)),
        ),
        backgroundColor: Color(0xfffDCEDC8),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Music Player",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Container(
                    height: height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1524567248408-cbfd37e65e2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                            fit: BoxFit.cover))),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: height * 0.2,
                  width: weight * 0.82,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green.shade200,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${postion.inMinutes}:${postion.inSeconds % 60}",
                            style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),
                          ),
                          Container(
                            width: weight*.5,
                            child: Slider(
                              min: 0,
                              max: duration.inSeconds.toDouble(),
                              value: postion.inSeconds.toDouble(),
                              onChanged: (value) {
                                final position =
                                    Duration(seconds: value.toInt());
                                audioPlayer.seek(position);
                                audioPlayer.resume();
                              },
                              activeColor: Colors.white,
                            ),
                          ),
                          Text(
                            "${duration.inHours==0?"":""}${duration.inHours==0?"":"${duration.inHours}:"}${duration.inMinutes%60}:${duration.inSeconds % 60}",
                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: weight * 0.15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.teal),
                                    child: Center(
                                        child: IconButton(
                                            onPressed: () {
                                              print(
                                                  "Data for photo--------${storelist![0].coverArt}");
                                            },
                                            icon: Icon(
                                              Icons.arrow_back,
                                              size: 20,
                                              color: Colors.black,
                                            )))),
                                Container(
                                    width: weight * 0.15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isPlaying == true
                                            ? Colors.red
                                            : Colors.green),
                                    child: Center(
                                        //Resume button
                                        child: IconButton(
                                            onPressed: () async {
                                              audioPlayer.resume();
                                            },
                                            icon: const Icon(
                                              Icons.play_arrow,
                                              size: 20,
                                              color: Colors.black,
                                            )))),
                                Container(
                                    width: weight * 0.15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.indigo.shade300),
                                    child: Center(
                                        //pluse button
                                        child: IconButton(
                                      onPressed: () {
                                        audioPlayer.pause();
                                      },
                                      icon: Icon(
                                        Icons.pause,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ))),
                                Container(
                                    width: weight * 0.15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                    child: Center(

                                        //stop button
                                        child: IconButton(
                                            onPressed: () async {
                                              await audioPlayer.stop();
                                              
                                             
                                              setState(() {
                                                isclick = !isclick;
                                              });
                                               postion=Duration(seconds: 0);
                                              print("Isclick ${isclick}");
                                              fctn("Song Stop!!!");
                                            },
                                            icon: Icon(
                                              Icons.stop,
                                              size: 20,
                                              color: isclick == false
                                                  ? Colors.black
                                                  : Colors.red,
                                            )))),
                                Container(
                                    width: weight * 0.15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.teal),
                                    child: Center(
                                        child: IconButton(
                                            onPressed: () {
                                              print(
                                                  "data ofr index----${storelist![0].name}");
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward,
                                              size: 20,
                                              color: Colors.black,
                                            ))))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * .28,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: storelist!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              audioPlayer.onPositionChanged.listen((position) {
                                setState(() {
                                  value = position.inSeconds.toDouble();
                                });
                              });
                              duration = (await audioPlayer.getDuration())!;
                              // setState(() async {
                              //   _duration = (await audioPlayer.getDuration())!;
                              // });
                              if (isPlaying == false) {
                                await audioPlayer.play(UrlSource(
                                    "${baseUrl}/${storelist![index].file}"));
                                isPlaying = true;
                                print(
                                    "Song link from isplaying true::: ${baseUrl}/${storelist![index].file}");
                              } else if (isPlaying == true) {
                                audioPlayer.stop();

                                await audioPlayer.play(UrlSource(
                                    "${baseUrl}/${storelist![index].file}"));
                                print(
                                    "Song link from isplaying false::: ${baseUrl}/${storelist![index].file}");
                                isPlaying = true;
                              }
                              setState(() {});
                              print('song index value:${index}');
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext) => Nextsinglepage(
                              //             index,
                              //             storelist![index].id,
                              //             storelist![index].name,
                              //             storelist![index].file,
                              //             storelist![index].coverArt)));
                            },
                            child: Container(
                              height: height * .4,
                              width: weight * .27,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: storelist![index].id % 2 == 0
                                          ? NetworkImage(
                                              'https://images.unsplash.com/photo-1618099378810-1fd4c13961d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80')
                                          : NetworkImage(
                                              "https://images.unsplash.com/photo-1520496938502-73e942d08cc3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                                      fit: BoxFit.cover)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${storelist![index].name}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       vertical: 8.0),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(12),
                                  //       color: Colors.blue,
                                  //     ),
                                  //     child: TextButton(
                                  //         onPressed: () {},
                                  //         // ignore: prefer_const_constructors
                                  //         child: Text(
                                  //           "Click",
                                  //           // ignore: prefer_const_constructors
                                  //           style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             color: Colors.white,
                                  //           ),
                                  //         )),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  fctn(String title1,){

  return  Fluttertoast.showToast(
        msg: "${title1}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );}
}