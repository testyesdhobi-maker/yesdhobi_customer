import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/laundry_item.dart';
import '../theme/app_theme.dart';
import 'select_items_screen.dart';
import 'track_order_screen.dart';
import 'manage_addresses_screen.dart';
import 'help_support_screen.dart';
import 'order_details_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final int initialTab;

  const HomeScreen({
    super.key,
    this.initialTab = 0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedBottomNav;
  String _selectedLocation = 'Home - HSR Layout';
  int _selectedOrderFilter = 0; // 0: Active, 1: Completed, 2: Cancelled

  @override
  void initState() {
    super.initState();
    _selectedBottomNav = widget.initialTab;
  }

  final List<Map<String, dynamic>> _serviceCards = [
    {
      'title': 'Wash & Fold',
      'price': 'From ₹49',
      'category': ServiceCategory.washAndFold,
      'bg': const Color(0xFFEFF6FF),
      'tint': const Color(0xFF2563EB),
      'icon': Icons.dry_cleaning_outlined,
    },
    {
      'title': 'Wash & Iron',
      'price': 'From ₹69',
      'category': ServiceCategory.washAndIron,
      'bg': const Color(0xFFE8FBF4),
      'tint': const Color(0xFF0D9488),
      'icon': Icons.highlight_off_rounded,
    },
    {
      'title': 'Steam Iron',
      'price': 'From ₹39',
      'category': ServiceCategory.steamIron,
      'bg': const Color(0xFFFEF9C3),
      'tint': const Color(0xFFCA8A04),
      'icon': Icons.sanitizer_outlined,
    },
    {
      'title': 'Dry Cleaning',
      'price': 'From ₹149',
      'category': ServiceCategory.dryCleaning,
      'bg': const Color(0xFFFDF2F8),
      'tint': const Color(0xFFDB2777),
      'icon': Icons.checkroom_rounded,
    },
    {
      'title': 'Shoe\nCleaning',
      'price': 'From ₹199',
      'category': ServiceCategory.shoeCleaning,
      'bg': const Color(0xFFEFF6FF),
      'tint': const Color(0xFF3B82F6),
      'icon': Icons.highlight_off_rounded,
    },
    {
      'title': 'Household',
      'price': 'From ₹299',
      'category': ServiceCategory.household,
      'bg': const Color(0xFFF3E8FF),
      'tint': const Color(0xFF9333EA),
      'icon': Icons.home_outlined,
    },
  ];

  void _onServiceSelected(ServiceCategory category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectItemsScreen(initialCategory: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _selectedBottomNav,
          children: [
            _buildHomeContent(),
            _buildMyOrdersContent(),
            _buildOffersContent(),
            _buildAccountContent(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFF1F5F9), width: 1.2),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedBottomNav,
          onTap: (index) {
            setState(() => _selectedBottomNav = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: const Color(0xFF94A3B8),
          elevation: 0,
          selectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home_rounded),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.checklist_rounded),
              ),
              label: 'My Orders',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.confirmation_number_outlined),
              ),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.person_outline_rounded),
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }

  // ================= TAB 0: HOME CONTENT =================
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Delivering to Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DELIVERING TO',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: _showAddressSelectionModal,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _selectedLocation,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Greeting
          Text(
            'Good Morning, Rahul!',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Let's fresh up your clothes today.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 20),

          // Search Bar
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF94A3B8),
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onSubmitted: (val) {
                      _onServiceSelected(ServiceCategory.washAndFold);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for Dry Clean, Iron, etc...',
                      hintStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Promo Banner Card
          GestureDetector(
            onTap: () => _onServiceSelected(ServiceCategory.washAndFold),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF1D4ED8)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAB308),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'FIRSTORDER',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F172A),
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Get 20% OFF your first\norder!',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Valid on any laundry or dry clean service.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/images/laundry_basket.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.white.withValues(alpha: 0.15),
                        child: const Icon(
                          Icons.shopping_basket_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Choose Service Section
          Text(
            'Choose Service',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // 3 Columns x 2 Rows Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _serviceCards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 14,
              childAspectRatio: 0.92,
            ),
            itemBuilder: (context, index) {
              final card = _serviceCards[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFF1F5F9), width: 1.4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      _onServiceSelected(card['category'] as ServiceCategory);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: card['bg'] as Color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              card['icon'] as IconData,
                              color: card['tint'] as Color,
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            card['title'] as String,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            card['price'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ================= TAB 1: MY ORDERS (SCREENSHOT 2) =================
  Widget _buildMyOrdersContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Orders',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Filter Segment Pills: Active, Completed, Cancelled
          Row(
            children: [
              _buildOrderFilterChip('Active', 0),
              const SizedBox(width: 10),
              _buildOrderFilterChip('Completed', 1),
              const SizedBox(width: 10),
              _buildOrderFilterChip('Cancelled', 2),
            ],
          ),

          const SizedBox(height: 20),

          // Order Card 1: Active
          if (_selectedOrderFilter == 0 || _selectedOrderFilter == -1)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OrderDetailsScreen(
                          orderId: '#YD-892740',
                          status: 'RIDER ON WAY',
                          dateSubtitle: 'Ordered on 24 Oct 2026, 11:30 AM',
                          items: [
                            {
                              'name': 'Shirt',
                              'service': 'Wash & Iron',
                              'quantity': 2,
                              'price': 80,
                            },
                            {
                              'name': 'T-Shirt',
                              'service': 'Wash & Iron',
                              'quantity': 1,
                              'price': 30,
                            },
                            {
                              'name': 'Bedsheet',
                              'service': 'Wash & Fold',
                              'quantity': 1,
                              'price': 120,
                            },
                          ],
                          subtotal: 230,
                          discount: 46,
                          grandTotal: 184,
                          riderName: 'Ramesh Kumar',
                          rating: 5.0,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'YD-892740',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '24 Oct 2026',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'RIDER ON WAY',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ITEMS & SERVICE',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF94A3B8),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '4 Items • Wash & Iron',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'TOTAL AMOUNT',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF94A3B8),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹184',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const TrackOrderScreen(
                                    orderId: 'YD-892740',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Track Order',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Order Card 2: Completed
          if (_selectedOrderFilter == 1 || _selectedOrderFilter == -1)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OrderDetailsScreen(
                          orderId: '#YD-881590',
                          status: 'DELIVERED',
                          dateSubtitle: 'Completed on 18 Oct 2026, 4:15 PM',
                          items: [
                            {
                              'name': 'Shirt',
                              'service': 'Wash & Iron',
                              'quantity': 2,
                              'price': 80,
                            },
                            {
                              'name': 'T-Shirt',
                              'service': 'Wash & Iron',
                              'quantity': 1,
                              'price': 30,
                            },
                            {
                              'name': 'Bedsheet',
                              'service': 'Wash & Fold',
                              'quantity': 1,
                              'price': 120,
                            },
                          ],
                          subtotal: 230,
                          discount: 46,
                          grandTotal: 184,
                          riderName: 'Rahul',
                          rating: 5.0,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'YD-881590',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '18 Oct 2026',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'DELIVERED',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF059669),
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ITEMS & SERVICE',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF94A3B8),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '4 Items • Wash & Fold',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'TOTAL AMOUNT',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF94A3B8),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹184',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SelectItemsScreen(
                                    initialCategory: ServiceCategory.washAndFold,
                                  ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Reorder',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Order Card 3: Cancelled
          if (_selectedOrderFilter == 2 || _selectedOrderFilter == -1)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OrderDetailsScreen(
                          orderId: '#YD-871402',
                          status: 'CANCELLED',
                          dateSubtitle: 'Cancelled on 10 Oct 2026, 2:00 PM',
                          items: [
                            {
                              'name': 'Saree Press',
                              'service': 'Steam Press',
                              'quantity': 5,
                              'price': 75,
                            },
                          ],
                          subtotal: 75,
                          discount: 0,
                          grandTotal: 75,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'YD-871402',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '10 Oct 2026',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF2F2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'CANCELLED',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFFDC2626),
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ITEMS & SERVICE',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF94A3B8),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '5 Items • Steam Press',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'TOTAL AMOUNT',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF94A3B8),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹75',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderFilterChip(String label, int index) {
    final isSelected = _selectedOrderFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedOrderFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ================= TAB 2: OFFERS & COUPONS (SCREENSHOT 3) =================
  Widget _buildOffersContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offers & Coupons',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Refer & Earn ₹50 Blue Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF1D4ED8)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Refer & Earn ₹50!',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Share the love of clean clothes. Both get ₹50 on first delivery.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFACC15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.card_giftcard_rounded,
                    color: Color(0xFF0F172A),
                    size: 28,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Text(
            'Available Coupons',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),

          // Coupon 1: FIRST20
          _buildCouponCard(
            code: 'FIRST20',
            discountBadge: '20% OFF',
            description:
                'Get 20% off your very first laundry or dry clean order!',
            expiry: 'Expires 30 Nov 2026',
          ),

          // Coupon 2: WEEKLY10
          _buildCouponCard(
            code: 'WEEKLY10',
            discountBadge: '₹10 OFF',
            description:
                'Rs. 10 flat off on all orders valued above Rs. 299',
            expiry: 'Expires 15 Nov 2026',
          ),

          // Coupon 3: REFER50
          _buildCouponCard(
            code: 'REFER50',
            discountBadge: '₹50 BONUS',
            description:
                'Get Rs. 50 bonus wallet balance for every referral you make',
            expiry: 'Never Expires',
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({
    required String code,
    required String discountBadge,
    required String description,
    required String expiry,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFFFACC15),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  code,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Text(
                discountBadge,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF059669),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expiry,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coupon $code applied!'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                child: Text(
                  'APPLY',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= TAB 3: MY ACCOUNT (SCREENSHOT 4) =================
  Widget _buildAccountContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Account',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),

          // User Profile Info Card
          GestureDetector(
            onTap: _showEditProfileModal,
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF6FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Rahul Sharma',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.edit_outlined,
                            color: AppColors.primary,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'rahul.sharma@example.com • 9876543210',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Menu Options
          _buildAccountMenuItem(
            icon: Icons.location_on_outlined,
            title: 'My Addresses',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ManageAddressesScreen(),
                ),
              );
            },
          ),
          _buildAccountMenuItem(
            icon: Icons.payment_outlined,
            title: 'Payment Methods',
            onTap: () {
              _showInfoDialog(
                title: 'Payment Methods',
                message:
                    'Saved Cards & UPI IDs:\n• Google Pay (UPI: rahul@okhdfc)\n• HDFC Credit Card (ending in 8842)',
              );
            },
          ),
          _buildAccountMenuItem(
            icon: Icons.tune_rounded,
            title: 'Order Preferences',
            onTap: () {
              _showInfoDialog(
                title: 'Order Preferences',
                message:
                    'Default Preferences:\n• Detergent: Hypoallergenic Eco\n• Iron Temperature: Fabric Safe\n• Packaging: Eco-Friendly Paper Bags',
              );
            },
          ),
          _buildAccountMenuItem(
            icon: Icons.card_giftcard_rounded,
            title: 'Refer & Earn',
            onTap: () {
              setState(() => _selectedBottomNav = 2);
            },
          ),
          _buildAccountMenuItem(
            icon: Icons.help_outline_rounded,
            title: 'Help & Support',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HelpSupportScreen(),
                ),
              );
            },
          ),
          _buildAccountMenuItem(
            icon: Icons.star_border_rounded,
            title: 'Rate Us',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thank you for rating Yes Dhobi 5 Stars! ⭐⭐⭐⭐⭐'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
          _buildAccountMenuItem(
            icon: Icons.info_outline_rounded,
            title: 'About',
            onTap: () {
              _showInfoDialog(
                title: 'About Yes Dhobi',
                message:
                    'Yes Dhobi App v1.0.0\nYour trusted door-to-door fabric care & dry cleaning partner.',
              );
            },
          ),
          _buildAccountMenuItem(
            icon: Icons.logout_rounded,
            title: 'Logout',
            isDestructive: true,
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAccountMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? const Color(0xFFDC2626) : AppColors.primary;
    final textColor =
        isDestructive ? const Color(0xFFDC2626) : AppColors.textPrimary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDestructive
                      ? const Color(0xFFDC2626)
                      : const Color(0xFF94A3B8),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showInfoDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            height: 1.45,
            color: const Color(0xFF475569),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'OK',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressSelectionModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Delivery Location',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.home_rounded, color: AppColors.primary),
              title: const Text('Home - HSR Layout'),
              subtitle: const Text('Flat 402, Green Glen Layout, 560103'),
              onTap: () {
                setState(() => _selectedLocation = 'Home - HSR Layout');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.work_rounded, color: AppColors.primary),
              title: const Text('Work - Koramangala'),
              subtitle: const Text('WeWork Galaxy, 43, Residency Road'),
              onTap: () {
                setState(() => _selectedLocation = 'Work - Koramangala');
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add_location_alt_outlined,
                  color: AppColors.primary),
              title: const Text('Manage Addresses'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ManageAddressesScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileModal() {
    final nameCtrl = TextEditingController(text: 'Rahul Sharma');
    final emailCtrl = TextEditingController(text: 'rahul.sharma@example.com');
    final phoneCtrl = TextEditingController(text: '9876543210');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Profile',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneCtrl,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
