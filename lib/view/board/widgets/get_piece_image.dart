import 'package:chess_league/core/const_data/app_images.dart';
import 'package:chess_league/model/chess_piece.dart';

String getImageForPiece(PieceType type, bool isWhite) {
  // Replace with your actual image paths for different pieces
  switch (type) {
    case PieceType.queen:
      return isWhite ? AppImages.whiteQueen : AppImages.blackQueen;
    case PieceType.rook:
      return isWhite ? AppImages.whiteRook : AppImages.blackRook;
    case PieceType.bishop:
      return isWhite ? AppImages.whiteBishop : AppImages.blackBishop;
    case PieceType.knight:
      return isWhite ? AppImages.whiteKnight : AppImages.blackKnight;
    default:
      return ''; // Default fallback image
  }
}
