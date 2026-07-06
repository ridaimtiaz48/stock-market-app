import 'package:flutter/material.dart';
import 'stock_service.dart';
import 'stock_detail_screen.dart';
import 'news_screen.dart';
import 'upgrade_pro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<String> symbols = ['AAPL', 'TSLA', 'GOOGL', 'MSFT', 'AMZN'];
  final Map<String, Map<String, dynamic>> stockData = {};
  bool showBalance = true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    fetchAllStocks();
  }

  Future<void> fetchAllStocks() async {
    for (String symbol in symbols) {
      try {
        final quote = await StockService.fetchQuote(symbol);
        final logo = await StockService.fetchLogo(symbol);
        stockData[symbol] = {
          'price': quote['c'],
          'change': quote['d'],
          'percent': quote['dp'],
          'logo': logo,
        };
        setState(() {});
      } catch (e) {
        debugPrint("Error fetching $symbol: $e");
      }
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEDC),
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5EEDC),
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset('assets/monex_logo.png', width: 36),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "Dashboard"),
            Tab(text: "News"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _buildDashboard(),
          const NewsScreen(),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF5EEDC),
      child: Column(
        children: [
          Container(
            height: 140,
            color: Colors.black,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/monex_logo.png', height: 40),
                  const SizedBox(width: 10),
                  const Text(
                    "MONEX",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              tabController.index = 0;
            },
          ),
          ListTile(
            leading: const Icon(Icons.search, color: Colors.black),
            title: const Text("Search"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.article, color: Colors.black),
            title: const Text("News"),
            onTap: () {
              Navigator.pop(context);
              tabController.index = 1;
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("GENERAL", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log Out", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UpgradeProScreen()),
                );
              },
              child: const Text("Buy Pro Version"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Text("Total Portfolio", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                showBalance ? "\$14,343.88" : "••••••••",
                style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Text(
                "+\$12.60 (+4%)",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              setState(() {
                showBalance = !showBalance;
              });
            },
            child: Text(
              showBalance ? "Hide Amount" : "Show Amount",
              style: const TextStyle(color: Colors.blue),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFECE6D7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showBalance ? "\$2,510.60" : "•••••••",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("+ Deposit"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Stock Portfolio", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("View All", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: symbols.take(3).map((s) {
                final data = stockData[s];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => StockDetailScreen(symbol: s)));
                  },
                  child: _stockCard(
                    symbol: s,
                    logoUrl: data?['logo'],
                    price: data?['price'],
                    change: data?['change'],
                    percent: data?['percent'],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Watchlist", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("+ Add New", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          ...symbols.map((s) {
            final data = stockData[s];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => StockDetailScreen(symbol: s)));
              },
              child: _watchlistItem(
                symbol: s,
                company: getCompanyName(s),
                logoUrl: data?['logo'],
                price: data?['price'],
                change: data?['change'],
                percent: data?['percent'],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _stockCard({
    required String symbol,
    String? logoUrl,
    num? price,
    num? change,
    num? percent,
  }) {
    final isLoss = (change ?? 0) < 0;
    return Container(
      width: 105,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          if (logoUrl != null && logoUrl.isNotEmpty)
            Image.network(logoUrl, height: 24)
          else
            const SizedBox(height: 24),
          const SizedBox(height: 6),
          Text(symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(getCompanyName(symbol), style: const TextStyle(fontSize: 10)),
          const SizedBox(height: 4),
          Text("\$${price?.toStringAsFixed(2) ?? "--"}", style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(
            "${isLoss ? '' : '+'}${change?.toStringAsFixed(2) ?? "--"} (${percent?.toStringAsFixed(2) ?? "--"}%)",
            style: TextStyle(fontSize: 12, color: isLoss ? Colors.red : Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _watchlistItem({
    required String symbol,
    required String company,
    String? logoUrl,
    num? price,
    num? change,
    num? percent,
  }) {
    final isLoss = (change ?? 0) < 0;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: logoUrl != null && logoUrl.isNotEmpty
          ? Image.network(logoUrl, width: 28)
          : const CircleAvatar(child: Text("")),
      title: Text(symbol, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(company, style: const TextStyle(fontSize: 12)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("\$${price?.toStringAsFixed(2) ?? "--"}", style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            "${isLoss ? '' : '+'}${change?.toStringAsFixed(2) ?? "--"} (${percent?.toStringAsFixed(2) ?? "--"}%)",
            style: TextStyle(color: isLoss ? Colors.red : Colors.green),
          ),
        ],
      ),
    );
  }

  String getCompanyName(String symbol) {
    switch (symbol) {
      case 'AAPL':
        return 'Apple Inc.';
      case 'TSLA':
        return 'Tesla Inc.';
      case 'GOOGL':
        return 'Alphabet Inc.';
      case 'MSFT':
        return 'Microsoft Inc.';
      case 'AMZN':
        return 'Amazon Inc.';
      default:
        return symbol;
    }
  }
}
