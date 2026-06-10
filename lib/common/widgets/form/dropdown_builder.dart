// import 'package:flutter/material.dart';

// class TemarLijesDropdownFormField extends FormField<String> {
//   TemarLijesDropdownFormField({
//     super.key,
//     required this.items,
//     required this.label,
//     required this.required,
//     String? initialValue,
//     super.onSaved,
//     super.validator,
//     super.autovalidateMode,
//   }) : super(
//          initialValue: initialValue,
//          builder: (FormFieldState<String> state) {
//            return DropdownButtonFormField<String>(
//              initialValue: state.value,
//              decoration: InputDecoration(
//                labelText: '$label${required ? ' *' : ''}',
//                border: const OutlineInputBorder(),
//                prefixIcon: const Icon(Icons.arrow_drop_down_circle),
//                errorText: state.errorText,
//              ),
//              items: items.map((item) {
//                return DropdownMenuItem(value: item, child: Text(item));
//              }).toList(),
//              onChanged: (value) => state.didChange(value),
//            );
//          },
//        );

//   final List<String> items;
//   final String label;
//   final bool required;

//   @override
//   FormFieldState<String> createState() => _TemarLijesFormFieldState();
// }

// class _TemarLijesFormFieldState extends FormFieldState<String> {
//   @override
//   void didChange(String? value) {
//     super.didChange(value);
//     setValue(value);
//   }
// }
import 'package:flutter/material.dart';

class TemarLijesDropdownFormField extends FormField<String> {
  TemarLijesDropdownFormField({
    super.key,
    required this.items,
    required this.label,
    required this.required,
    String? initialValue,
    super.onSaved,
    super.validator,
    this.onChanged, // Add this parameter
    super.autovalidateMode,
  }) : super(
         initialValue: initialValue,
         builder: (FormFieldState<String> state) {
           return DropdownButtonFormField<String>(
             initialValue: state.value,
             decoration: InputDecoration(
               labelText: '$label${required ? ' *' : ''}',
               border: const OutlineInputBorder(),
               prefixIcon: const Icon(Icons.arrow_drop_down_circle),
               errorText: state.errorText,
             ),
             items: items.map((item) {
               return DropdownMenuItem(value: item, child: Text(item));
             }).toList(),
             onChanged: (value) {
               state.didChange(value);
               onChanged?.call(value); // Call the onChanged callback
             },
           );
         },
       );

  final List<String> items;
  final String label;
  final bool required;
  final void Function(String?)? onChanged; // Add this

  @override
  FormFieldState<String> createState() => _TemarLijesFormFieldState();
}

class _TemarLijesFormFieldState extends FormFieldState<String> {
  @override
  void didChange(String? value) {
    super.didChange(value);
    setValue(value);
  }
}
