import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../widgets/card_custom.dart';
import '../../../widgets/tile_card_custom.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: 32,
      ),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(2, 4),
          // const QuiltedGridTile(2, 4),
          // const QuiltedGridTile(2, 4),
        ],
      ),
      childrenDelegate: SliverChildListDelegate(
        [
          const CardCustom(
            icon: Icon(
              Icons.people,
              color: Colors.white,
              size: 50,
            ),
            name: 'Jumlah Siswa',
            value: '10',
            color: Colors.blue,
          ),
          const CardCustom(
            icon: Icon(
              Icons.list_alt_rounded,
              color: Colors.white,
              size: 50,
            ),
            name: 'Jumlah Kelas',
            value: '10',
            color: Colors.green,
          ),
          const CardCustom(
            icon: Icon(
              Icons.people_outline_rounded,
              color: Colors.white,
              size: 50,
            ),
            name: 'Jumlah User',
            value: '10',
            color: Colors.orange,
          ),
          TileCardCustom(),
        ],
      ),
    );
  }
}
