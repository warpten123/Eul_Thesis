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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.image.isEmpty
                  ? const Text('No Data')
                  : const Text(
                      'Research SDG Classified!',
                      style: TextStyle(
                          fontFamily: 'Georgia',
                          height: 1.3,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
              const SizedBox(
                height: 50,
              ),
              widget.goals.length == 0
                  ? const Text('No Data')
                  : CircularPercentIndicator(
                      animation: true,
                      animationDuration: 2000,
                      radius: 180,
                      lineWidth: 20,
                      percent: widget.goals[0].value,
                      progressColor: widget.color[0],
                      backgroundColor: Colors.deepPurple.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            child: Image.asset(widget.image[0]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${(widget.goals[0].value * 100).toStringAsFixed(2)}%',
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: widget.color[0]),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 50,
              ),
              widget.image.isEmpty
                  ? const Text('No Data')
                  : const Text(
                      'Other Goals',
                      style: TextStyle(
                          fontFamily: 'Georgia',
                          height: 1.3,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
              const SizedBox(
                height: 20,
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         widget.goals.length == 0
              //             ? Text('No Data')
              //             : CircularPercentIndicator(
              //                 animation: true,
              //                 animationDuration: 2000,
              //                 radius: 50,
              //                 lineWidth: 10,
              //                 percent: widget.goals[1].value,
              //                 progressColor: widget.color[1],
              //                 backgroundColor: Colors.deepPurple.shade100,
              //                 circularStrokeCap: CircularStrokeCap.round,
              //                 center: Container(
              //                   height: 50,
              //                   width: 50,
              //                   child: Image.asset(widget.image[1]),
              //                 ),
              //               ),
              //         widget.image.isEmpty
              //             ? Text('No Data')
              //             : Container(
              //                 height: 100,
              //                 width: 100,
              //                 child: Image.asset(widget.image[1]),
              //               ),
              //         SizedBox(
              //           width: 60,
              //         ),
              //         widget.goals.length == 0
              //             ? Text('No Data')
              //             : CircularPercentIndicator(
              //                 animation: true,
              //                 animationDuration: 2000,
              //                 radius: 50,
              //                 lineWidth: 10,
              //                 percent: widget.goals[2].value,
              //                 progressColor: widget.color[2],
              //                 backgroundColor: Colors.deepPurple.shade100,
              //                 circularStrokeCap: CircularStrokeCap.round,
              //                 center: Text(
              //                   '${(widget.goals[2].value * 100).toStringAsFixed(2)}%',
              //                   style: const TextStyle(fontSize: 20),
              //                 ),
              //               ),
              //         widget.image.isEmpty
              //             ? const Text("No Data")
              //             : Container(
              //                 height: 100,
              //                 width: 100,
              //                 child: Image.asset(widget.image[2]),
              //               ),
              //       ],
              //     ),
              //   ),
              // ),
              widget.goals.length == 0
                  ? const Text("No Data")
                  : Stack(
                      children: [
                        // Container(
                        //   // ignore: prefer_const_constructors
                        //   decoration: BoxDecoration(
                        //       image: const DecorationImage(
                        //           image: AssetImage('assets/newback.jpg'),
                        //           fit: BoxFit.cover)),
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //         colors: [
                        //           Colors.transparent,
                        //           Colors.transparent,
                        //           const Color(0xff161d27).withOpacity(0.9),
                        //           const Color(0xff161d27),
                        //         ],
                        //         begin: Alignment.topCenter,
                        //         end: Alignment.bottomCenter),
                        //   ),
                        // ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          // width: MediaQuery.of(context).size.width * 0.82,
                          // height: MediaQuery.of(context).size.height * 0.28,

                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.goals.length - 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Center(
                                    child: LinearPercentIndicator(
                                      linearStrokeCap: LinearStrokeCap.round,
                                      animation: true,
                                      animationDuration: 1000,
                                      leading: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        height: 70,
                                        width: 70,
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 4,
                                                offset: Offset(
                                                    4, 8), // Shadow position
                                              ),
                                            ],
                                          ),
                                          child: Image.asset(
                                              widget.image[index + 1]),
                                        ),
                                      ),
                                      trailing: Text(
                                        '${(widget.goals[index + 1].value * 100).toStringAsFixed(2)}%',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: widget.color[index + 1]),
                                      ),
                                      lineHeight: 10,
                                      percent: widget.goals[index + 1].value,
                                      progressColor: widget.color[index + 1],
                                      backgroundColor:
                                          Colors.deepPurple.shade200,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
              // widget.goals.length == 0 ?
              // Text("No Data") :
              // LinearPercentIndicator(
              //   linearStrokeCap: LinearStrokeCap.round,
              //   animation: true,
              //   animationDuration: 1000,
              //   leading: Container(
              //     height: 70,
              //     width: 70,
              //     child: Image.asset(widget.image[1]),
              //   ),
              //   trailing: Text(
              //     '${(widget.goals[1].value * 100).toStringAsFixed(2)}%',
              //     style: const TextStyle(
              //         fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   lineHeight: 10,
              //   percent: widget.goals[1].value,
              //   progressColor: widget.color[1],
              //   backgroundColor: Colors.deepPurple.shade200,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // LinearPercentIndicator(
              //   animation: true,
              //   trailing: Text(
              //     '${(widget.goals[2].value * 100).toStringAsFixed(2)}%',
              //     style: const TextStyle(
              //         fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   leading: Container(
              //     height: 70,
              //     width: 70,
              //     child: Image.asset(widget.image[2]),
              //   ),
              //   animationDuration: 1000,
              //   lineHeight: 10,
              //   percent: widget.goals[2].value,
              //   progressColor: widget.color[2],
              //   backgroundColor: Colors.deepPurple.shade200,
              // ),
              // LinearPercentIndicator(
              //   animation: true,
              //   trailing: Text(
              //     '${(widget.goals[3].value * 100).toStringAsFixed(2)}%',
              //     style: const TextStyle(
              //         fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   leading: Container(
              //     height: 70,
              //     width: 70,
              //     child: Image.asset(widget.image[3]),
              //   ),
              //   animationDuration: 1000,
              //   lineHeight: 10,
              //   percent: widget.goals[2].value,
              //   progressColor: widget.color[3],
              //   backgroundColor: Colors.deepPurple.shade200,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
