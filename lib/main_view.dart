import 'package:flutter/material.dart';
import 'package:flutter_study/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoController;
  int _currentIndex = 0;

  // initial the video is index 0, and it's not initialize yet
  void _playVideo({int index = 0, bool init = false}) {
    // if the index is lowwer of higher than the index, return null
    if (index < 0 || index > videos.length) return;

    // if true, pause the video
    if (!init) {
      _videoController.pause();
    }

    setState(() {
      _currentIndex = index;
    });

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

  String _videoDuration(Duration duration) {
    // padleft means, 첫 인자에 적힌 숫자자리 이전의 공백들을 두번째 인자로 채우겠다는 뜻
    // result: n이 한자리 숫자일때는 0n, 두자리 숫자이면 n.
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    // convert the hours into 2 digit
    final hours = twoDigits(duration.inHours);

    // remain the the minutes into 60 and conver into 2 digits
    final minutes = twoDigits(duration.inMinutes.remainder(60));

    // remain the the seconds into 60 and conver into 2 digits
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    // return value is like 00:00:00
    return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
    // join의 의미는, 각각 element 사이에 arg 값을 넣는다는 의미
  }

  @override
  void initState() {
    super.initState();

    // initialize
    _playVideo(init: true);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
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
            //* show video
            Container(
              color: Colors.deepPurpleAccent,
              height: 300,

              // if the video is initialized
              child: _videoController.value.isInitialized
                  ? Column(
                      children: [
                        //* video
                        SizedBox(
                          height: 200,
                          child: VideoPlayer(_videoController),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // show current position of the video
                            // listen for the current time of the video
                            ValueListenableBuilder(
                              valueListenable: _videoController,
                              builder:
                                  (context, VideoPlayerValue value, child) =>
                                      Text(
                                _videoDuration(_videoController.value.position),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),

                            //* video progress indicator
                            Expanded(
                                child: SizedBox(
                              height: 20,
                              child: VideoProgressIndicator(
                                _videoController,

                                // allow user to tap the indicator to seek the video
                                allowScrubbing: true,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 12),
                              ),
                            )),

                            // listen for the duration of the video
                            ValueListenableBuilder(
                              valueListenable: _videoController,
                              builder:
                                  (context, VideoPlayerValue value, child) =>
                                      Text(
                                _videoDuration(_videoController.value.duration),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),

                        //* play and pause button
                        IconButton(
                            onPressed: () => _videoController.value.isPlaying
                                ? _videoController.pause()
                                : _videoController.play(),
                            icon: Icon(
                              _videoController.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 40,
                              color: Colors.white,
                            ))
                      ],
                    )

                  // if not initialized yet
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
            ),
            //* show video list
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: (BuildContext context, int index) {
                  return MaterialButton(
                    onPressed: () => _playVideo(index: index),
                    child: Padding(
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
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
