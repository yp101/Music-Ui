import 'package:flutter/material.dart';
import 'package:music_ui/neu_box.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
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
                children: const [
                  Text('0.00'),
                  Icon(Icons.shuffle),
                  Icon(Icons.repeat),
                  Text('4.27'),
                ],
              ),

              const SizedBox(height: 25),

              NeuBox(
                child: LinearPercentIndicator(
                  lineHeight: 10,
                  percent: 0.5,
                  progressColor: Colors.green,
                  backgroundColor: Colors.transparent,
                ),
              ),

              const SizedBox(height: 45),

              SizedBox(
                height: 55,
                child: Row(
                  children: const [
                    Expanded(
                      child: NeuBox(
                        child: Icon(Icons.skip_previous),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: NeuBox(
                          child: Icon(Icons.pause),
                        ),
                      ),
                    ),
                    Expanded(
                      child: NeuBox(
                        child: Icon(
                          Icons.skip_next,
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
