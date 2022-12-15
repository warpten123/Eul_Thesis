import 'package:flutter/material.dart';
import 'package:thesis_eul/models/sdg.dart';

class SDGHeader extends StatelessWidget {
  final SDG sdg;
  const SDGHeader(this.sdg);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amberAccent,
      child: Container(
        height: 350,
        width: double.infinity,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
            // ignore: prefer_const_constructors
            image: DecorationImage(
          // ignore: prefer_const_constructors
          image: sdg.header.toString == null
              ? NetworkImage(sdg.header)
              : NetworkImage(sdg.header),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: [
            Positioned(
                left: 10,
                top: MediaQuery.of(context).padding.top,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    // ignore: prefer_const_constructors
                    child: Icon(Icons.arrow_back),
                  ),
                )),
            Positioned(
              right: 5,
              bottom: 5,
              child: Container(
                height: 100,
                // padding: EdgeInsets.all(8),
                // decoration: BoxDecoration(
                //     color: Colors.white, borderRadius: BorderRadius.circular(36)),
                child: Image(
                  image: AssetImage(sdg.image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
