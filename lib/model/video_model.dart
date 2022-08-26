class Video {
  final String name, url;

  const Video({required this.name, required this.url});
}

const videos = [
  Video(
    name: "BigBuckBunny",
    url:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  ),
  Video(
      name: "ElephantsDream",
      url:
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
  Video(
      name: "ForBiggerBlazes",
      url:
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
];
