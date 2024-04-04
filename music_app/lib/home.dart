import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Controllers/player_controller.dart';
import 'package:music_app/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    var controller= Get.put(PlayerController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search),
          color: Colors.white,)
        ],
        // leading: Icon(Icons.sort_rounded),
        title: Text(
          'Just Play!!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              )
        ),
      ),

      body:FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (BuildContext context, snapshot){
          if(snapshot.data==null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.data!.isEmpty){
            return Center(
              child: Text(
                "no audio found"
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(18),
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    child:
                     Obx( () => ListTile(
                        title:
                        controller.playIndex.value==index && controller.isPlaying.value?
                        Text(
                          snapshot.data![index].displayNameWOExt,
                          style: TextStyle(fontSize: 15,color:Colors.deepPurple),
                        )
                        :    Text(
                          snapshot.data![index].displayNameWOExt,
                          style: TextStyle(fontSize: 15),
                        ),
                      
                        subtitle:
                        Text(
                           "${snapshot.data![index].artist}",
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Icon(
                          Icons.music_note,
                          size: 32,
                          color: Colors.deepPurple,
                        ),
                      
                        trailing:controller.playIndex.value==index && controller.isPlaying.value
                       ? const Icon(Icons.play_arrow, size: 26,)
                        :null,
                        onTap: (){
                          Get.to(
                              () => player(
                                data:snapshot.data!

                              ),
                            transition: Transition.downToUp,
                          );

                          controller.playSong(snapshot.data![index].uri,index);
                        },
                      
                      
                      
                      ),
                    ),




                  );


                }


            ),
          );

        },

      )
    );
  }
}
