import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FooterText extends StatefulWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onActionTap;
  final int? countdownSeconds;

  const FooterText({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onActionTap,
    this.countdownSeconds,
  });

  @override
  State<FooterText> createState() => _FooterTextState();
}

class _FooterTextState extends State<FooterText> {
  Timer? _timer;
  int _currentSeconds = 0;
  bool _isCountdownActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.countdownSeconds != null && widget.countdownSeconds! > 0) {
      _startCountdown(widget.countdownSeconds!);
    }
  }

  void _startCountdown(int seconds) {
    setState(() {
      _currentSeconds = seconds;
      _isCountdownActive = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds == 1) {
        setState(() {
          _isCountdownActive = false;
          _timer?.cancel();
        });
      } else {
        setState(() {
          _currentSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String displayActionText = _isCountdownActive
        ? '${(_currentSeconds ~/ 60)}:${(_currentSeconds % 60).toString().padLeft(2, '0')}'
        : widget.actionText;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.questionText,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[600],
          ),
        ),
        GestureDetector(
          onTap: _isCountdownActive
              ? null
              : () {
                  widget.onActionTap();
                  if (widget.countdownSeconds != null) {
                    _startCountdown(widget.countdownSeconds!);
                  }
                },
          child: Text(
            displayActionText,
            style: TextStyle(
              fontSize: 13.sp,
              color: _isCountdownActive
                  ? Colors.grey[400]
                  : const Color(0xFF2F857D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
