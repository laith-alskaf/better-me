import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:BetterMe/features/medicine/data/models/medicine.dart';
import 'package:BetterMe/config/theme/app_colors.dart';
import 'package:BetterMe/config/theme/design_system.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const MedicineCard({
    super.key,
    required this.medicine,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: DesignSystem.animationDurationNormal,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
          border: Border.all(
            color: AppColors.outline.withValues(alpha: 0.3),
            width: DesignSystem.borderWidthBase,
          ),
          boxShadow: DesignSystem.shadowElevation8,
        ),
        padding: DesignSystem.paddingMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: DesignSystem.base),
            _buildBody(),
            const SizedBox(height: DesignSystem.md),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine.medicineName ?? 'Unknown',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: DesignSystem.xs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignSystem.md,
                  vertical: DesignSystem.xs,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getMedicineTypeColor().withValues(alpha: 0.1),
                      _getMedicineTypeColor().withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(DesignSystem.radiusSm),
                  border: Border.all(
                    color: _getMedicineTypeColor().withValues(alpha: 0.2),
                    width: DesignSystem.borderWidthBase,
                  ),
                ),
                child: Text(
                  medicine.medicineType ?? 'N/A',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: _getMedicineTypeColor(),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: DesignSystem.lg),
        _buildTypeIcon(),
      ],
    );
  }

  Widget _buildTypeIcon() {
    final icon = _getMedicineTypeIcon();
    final color = _getMedicineTypeColor();
    return Container(
      padding: EdgeInsets.all(DesignSystem.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(DesignSystem.radiusMd),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: DesignSystem.borderWidthMedium,
        ),
        boxShadow: DesignSystem.shadowElevation4,
      ),
      child: Icon(
        icon,
        color: color,
        size: 22.sp,
      ),
    );
  }

  Widget _buildBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildInfoItem(
            'dosage'.tr,
            '${medicine.dosage ?? 'N/A'} mg',
            Icons.local_pharmacy_outlined,
            Colors.blue,
          ),
        ),
        const SizedBox(width: DesignSystem.base),
        Expanded(
          child: _buildInfoItem(
            'frequency'.tr,
            _formatFrequency(medicine.interval ?? 1),
            Icons.schedule,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      padding: EdgeInsets.all(DesignSystem.md),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(DesignSystem.radiusSm),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.1),
          width: DesignSystem.borderWidthBase,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14.sp,
                color: iconColor,
              ),
              const SizedBox(width: DesignSystem.xs),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignSystem.xs),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: iconColor,
              letterSpacing: 0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.edit_rounded,
            label: 'edit'.tr,
            onPressed: onEdit,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            isOutline: false,
          ),
        ),
        const SizedBox(width: DesignSystem.md),
        Expanded(
          child: _ActionButton(
            icon: Icons.delete_rounded,
            label: 'delete'.tr,
            onPressed: onDelete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            isOutline: false,
          ),
        ),
      ],
    );
  }

  String _formatFrequency(int interval) {
    if (interval == 1) return 'every_hour'.tr;
    if (interval == 24) return 'daily'.tr;
    return 'every_$interval h'.tr;
  }

  Color _getMedicineTypeColor() {
    switch (medicine.medicineType?.toLowerCase()) {
      case 'pill':
        return Colors.blue;
      case 'tablet':
        return Colors.green;
      case 'capsule':
        return Colors.orange;
      case 'liquid':
        return Colors.purple;
      case 'injection':
        return Colors.red;
      case 'syrup':
        return Colors.amber;
      case 'cream':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getMedicineTypeIcon() {
    switch (medicine.medicineType?.toLowerCase()) {
      case 'pill':
        return Icons.circle;
      case 'tablet':
        return Icons.square_rounded;
      case 'capsule':
        return Icons.egg_outlined;
      case 'liquid':
        return Icons.water_drop;
      case 'injection':
        return Icons.vaccines;
      case 'syrup':
        return Icons.local_drink;
      case 'cream':
        return Icons.spa;
      default:
        return Icons.medication_outlined;
    }
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isOutline;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.isOutline = false,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: DesignSystem.animationDurationNormal,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.95)
            .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
        child: Material(
          color: widget.isOutline
              ? widget.backgroundColor.withValues(alpha: 0.1)
              : widget.backgroundColor,
          borderRadius: BorderRadius.circular(DesignSystem.radiusSm),
          elevation: widget.isOutline ? 0 : 2,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(DesignSystem.radiusSm),
            splashColor: Colors.white.withValues(alpha: 0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSystem.sm,
                vertical: DesignSystem.sm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: DesignSystem.iconXs,
                    color: widget.foregroundColor,
                  ),
                  const SizedBox(width: DesignSystem.xs),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: widget.foregroundColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}