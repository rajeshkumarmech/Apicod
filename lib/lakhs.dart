import 'dart:math';
import 'package:companyfoxl/sliderTooltip.dart';
import 'package:flutter/material.dart';

class SelectedChitMonth extends StatefulWidget {
  const SelectedChitMonth({super.key});

  @override
  State<SelectedChitMonth> createState() => _SelectedChitMonthState();
}

class _SelectedChitMonthState extends State<SelectedChitMonth> {
  double _currentSliderValue = 0;
  String? Name;
  double? amount;

  // Method to show Withdraw Bottom Sheet
  void _showWithdrawBottomSheet() {
    if (_currentSliderValue > 6) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 185,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 30),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/gpay.png'),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 120, top: 30),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/phonepe.png'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('For withdraw, the number of due should be greater than 6.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Method to show Add Fund Bottom Sheet
  void _showAddFundBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 185,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 30),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/gpay.png'),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 120, top: 30),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/phonepe.png'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            '1 Lakh CHITS',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 27,
              height: 37 / 27,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.close_rounded,
              size: 35,
              color: Colors.white,
            ),
          ),
          actions: const [
            Icon(
              Icons.edit_document,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Icon(
              Icons.notifications_sharp,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
              child: Container(
                height: 210,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff17B9ff)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 20),
                          child: Text("Target Amount:"),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 20, left: 10),
                          child: Text("Total Months : 10"),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 23, top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.currency_rupee_outlined,
                            color: Colors.white,
                          ),
                          Text("10000"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text("Start Date : 16/10/2024"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text("End Date : 16/10/2025"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          thumbColor: Colors.white,
                          activeTrackColor: Color.fromARGB(255, 13, 27, 139),
                          inactiveTrackColor: Color(0xffD9D9D9),
                          trackHeight: 15,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12),
                        ),
                        child: Slider(
                          value: _currentSliderValue,
                          min: 0,
                          max: 30,
                          divisions: 30,
                          onChanged: (value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: calculateTooltipPosition1(), right: 10),
                          child: SliderTooltip(
                            sliderValue: _currentSliderValue,
                            thumbWidth: 24,
                          ),
                        ),
                        Text(
                          Name != null
                              ? 'Amount: \$${amount?.toString()}'
                              : 'null',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.amberAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Image.asset("assets/progress_bar.png"),
                      Positioned(
                        top: 60,
                        left: 60,
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: CustomPaint(
                            painter: CircularProgressBarPainter(
                              progress: _currentSliderValue / 30,
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 148,
                        left: 113,
                        child: Icon(
                          Icons.currency_rupee_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const Positioned(
                        top: 145,
                        left: 135,
                        child: Text(
                          "30000",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Contribution Amount : 10000",
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: _showAddFundBottomSheet,
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff0067FF), Color(0xff090F26)],
                      ),
                    ),
                    child: const Center(
                      child: Text("ADD FUNDS"),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: _showWithdrawBottomSheet,
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff0067FF), Color(0xff090F26)],
                      ),
                    ),
                    child: const Center(
                      child: Text("WITHDRAW FUNDS"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Example tooltip positioning function (dummy)
  double calculateTooltipPosition1() {
    return (_currentSliderValue / 30) *
        280; // Adjust based on your layout needs
  }
}

class CircularProgressBarPainter extends CustomPainter {
  final double progress;

  CircularProgressBarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 10;
    final backgroundPaint = Paint()
      ..color = const Color(0xffD9D9D9)
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;
    final progressPaint = Paint()
      ..color = const Color(0xff0067FF)
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);
    final angle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
