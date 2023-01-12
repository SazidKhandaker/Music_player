
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Nextsinglepage extends StatefulWidget {
  Nextsinglepage(this.index,this.id,this.name,this.file,this.photo);
  int index;
  int id;
  String name;
 
  String file;
  String ?photo;
  @override
  State<Nextsinglepage> createState() => _NextsinglepageState();
}

class _NextsinglepageState extends State<Nextsinglepage> {
  GlobalKey <ScaffoldState> _globalKey =GlobalKey();
  @override
        AudioPlayer audioPlayer = AudioPlayer();
        AudioCache _audioCache =AudioCache();
  Duration _duration = Duration();
  Duration _postion = Duration();

      @override
  void initState() {
 
    // TODO: implement initState
    super.initState();
    
  }
    
  Widget build(BuildContext context) {

    String baseurl="https://ayat-app.com/public";
String mp3="${widget.file}";
    String url =
      "${baseurl}/$mp3";

      String photourl="${baseurl}/${widget.photo}";
    bool isflase=false;
    bool isclick=false;
          var height=MediaQuery.of(context).size.height;
 var weight =MediaQuery.of(context).size.width;
    return SafeArea(
      child:  Scaffold(   
        key: _globalKey,
            appBar: AppBar(elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new)),
        ),
        backgroundColor: Color(0xfffDCEDC8),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("${widget.name}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:25.0),
                child: Container(
                  height: height*0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("${photourl}"),fit: BoxFit.cover)
                  )
                ),
              ),
              Center(
                child: Container(height:height*0.2 ,
               
                width: weight*0.82,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                
                 color: Colors.green.shade200,
                ),
                child: Column(
                  
                  children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 10),
                                        overlayShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 10,
                                        ),
                                        thumbColor: Colors.green,
                                        activeTrackColor: Colors.green),
                                    child: Slider(
                                     value: 0,
                      
                                      onChanged: (value) {
                                        setState(() {
                                         
                                        });
                                      },
                                    )),
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
                                width: weight*0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal
                              ),
                           child: Center(    child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,size: 20,color: Colors.black,)))),
                           Container(
                                width:weight*0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:isflase==true? Colors.red :Colors.green
                              ),
                           child: Center(    child: IconButton(onPressed: ()async{
                            setState(() {
                              isflase=!isflase;
                            });

                            // if(widget.index==0){
                            //       await audioPlayer.play(UrlSource(url));
                            // }
                            await audioPlayer.play(UrlSource(url));
                            // else if(widget.index>0){
                            //   audioPlayer.stop();
                            //   audioPlayer.dispose();
                            
                            
                            //   Future.delayed(Duration(seconds: 3));
                            //   await audioPlayer.play(UrlSource(url));
                            // };

                                print("Index---${widget.index}");
                                    
               
                           }, icon: Icon(Icons.play_arrow,size: 20,color: Colors.black,)))),

                              Container(
                                width: weight*0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.indigo.shade300
                              ),
                           child: Center(    child: IconButton(onPressed: (){
                                audioPlayer.pause();
                            
                           },icon: Icon(Icons.pause,color: Colors.black,size: 20,),))),
                           Container(
                                width: weight*0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red
                              ),
                           child: Center(    child: IconButton(onPressed: ()async{

                         await audioPlayer.stop();
                         setState(() {
                           
                         });
                           print("Stop-----");
                       
                      
                           }, icon: Icon(Icons.stop,size: 20,color: isclick==false? Colors.black:Colors.red,)))),
                             Container(
                                width: weight*0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal
                              ),
                           child: Center(    child: IconButton(onPressed: (){
                       //  print("data ofr index----${storelist![0].name}");
                           setState(() {
                            //  widget.index++;

                            //  audioPlayer.stop();
                            //  Future.delayed(Duration(seconds: 3));
                            //    audioPlayer.play(UrlSource(url));
                             
                           });
                           print("Index${widget.index}");
                           }, icon: Icon(Icons.arrow_forward,size: 20,color: Colors.black,))))
                            ],
                           ),
                         ),
                       ),
                     ),
        
                   
                  ],
                ),
                ),
              ),
              //  Padding(
              //    padding: const EdgeInsets.all(8.0),
              //    child: Container(height: height*.28,
                     
              //         child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: 5,
              //           shrinkWrap: true,
              //           itemBuilder: (context,index){
        
              //             return Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Container(
              //                 height: height*.4,
              //                 width: weight*.27,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(12),
              //                  // image: DecorationImage(image:storelist![index].id%2==0? NetworkImage('https://images.unsplash.com/photo-1618099378810-1fd4c13961d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80'):NetworkImage("https://images.unsplash.com/photo-1520496938502-73e942d08cc3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),fit: BoxFit.cover)
              //                 ),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   mainAxisSize: MainAxisSize.min,
              //                   children: [
              //                    // Text("Song name${storelist![index].id}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
              //                     Padding(
              //                       padding: const EdgeInsets.symmetric(vertical:8.0),
              //                       child: Container(
                                      
              //                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
              //                         color: Colors.blue,
              //                         ),
              //                         child: TextButton(
                                      
              //                           onPressed: (){}, child: Text("Click",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),)),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             );
              //           }),
              //         ),
              //  )
            ],
          ),
        ),
      ));
  }
}