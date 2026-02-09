import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class WordGrid extends StatefulWidget {
  final List<List<String>> grid;
  final int gridSize;
  final Set<String> foundPositions;
  final List<Color> foundColors;
  final Map<String, Color> positionColorMap;
  final Function(List<List<int>>) onSelectionComplete;

  const WordGrid({
    super.key,
    required this.grid,
    required this.gridSize,
    required this.foundPositions,
    required this.foundColors,
    required this.positionColorMap,
    required this.onSelectionComplete,
  });

  @override
  State<WordGrid> createState() => _WordGridState();
}

class _WordGridState extends State<WordGrid> {
  List<List<int>> _selectedPositions = [];
  int? _startRow;
  int? _startCol;
  bool _isDragging = false;
  final GlobalKey _gridKey = GlobalKey();
  double _cellSize = 0;

  List<int>? _pointerToCell(Offset globalPosition) {
    final box = _gridKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return null;

    final local = box.globalToLocal(globalPosition);
    if (_cellSize <= 0) return null;

    final col = (local.dx / _cellSize).floor();
    final row = (local.dy / _cellSize).floor();

    if (row < 0 || row >= widget.gridSize || col < 0 || col >= widget.gridSize) {
      return null;
    }
    return [row, col];
  }

  List<List<int>> _computeLine(int sr, int sc, int er, int ec) {
    final dr = er - sr;
    final dc = ec - sc;
    final adr = dr.abs();
    final adc = dc.abs();

    // Só aceitar horizontal, vertical ou diagonal 45 graus
    if (adr != 0 && adc != 0 && adr != adc) {
      return [[sr, sc]];
    }

    final stepR = dr == 0 ? 0 : (dr > 0 ? 1 : -1);
    final stepC = dc == 0 ? 0 : (dc > 0 ? 1 : -1);
    final steps = adr > adc ? adr : adc;

    return List.generate(steps + 1, (i) => [sr + i * stepR, sc + i * stepC]);
  }

  void _handlePointerDown(PointerDownEvent event) {
    final cell = _pointerToCell(event.position);
    if (cell == null) return;

    setState(() {
      _isDragging = true;
      _startRow = cell[0];
      _startCol = cell[1];
      _selectedPositions = [cell];
    });
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (!_isDragging || _startRow == null || _startCol == null) return;

    final cell = _pointerToCell(event.position);
    if (cell == null) return;

    final newPositions = _computeLine(_startRow!, _startCol!, cell[0], cell[1]);

    if (_positionsChanged(newPositions)) {
      setState(() {
        _selectedPositions = newPositions;
      });
    }
  }

  void _handlePointerUp(PointerUpEvent event) {
    _finishSelection();
  }

  void _handlePointerCancel(PointerCancelEvent event) {
    _finishSelection();
  }

  void _finishSelection() {
    if (_selectedPositions.length >= 2) {
      widget.onSelectionComplete(List.from(_selectedPositions));
    }
    setState(() {
      _isDragging = false;
      _selectedPositions = [];
      _startRow = null;
      _startCol = null;
    });
  }

  bool _positionsChanged(List<List<int>> newPositions) {
    if (newPositions.length != _selectedPositions.length) return true;
    for (int i = 0; i < newPositions.length; i++) {
      if (newPositions[i][0] != _selectedPositions[i][0] ||
          newPositions[i][1] != _selectedPositions[i][1]) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _cellSize = constraints.maxWidth / widget.gridSize;
        final gridHeight = _cellSize * widget.gridSize;

        return Listener(
          onPointerDown: _handlePointerDown,
          onPointerMove: _handlePointerMove,
          onPointerUp: _handlePointerUp,
          onPointerCancel: _handlePointerCancel,
          child: SizedBox(
            key: _gridKey,
            width: constraints.maxWidth,
            height: gridHeight,
            child: Column(
              children: List.generate(widget.gridSize, (row) {
                return Row(
                  children: List.generate(widget.gridSize, (col) {
                    return _buildCell(row, col);
                  }),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCell(int row, int col) {
    final posKey = '$row,$col';
    final isSelected = _selectedPositions.any((p) => p[0] == row && p[1] == col);
    final isFound = widget.foundPositions.contains(posKey);
    final foundColor = widget.positionColorMap[posKey];

    Color bgColor;
    if (isSelected) {
      bgColor = AppTheme.wsSelectionColor;
    } else if (isFound && foundColor != null) {
      bgColor = foundColor.withValues(alpha: 0.35);
    } else {
      bgColor = Colors.transparent;
    }

    return Container(
      width: _cellSize,
      height: _cellSize,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppTheme.wsCellBorderRadius),
        border: Border.all(
          color: AppTheme.wsCellBorderColor,
          width: 0.5,
        ),
      ),
      child: Center(
        child: Text(
          widget.grid[row][col],
          style: TextStyle(
            fontSize: AppTheme.wsCellFontSize,
            fontWeight: FontWeight.bold,
            color: isFound
                ? (foundColor ?? AppTheme.wsFoundLetterColor)
                : isSelected
                    ? AppTheme.wsSelectedLetterColor
                    : AppTheme.wsCellTextColor,
          ),
        ),
      ),
    );
  }
}
