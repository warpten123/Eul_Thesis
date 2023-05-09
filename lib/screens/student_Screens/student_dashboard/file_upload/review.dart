import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Upload_Review extends StatefulWidget {
  Upload_Review(this.goals, this.image, this.color, {super.key});
  final goals;
  final List<String> image;
  final List<Color> color;

  @override
  State<Upload_Review> createState() => _Upload_ReviewState();
}

class _Upload_ReviewState extends State<Upload_Review> {
  @override
  void initState() {
    setState(() {
      if (widget.goals.length != 0) {
        widget.goals[0].value * 100;
        widget.goals[1].value * 100;
        widget.goals[2].value * 100;
      }
    });
    super.initState();
    // Perform initialization here
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget.goals.length == 0
                  ? CircularPercentIndicator(
                      animation: true,
                      animationDuration: 2000,
                      radius: 150,
                      lineWidth: 20,
                      percent: 0,
                      progressColor: Colors.green,
                      backgroundColor: Colors.deepPurple.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: const Text(
                        "40%",
                        style: TextStyle(fontSize: 50),
                      ),
                    )
                  : CircularPercentIndicator(
                      animation: true,
                      animationDuration: 2000,
                      radius: 150,
                      lineWidth: 20,
                      percent: widget.goals[0].value,
                      progressColor: widget.color[0],
                      backgroundColor: Colors.deepPurple.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        '${widget.goals[0].value * 100}%',
                        style: const TextStyle(fontSize: 50),
                      ),
                    ),
              widget.image.isEmpty
                  ? Container(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/ai.png"),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(widget.image[0]),
                    ),
              SizedBox(
                height: 100,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      widget.goals.length == 0
                          ? CircularPercentIndicator(
                              animation: true,
                              animationDuration: 2000,
                              radius: 50,
                              lineWidth: 10,
                              percent: 0,
                              progressColor: Colors.red,
                              backgroundColor: Colors.deepPurple.shade100,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: const Text(
                                "30.2%",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : CircularPercentIndicator(
                              animation: true,
                              animationDuration: 2000,
                              radius: 50,
                              lineWidth: 10,
                              percent: widget.goals[1].value,
                              progressColor: widget.color[1],
                              backgroundColor: Colors.deepPurple.shade100,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                '${widget.goals[1].value * 100}%',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                      widget.image.isEmpty
                          ? Container(
                              height: 150,
                              width: 150,
                              child: Image.asset("assets/ai.png"),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(widget.image[1]),
                            ),
                      SizedBox(
                        width: 60,
                      ),
                      widget.goals.length == 0
                          ? CircularPercentIndicator(
                              animation: true,
                              animationDuration: 2000,
                              radius: 50,
                              lineWidth: 10,
                              percent: 0,
                              progressColor: Colors.blue,
                              backgroundColor: Colors.deepPurple.shade100,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: const Text(
                                "10.2%",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : CircularPercentIndicator(
                              animation: true,
                              animationDuration: 2000,
                              radius: 50,
                              lineWidth: 10,
                              percent: widget.goals[2].value,
                              progressColor: widget.color[2],
                              backgroundColor: Colors.deepPurple.shade100,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                '${widget.goals[2].value * 100}%',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                      widget.image.isEmpty
                          ? Container(
                              height: 150,
                              width: 150,
                              child: Image.asset("assets/ai.png"),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(widget.image[2]),
                            ),
                    ],
                  ),
                ),
              ),
              // LinearPercentIndicator(
              //   linearStrokeCap: LinearStrokeCap.round,
              //   animation: true,
              //   animationDuration: 1000,
              //   lineHeight: 10,
              //   percent: 0.5,
              //   progressColor: Colors.red,
              //   backgroundColor: Colors.deepPurple.shade200,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // LinearPercentIndicator(
              //   animation: true,
              //   animationDuration: 1000,
              //   lineHeight: 10,
              //   percent: 0.5,
              //   progressColor: Colors.blue,
              //   backgroundColor: Colors.deepPurple.shade200,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
