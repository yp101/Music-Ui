import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_ui/neu_box.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
  double curr_playback = 1.0;
  @override
  void initState() {
    super.initState();

    audioPlayer.setUrl(url);

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => _duration = d);
    });

    audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration _duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return [
      if (_duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: NeuBox(child: Icon(Icons.arrow_back)),
                  ),
                  Text("P L A Y L I S T"),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: NeuBox(child: Icon(Icons.menu)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              //cover art
              NeuBox(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('lib/images/cover.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Honey singh",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                "Dope Shope",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.purple[800],
                            size: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(formatTime(_position)),
                  const Icon(Icons.shuffle),
                  const Icon(Icons.repeat),
                  Text(formatTime(_duration)),
                ],
              ),

              const SizedBox(height: 25),

              NeuBox(
                // child: LinearPercentIndicator(
                //   lineHeight: 10,
                //   percent: 0.5,
                //   progressColor: Colors.green,
                //   backgroundColor: Colors.transparent,
                // ),
                child: Slider(
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final _position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(_position);
                  },
                ),
              ),

              const SizedBox(height: 45),

              SizedBox(
                height: 55,
                child: Row(
                  children: [
                    Expanded(
                      child: NeuBox(
                        child: IconButton(
                          icon: const Icon(Icons.fast_rewind),
                          onPressed: () async {
                            audioPlayer.setPlaybackRate(curr_playback -= 0.5);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: NeuBox(
                          child: IconButton(
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: () async {
                              if (isPlaying) {
                                await audioPlayer.pause();
                              } else {
                                await audioPlayer.play(url);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: NeuBox(
                        child: IconButton(
                          icon: const Icon(Icons.fast_forward),
                          onPressed: () async {
                            audioPlayer.setPlaybackRate(curr_playback += 0.5);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
