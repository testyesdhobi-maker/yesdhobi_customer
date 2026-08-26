import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class AddressModel {
  final String id;
  String tag;
  String fullAddress;

  AddressModel({
    required this.id,
    required this.tag,
    required this.fullAddress,
  });
}

class ManageAddressesScreen extends StatefulWidget {
  const ManageAddressesScreen({super.key});

  @override
  State<ManageAddressesScreen> createState() => _ManageAddressesScreenState();
}

class _ManageAddressesScreenState extends State<ManageAddressesScreen> {
  final List<AddressModel> _addresses = [
    AddressModel(
      id: 'addr_1',
      tag: 'Home',
      fullAddress:
          'Flat No. 402, Block B, Silver Oak Residency, Sector 3, HSR Layout, Bangalore - 560102',
    ),
    AddressModel(
      id: 'addr_2',
      tag: 'Work',
      fullAddress:
          'WeWork Galaxy, 43, Residency Road, Shanthala Nagar, Ashok Nagar, Bangalore - 560025',
    ),
    AddressModel(
      id: 'addr_3',
      tag: 'Other',
      fullAddress:
          'House 12, Cross Road 5, Koramangala Block 4, Bangalore - 560034',
    ),
  ];

  void _showAddEditAddressDialog({AddressModel? addressToEdit}) {
    final isEditing = addressToEdit != null;
    final tagController =
        TextEditingController(text: isEditing ? addressToEdit.tag : 'Home');
    final addrController =
        TextEditingController(text: isEditing ? addressToEdit.fullAddress : '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          isEditing ? 'Edit Address' : 'Add New Address',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: tagController,
              decoration: const InputDecoration(
                labelText: 'Label (e.g. Home, Work, Other)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: addrController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Complete Address with Pincode',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final tag = tagController.text.trim();
              final addr = addrController.text.trim();
              if (tag.isNotEmpty && addr.isNotEmpty) {
                setState(() {
                  if (isEditing) {
                    addressToEdit.tag = tag;
                    addressToEdit.fullAddress = addr;
                  } else {
                    _addresses.add(
                      AddressModel(
                        id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
                        tag: tag,
                        fullAddress: addr,
                      ),
                    );
                  }
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEditing
                          ? 'Address updated successfully!'
                          : 'New address added!',
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                );
              }
            },
            child: Text(isEditing ? 'Update' : 'Save Address'),
          ),
        ],
      ),
    );
  }

  void _deleteAddress(int index) {
    final deleted = _addresses[index];
    setState(() {
      _addresses.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deleted.tag} address removed'),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _addresses.insert(index, deleted);
            });
          },
        ),
        backgroundColor: AppColors.textPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(
                Icons.chevron_left_rounded,
                color: AppColors.textPrimary,
                size: 26,
              ),
            ),
          ),
        ),
        title: Text(
          'Manage Addresses',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: _addresses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row (Icon, Title, Edit, Delete)
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              address.tag,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          // Edit Button
                          GestureDetector(
                            onTap: () => _showAddEditAddressDialog(
                              addressToEdit: address,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color(0xFF64748B),
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Delete Button
                          GestureDetector(
                            onTap: () => _deleteAddress(index),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.delete_outline_rounded,
                                color: Color(0xFFEF4444),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Address Text
                      Text(
                        address.fullAddress,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF64748B),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom Add New Address Button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            color: Colors.white,
            child: CustomButton(
              text: '+ Add New Address',
              onPressed: () => _showAddEditAddressDialog(),
            ),
          ),
        ],
      ),
    );
  }
}
