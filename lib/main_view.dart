import 'package:flutter/material.dart';
import 'package:flutter_study/model/video_model.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Video Player"),
        ),

        //
        body: Column(
          children: [
            // show video list
            ListView.builder(
              shrinkWrap: true,
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      //* show thumbnail, but thumbnail is not avail
                      const SizedBox(
                        width: 100,
                        height: 100,
                      ),

                      //
                      const SizedBox(
                        width: 20,
                      ),

                      //* video name
                      Text(
                        videos[index].name,
                        style: const TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}
