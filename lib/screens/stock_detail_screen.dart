import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'stock_service.dart';

class StockDetailScreen extends StatefulWidget {
  final String symbol;

  const StockDetailScreen({super.key, required this.symbol});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  String companyName = '';
  String logoUrl = '';
  double price = 0.0;
  double change = 0.0;
  double percent = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStockDetails();
  }

  Future<void> fetchStockDetails() async {
    try {
      final quote = await StockService.fetchQuote(widget.symbol);
      final logo = await StockService.fetchLogo(widget.symbol);

      setState(() {
        logoUrl = logo;
        price = quote['c'];
        change = quote['d'];
        percent = quote['dp'];
        companyName = _getCompanyName(widget.symbol);
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading stock: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoss = change < 0;
    final color = isLoss ? Colors.red : Colors.green;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EEDC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5EEDC),
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                Image.network(logoUrl, width: 40, errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.symbol,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(companyName, style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.star_border),
                  label: const Text("Following"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.blue),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(
                  "${change > 0 ? '+' : ''}\$${change.toStringAsFixed(2)} (${percent.toStringAsFixed(1)}%)",
                  style: TextStyle(color: color),
                )
              ],
            ),
            const SizedBox(height: 8),
            _buildChartCard(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Sell"),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Buy"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE6D2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Your Portfolio",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Value"),
                          Text("\$${price.toStringAsFixed(2)}",
                              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text("Avg. Price"),
                          Text("\$1,560.24", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Number of lots"),
                          Text("12", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 180,
      child: LineChart(LineChartData(
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 12),
              FlSpot(1, 40),
              FlSpot(2, 20),
              FlSpot(3, 15),
              FlSpot(4, 26),
              FlSpot(5, 24),
              FlSpot(6, 10),
            ],
            isCurved: false,
            color: Colors.blue,
            barWidth: 2,
            dotData: FlDotData(show: true),
          )
        ],
      )),
    );
  }

  Widget _buildTabBar() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Chip(label: Text("Summary")),
        Text("About", style: TextStyle(color: Colors.grey)),
        Text("Analysis", style: TextStyle(color: Colors.grey)),
        Text("Peers", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  String _getCompanyName(String symbol) {
    switch (symbol) {
      case 'AAPL':
        return 'Apple Inc.';
      case 'TSLA':
        return 'Tesla Inc.';
      case 'GOOGL':
        return 'Alphabet Inc.';
      case 'MSFT':
        return 'Microsoft Corp.';
      case 'AMZN':
        return 'Amazon Inc.';
      default:
        return symbol;
    }
  }
}
