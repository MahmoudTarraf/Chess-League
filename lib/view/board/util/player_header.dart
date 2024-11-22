import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/widgets/dead_piece.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({
    super.key,
    required this.takenpieces,
    required this.playerName,
    required this.playerRating,
  });
  final List<ChessPiece> takenpieces;
  final String playerName;
  final String playerRating;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 24,
                  ),
                  Text(
                    playerName,
                    style: TextStyle(
                      color: ColorsManager.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  playerRating,
                  style: TextStyle(
                    color: ColorsManager.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 2.w,
              ),
              const Icon(
                Icons.signal_wifi_4_bar,
                color: Colors.green,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                'Connected',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: DeadPiece(
                    imagePath: takenpieces[index].image,
                  ),
                );
              },
              itemCount: takenpieces.length,
            ),
          ),
        ],
      ),
    );
  }
}
