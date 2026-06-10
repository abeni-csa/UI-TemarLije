import 'package:flutter/material.dart';

class EditableMarkCell extends StatefulWidget {
  final String studentId;
  final String columnName;
  final String initialValue;
  final Function(String) onMarkChanged;

  const EditableMarkCell({
    super.key,
    required this.studentId,
    required this.columnName,
    required this.initialValue,
    required this.onMarkChanged,
  });

  @override
  State<EditableMarkCell> createState() => _EditableMarkCellState();
}

class _EditableMarkCellState extends State<EditableMarkCell> {
  late TextEditingController _controller;
  bool _isEditing = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant EditableMarkCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() => _isEditing = true);
    _controller.text = widget.initialValue;
  }

  void _saveEdit() {
    final newValue = _controller.text.trim();
    setState(() => _isEditing = false);
    if (newValue != widget.initialValue) {
      widget.onMarkChanged(newValue);
    }
  }

  void _cancelEdit() {
    setState(() => _isEditing = false);
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onDoubleTap: _startEditing,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: _isHovering ? Colors.grey[100] : null,
            borderRadius: BorderRadius.circular(4),
          ),
          child: _isEditing
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => _saveEdit(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, size: 18),
                      onPressed: _saveEdit,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: _cancelEdit,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.initialValue.isEmpty ? '—' : widget.initialValue,
                        style: TextStyle(
                          color: widget.initialValue.isEmpty
                              ? Colors.grey[400]
                              : Colors.black,
                          fontStyle: widget.initialValue.isEmpty
                              ? FontStyle.italic
                              : FontStyle.normal,
                        ),
                      ),
                    ),
                    if (_isHovering)
                      const Icon(Icons.edit, size: 14, color: Colors.grey),
                  ],
                ),
        ),
      ),
    );
  }
}
