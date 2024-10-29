import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectedChit extends StatefulWidget {
  const SelectedChit({super.key});

  @override
  State<SelectedChit> createState() => _SelectedChitState();
}

class _SelectedChitState extends State<SelectedChit> {
  Map<String, dynamic>? chitData;

  void PurchaseUser() async {
    const url =
        'https://chitsoft.in/wapp/api/mobile3/payment_chit.php?user=123&password=1234';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        chitData = json;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    PurchaseUser(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
            Icons.file_open_sharp,
            size: 35,
            color: Colors.white,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: chitData == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/AfterBG.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                children: [
                  // Display chit data
                  displayOfMonthAndOthers(
                      size,
                      "12", // Assuming 12 months chit
                      chitData?["Datas"]?[1].split(":")[1],
                      chitData?["Datas"]?[2].split(":")[1],
                      chitData?["Datas"]?[3].split(":")[1],
                      chitData?["Datas"]?[4].split(":")[1]),
                  const SizedBox(
                    height: 20,
                  ),
                  // Payment table
                  buildPaymentTable(size),
                ],
              ),
            ),
    );
  }

  Widget buildPaymentTable(Size size) {
    // Cast the dynamic lists to List<String>
    List<String>? dates = List<String>.from(chitData?["Date"]);
    List<String>? payments = List<String>.from(chitData?["payment"]);
    List<String>? paymentDetails =
        List<String>.from(chitData?["payment_detial"]);

    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent, // Border color
          width: 2, // Border width
        ),
        borderRadius: BorderRadius.circular(15), // Curved corners
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Ensure rounded corners
        child: Table(
          border: const TableBorder(
            horizontalInside: BorderSide(color: Colors.blueAccent, width: 1),
            verticalInside: BorderSide(color: Colors.blueAccent, width: 1),
            bottom: BorderSide.none, // No border at the bottom
          ),
          columnWidths: const {
            0: FixedColumnWidth(55),
            1: FixedColumnWidth(100),
            2: FixedColumnWidth(100),
            3: FixedColumnWidth(90),
          },
          children: [
            _buildTableHeader(),
            for (int i = 0; i < dates.length; i++)
              _buildTableRow(
                (i + 1).toString(),
                dates[i],
                "₹ ${payments[i]}",
                paymentDetails[i],
                paymentDetails[i] == "paid" ? Colors.green : Colors.red,
              ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return const TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'S.No',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Dates',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Payment',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'No.of.paid',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String serial, String date, String amount,
      String status, Color statusColor) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(serial, style: const TextStyle(color: Colors.white)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(date, style: const TextStyle(color: Colors.white)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(amount, style: const TextStyle(color: Colors.white)),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              status,
              style: TextStyle(color: statusColor),
            ),
          ),
        ),
      ],
    );
  }

  Container displayOfMonthAndOthers(Size size, String month, String startdate,
      String enddate, String totalinvestors, String brokerage) {
    return Container(
      height: size.height / 2.65,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blueAccent, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$month months chit',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 30,
              height: 19 / 24,
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Chit Amount :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  height: 22 / 15,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.currency_rupee_outlined,
                size: 28,
                color: Colors.white,
              ),
              Text(
                ' ${chitData?["Datas"][0].split(":")[1]}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  height: 22 / 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Start date',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 22 / 15,
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                    ),
                  ),
                  Text(
                    startdate,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      height: 22 / 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'End date',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 22 / 15,
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                    ),
                  ),
                  Text(
                    enddate,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      height: 22 / 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Total Investors :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 22 / 15,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                totalinvestors,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 22 / 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Brokerage :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 22 / 15,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                brokerage,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 22 / 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
