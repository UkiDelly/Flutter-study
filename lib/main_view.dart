import 'package:flutter/material.dart';
import 'package:flutter_study/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _videoController;
  final int _currentIndex = 0;

  // initial the video is index 0, and it's not initialize yet
  void _playVideo({int index = 0, bool init = false}) {
    // if the index is lowwer of higher than the index, return null
    if (index < 0 || index > videos.length) return;

    // load the video from the network to the controller
    _videoController = VideoPlayerController.network(videos[_currentIndex].url)
      // add a listener
      ..addListener(() {
        // update the widget whenever the function called
        setState(() {});
      })
      // make the video loop
      ..setLooping(true)
      // play the video after initialize
      ..initialize().then((value) => _videoController.play());
  }

  @override
  void initState() {
    super.initState();

    // initialize
    _playVideo(init: true);
  }

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
