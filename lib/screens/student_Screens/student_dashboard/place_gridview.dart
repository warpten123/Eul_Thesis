import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:thesis_eul/models/sdg.dart';
import 'package:thesis_eul/screens/student_Screens/student_dashboard/place_Item.dart';

class PlaceGridView extends StatelessWidget {
  final sdgList = SDG.generateList();

  PlaceGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          itemCount: sdgList.length,
          crossAxisCount: 4,
          itemBuilder: ((context, index) => PlaceItem(sdgList[index])),
          staggeredTileBuilder: (_) => const StaggeredTile.fit(2)),
    );
  }
}
