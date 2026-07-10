import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:elfulk/src/core/helpers/helpers.dart';
import 'package:elfulk/src/core/widgets/app_screen_template.dart';
import 'package:elfulk/src/core/widgets/custom_text_field.dart';
import 'package:elfulk/src/core/widgets/primary_button.dart';

class AddChildScreen extends StatefulWidget {
	const AddChildScreen({super.key});

	@override
	State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
	final TextEditingController _childNameController = TextEditingController();

	String? _selectedGender;
	DateTime? _selectedBirthDate;

	@override
	void dispose() {
		_childNameController.dispose();
		super.dispose();
	}

	Future<void> _pickBirthDate() async {
		final DateTime now = DateTime.now();
		final DateTime initialDate =
				_selectedBirthDate ?? DateTime(now.year - 5, now.month, now.day);

		final DateTime? pickedDate = await showDatePicker(
			context: context,
			initialDate: initialDate,
			firstDate: DateTime(now.year - 18),
			lastDate: now,
			builder: (BuildContext context, Widget? child) {
				return Theme(
					data: Theme.of(context).copyWith(
						datePickerTheme: DatePickerThemeData(
							headerBackgroundColor: Theme.of(context).colorScheme.surface,
							dayForegroundColor: WidgetStatePropertyAll(
								Theme.of(context).colorScheme.onSurface,
							),
						),
					),
					child: child ?? const SizedBox.shrink(),
				);
			},
		);

		if (pickedDate != null) {
			setState(() {
				_selectedBirthDate = pickedDate;
			});
		}
	}

	String _formatBirthDate(DateTime date) {
		final String day = date.day.toString().padLeft(2, '0');
		final String month = date.month.toString().padLeft(2, '0');
		return '$day/$month/${date.year}';
	}

	

	@override
	Widget build(BuildContext context) {
		final ThemeData theme = Theme.of(context);

		return AppScreenTemplate(
			
		
			child: Form(
				key: _formKey,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						Text(
							'أضف طفلك وخصص تجربته',
							style: theme.textTheme.headlineSmall?.copyWith(
										fontSize: 24.sp,
										fontWeight: FontWeight.w800,
									) ??
									TextStyle(
										fontSize: 24.sp,
										fontWeight: FontWeight.w800,
										color: theme.colorScheme.onSurface,
									),
						),
						SizedBox(height: context.spacing.s.h),
						Text(
							'أدخل اسم طفلك وعمره لنهيئ له محتوى يناسبه تمامًا.',
							style: theme.textTheme.bodyMedium?.copyWith(
										fontSize: 13.sp,
										color: theme.colorScheme.onSurface.withValues(alpha: 0.58),
									) ??
									TextStyle(
										fontSize: 13.sp,
										color: theme.colorScheme.onSurface.withValues(alpha: 0.58),
									),
						),
						SizedBox(height: context.spacing.lg.h),
						CustomTextField(
							controller: _childNameController,
							hintText: 'اسم طفلك',
							prefixIcon: SvgPicture.asset(AssetsPathHelper.profile),
						),
						SizedBox(height: context.spacing.md.h),
						_buildDropdownField(
							hintText: 'الجنس',
							iconPath: AssetsPathHelper.gender,
							value: _selectedGender,
							items: const <String>['ذكر', 'أنثى'],
							onChanged: (String? value) {
								setState(() {
									_selectedGender = value;
								});
							},
							validator: (String? value) {
								if (value == null || value.isEmpty) {
									return 'الرجاء اختيار الجنس';
								}
								return null;
							},
						),
						SizedBox(height: context.spacing.md.h),
						_buildDateField(),
						SizedBox(height: context.spacing.lg.h),
						PrimaryButton(
							text: 'الانتقال إلى لوحة التحكم',
							icon: SvgPicture.asset(AssetsPathHelper.login),
							rtlIcon: false,
              onPressed: () {
                
              },
						),
						SizedBox(height: context.spacing.md.h),
						SizedBox(
							width: double.infinity,
							height: 42.h,
							child: OutlinedButton(
								onPressed: () {
									setState(() {

									});
								},
								style: OutlinedButton.styleFrom(
									side: BorderSide(
										color: theme.colorScheme.primary.withValues(alpha: 0.45),
									),
									shape: RoundedRectangleBorder(
										borderRadius:
												BorderRadius.circular(context.radius.xxl.r),
									),
								),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										SvgPicture.asset(
											AssetsPathHelper.profileAdd,
											width: 18.w,
											height: 18.h,
											colorFilter: ColorFilter.mode(
												theme.colorScheme.primary,
												BlendMode.srcIn,
											),
										),
										SizedBox(width: context.spacing.sm.w),
										Text(
											'إضافة طفل آخر',
											style: theme.textTheme.bodyMedium?.copyWith(
														fontSize: 15.sp,
														fontWeight: FontWeight.w700,
														color: theme.colorScheme.primary,
													) ??
													TextStyle(
														fontSize: 15.sp,
														fontWeight: FontWeight.w700,
														color: theme.colorScheme.primary,
													),
										),
									],
								),
							),
						),
					],
				),
			),
		);
	}

	Widget _buildDropdownField({
		required String hintText,
		required String iconPath,
		required String? value,
		required List<String> items,
		required ValueChanged<String?> onChanged,
		required String? Function(String?) validator,
	}) {
		final ThemeData theme = Theme.of(context);

		return DropdownButtonFormField<String>(
				initialValue: value,
			icon: const SizedBox.shrink(),
			validator: validator,
			onChanged: onChanged,
			decoration: InputDecoration(
				hintText: hintText,
				hintStyle: theme.textTheme.bodyMedium?.copyWith(
							color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
							fontSize: 13.sp,
						) ??
						TextStyle(
							color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
							fontSize: 13.sp,
						),
				prefixIcon: Padding(
					padding: EdgeInsets.all(context.spacing.m.r),
					child: SvgPicture.asset(iconPath),
				),
				suffixIcon: Icon(
					Icons.keyboard_arrow_down_rounded,
					color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
					size: 22.sp,
				),
				filled: true,
				fillColor: theme.colorScheme.surfaceContainerHighest,
				contentPadding: EdgeInsets.symmetric(
					vertical: context.spacing.md.h,
					horizontal: context.spacing.md.w,
				),
				enabledBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(context.radius.xl.r),
					borderSide: BorderSide(color: theme.colorScheme.outline),
				),
				focusedBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(context.radius.xl.r),
					borderSide: BorderSide(color: theme.colorScheme.primary),
				),
				errorBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(context.radius.xl.r),
					borderSide: BorderSide(color: theme.colorScheme.error),
				),
			),
			items: items
					.map(
						(String item) => DropdownMenuItem<String>(
							value: item,
							child: Text(item),
						),
					)
					.toList(),
		);
	}

	Widget _buildDateField() {
		final ThemeData theme = Theme.of(context);
		final String displayText = _selectedBirthDate == null
				? 'تاريخ الميلاد'
				: _formatBirthDate(_selectedBirthDate!);

		return FormField<String>(
			validator: (_) {
				if (_selectedBirthDate == null) {
					return 'الرجاء اختيار تاريخ الميلاد';
				}
				return null;
			},
			builder: (FormFieldState<String> fieldState) {
				return GestureDetector(
					onTap: () async {
						await _pickBirthDate();
						fieldState.validate();
					},
					child: InputDecorator(
						decoration: InputDecoration(
							hintText: 'تاريخ الميلاد',
							hintStyle: theme.textTheme.bodyMedium?.copyWith(
										color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
										fontSize: 13.sp,
									) ??
									TextStyle(
										color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
										fontSize: 13.sp,
									),
							prefixIcon: Padding(
								padding: EdgeInsets.all(context.spacing.m.r),
								child: SvgPicture.asset(AssetsPathHelper.calendar),
							),
							suffixIcon: Icon(
								Icons.calendar_month_outlined,
								color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
								size: 20.sp,
							),
							filled: true,
							fillColor: theme.colorScheme.surfaceContainerHighest,
							contentPadding: EdgeInsets.symmetric(
								vertical: context.spacing.md.h,
								horizontal: context.spacing.md.w,
							),
							enabledBorder: OutlineInputBorder(
								borderRadius: BorderRadius.circular(context.radius.xl.r),
								borderSide: BorderSide(color: theme.colorScheme.outline),
							),
							focusedBorder: OutlineInputBorder(
								borderRadius: BorderRadius.circular(context.radius.xl.r),
								borderSide: BorderSide(color: theme.colorScheme.primary),
							),
							errorBorder: OutlineInputBorder(
								borderRadius: BorderRadius.circular(context.radius.xl.r),
								borderSide: BorderSide(color: theme.colorScheme.error),
							),
						),
						isEmpty: _selectedBirthDate == null,
						child: Text(
							displayText,
							style: theme.textTheme.bodyMedium?.copyWith(
										color: _selectedBirthDate == null
												? theme.colorScheme.onSurface.withValues(alpha: 0.4)
												: theme.colorScheme.onSurface,
									) ??
									TextStyle(
										color: _selectedBirthDate == null
												? theme.colorScheme.onSurface.withValues(alpha: 0.4)
												: theme.colorScheme.onSurface,
									),
						),
					),
				);
			},
		);
	}
}
