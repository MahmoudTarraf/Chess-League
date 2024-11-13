import 'package:chess_league/model/chess_piece.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/widgets/get_piece_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PromotionDialog {
  static Future<void> showPromotionDialog(ChessPiece piece, int row, int col,
      int originalRow, int originalCol) async {
    PieceType? selectedPieceType = await Get.defaultDialog<PieceType>(
      title: "Promote Pawn",
      content: GetBuilder<BoardController>(
        builder: (controller) => Column(
          children: [
            buildPromotionOption(PieceType.queen, piece, row, col, originalRow,
                originalCol, controller),
            buildPromotionOption(PieceType.rook, piece, row, col, originalRow,
                originalCol, controller),
            buildPromotionOption(PieceType.bishop, piece, row, col, originalRow,
                originalCol, controller),
            buildPromotionOption(PieceType.knight, piece, row, col, originalRow,
                originalCol, controller),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    if (selectedPieceType != null) {
      final controller = Get.find<BoardController>();
      controller.promotePawn(
          piece, selectedPieceType, row, col, originalRow, originalCol);
    }
  }

  static Widget buildPromotionOption(PieceType type, ChessPiece pawn, int row,
      int col, int originalRow, int originalCol, BoardController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Get.back(); // Close the dialog after selecting
          controller.promotePawn(
              pawn, type, row, col, originalRow, originalCol);
        },
        child: SizedBox(
          height: 7.h,
          width: 15.w,
          child: Image.asset(
            getImageForPiece(
              type,
              controller.selectedPieceColor(pawn),
            ),
          ),
        ),
      ),
    );
  }
}
