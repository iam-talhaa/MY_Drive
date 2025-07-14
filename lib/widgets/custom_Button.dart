import 'package:flutter/material.dart';

class Custom_button extends StatefulWidget {
  final name;
  Color B_color;
  VoidCallback ontap;
  final b_height;
  final b_Width;
  final textcolor;

  Custom_button({
    super.key,
    required this.name,
    required this.B_color,
    required this.ontap,
    required this.b_Width,
    required this.b_height,
    required this.textcolor,
  });

  @override
  State<Custom_button> createState() => _Custom_buttonState();
}

class _Custom_buttonState extends State<Custom_button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.b_height,
          width: widget.b_Width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.B_color.withOpacity(0.9),
                widget.B_color.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.B_color.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.textcolor,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
