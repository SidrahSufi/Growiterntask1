import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_app/Controllers/player_controller.dart';
import 'package:get/get.dart';
import 'package:music_app/home.dart';
import 'package:on_audio_query/on_audio_query.dart';



class player extends StatelessWidget {
  final List <SongModel> data;
  const player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: Colors.deepPurple,
       appBar: AppBar(
         backgroundColor: Colors.deepPurple,
       ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.music_note,
                    size: 100,
                    color: Colors.deepPurple,
                  ),
                )
            ),
            SizedBox(height: 5,),
            Expanded(

                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    )
                  ),
                  child:
                  Obx(
                        ()=>Column(
                      children: [
                        Text(
                            data[controller.playIndex.value].displayNameWOExt,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                          ),
                        ),
                        SizedBox(height: 2,),
                        Text(
                          "${data[controller.playIndex.value].artist}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 30,),

                        Obx(()
                          => Row(
                            children: [
                              Text(
                               controller.position.value,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                              Expanded(
                                  child: Slider(
                                    thumbColor: Colors.deepPurple ,
                                    inactiveColor: Colors.black,
                                    activeColor: Colors.deepPurple,
                                    min: const Duration(seconds: 0).inSeconds.toDouble(),
                                    max: controller.max.value,
                                    value: controller.value.value,
                                    onChanged: (newValue){
                                      controller.changeDurationToSeconds(newValue.toInt());
                                      newValue= newValue;
                                    },
                                  )
                              ),
                              Text(
                                  controller.duration.value,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                           IconButton(
                              onPressed: () {
                                int prevIndex = controller.playIndex.value - 1;
                                if (prevIndex < 0) {
                                  prevIndex = data.length - 1;
                                }
                                controller.playSong(data[prevIndex].uri, prevIndex);
                              },
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                size: 48,
                              ),
                            ),
                            Obx(
                              () => IconButton(
                                onPressed: (){
                                if(controller.isPlaying.value)
                                  {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  }
                                else{
                                  controller.audioPlayer.play();
                                  controller.isPlaying(true);
                                }
                                },
                                  icon: controller.isPlaying.value
                                 ? const Icon(Icons.pause,
                                      size: 64)
                                      :  const Icon(Icons.play_arrow_rounded,
                                  size: 64),

                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                int nextIndex = controller.playIndex.value + 1;
                                if (nextIndex >= data.length) {
                                  nextIndex = 0;
                                }
                                controller.playSong(data[nextIndex].uri, nextIndex);
                              },
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                size: 48,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

            )
          ],
        ),
        
        
      ),


    );
  }
}
