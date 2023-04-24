import 'package:employ_info/cubit/employee_detail/employee_detail_cubit.dart';
import 'package:employ_info/cubit/employee_detail/employee_detail_state.dart';
import 'package:employ_info/extension/date_time_extensions.dart';
import 'package:employ_info/services/sql_service.dart';
import 'package:employ_info/widgets/employee_detail/text_item.dart';
import 'package:employ_info/widgets/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employ_info/extension/string_extensions.dart';

class EmployeeDetailsWidget extends StatefulWidget {
  const EmployeeDetailsWidget({Key? key}) : super(key: key);

  @override
  State<EmployeeDetailsWidget> createState() => _EmployeeDetailsWidgetState();
}

class _EmployeeDetailsWidgetState extends State<EmployeeDetailsWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController surNameCtrl = TextEditingController();
  final TextEditingController jobCtrl = TextEditingController();
  final TextEditingController adressStreetCtrl = TextEditingController();
  final TextEditingController adressStreetNumberCtrl = TextEditingController();
  final TextEditingController adressPlzCtrl = TextEditingController();
  late bool isEditable = false;

  @override
  void initState() {
    context.read<EmployeeDetailCubit>().getEmployeeDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employee Details'),
          backgroundColor: Colors.blueAccent,
          actions: [
            ElevatedButton(
                onPressed: () async {
                  await _saveOrEdit(context);
                },
                child: Text(isEditable ? 'Save' : 'Edit')),
          ],
        ),
        body: BlocBuilder<EmployeeDetailCubit, EmployeeDetailState>(
            builder: (context, state) {
          if (state is EmployeeDetailInitState ||
              state is EmployeeDetailLoadState) {
            return UIHelper.getProgress(
                txt: 'Processing database, please wait ...');
          } else if (state is EmployeeDetailLoadedState) {
            return Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    TextItem(
                        label: 'Name: ',
                        textCtrl: nameCtrl,
                        defValue: state.name.toEmptyStringIfNull(),
                        inputTypeValue: TextInputType.name,
                        isEditMode: isEditable,
                        onTextValueChange: (val) => context
                            .read<EmployeeDetailCubit>()
                            .employName = val),
                    TextItem(
                        label: 'SurName: ',
                        textCtrl: surNameCtrl,
                        defValue: state.surName.toEmptyStringIfNull(),
                        inputTypeValue: TextInputType.name,
                        isEditMode: isEditable,
                        onTextValueChange: (val) => context
                            .read<EmployeeDetailCubit>()
                            .employSurName = val),
                    _DateLine(
                        date: state.birthDate != null ? state.birthDate! : null,
                        isEditable: isEditable),
                    TextItem(
                        label: 'Job: ',
                        textCtrl: jobCtrl,
                        defValue: state.job.toEmptyStringIfNull(),
                        inputTypeValue: TextInputType.text,
                        isEditMode: isEditable,
                        onTextValueChange: (val) => context
                            .read<EmployeeDetailCubit>()
                            .employJob = val),
                    _GenderLine(
                        selectedValue: state.gender, isEditable: isEditable),
                    TextItem(
                        label: 'Adress Street: ',
                        textCtrl: adressStreetCtrl,
                        defValue: state.adressStreet.toEmptyStringIfNull(),
                        inputTypeValue: TextInputType.streetAddress,
                        isEditMode: isEditable,
                        onTextValueChange: (val) => context
                            .read<EmployeeDetailCubit>()
                            .employAdressStreet = val),
                    TextItem(
                        label: 'Adress Street Number: ',
                        textCtrl: adressStreetNumberCtrl,
                        defValue:
                            state.adressStreetNumber.toEmptyStringIfNull(),
                        inputTypeValue: TextInputType.streetAddress,
                        isEditMode: isEditable,
                        onTextValueChange: (val) => context
                            .read<EmployeeDetailCubit>()
                            .employAdressStreetNumber = val),
                    TextItem(
                        label: 'adressPlz: ',
                        textCtrl: adressPlzCtrl,
                        defValue: state.adressPlz.toEmptyStringIfNull(),
                        inputTypeValue: TextInputType.number,
                        isEditMode: isEditable,
                        onTextValueChange: (val) => context
                            .read<EmployeeDetailCubit>()
                            .employAdressPlz = 1),
                  ],
                )));
          } else if (state is EmployeeDetailErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Database error when saving data !',
                      style: Theme.of(context).textTheme.headlineSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: ElevatedButton(
                      onPressed: () async => await context
                          .read<EmployeeDetailCubit>()
                          .saveEmployeeDetails(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      child: const Text('Retry'),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        }));
  }

  Future<void> _saveOrEdit(BuildContext context) async {
    if (isEditable) {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      await context.read<EmployeeDetailCubit>().saveEmployeeDetails(context);
    }
    setState(() {
      isEditable = !isEditable;
    });
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    surNameCtrl.dispose();
    jobCtrl.dispose();
    adressStreetCtrl.dispose();
    adressStreetNumberCtrl.dispose();
    adressPlzCtrl.dispose();
    super.dispose();
  }
}

class _DateLine extends StatelessWidget {
  final DateTime? date;
  final bool isEditable;

  const _DateLine({
    Key? key,
    required this.date,
    required this.isEditable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Text('Birth date',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
                onTap: isEditable
                    ? () => {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true, onConfirm: (newDate) {
                            context
                                .read<EmployeeDetailCubit>()
                                .employBirthDate = newDate;
                          }, currentTime: date, locale: LocaleType.pl)
                        }
                    : null,
                child: Text(date!.ddMMYYYY,
                    style: Theme.of(context).textTheme.headlineSmall)),
          )
        ],
      ),
    );
  }
}

class _GenderLine extends StatelessWidget {
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  final int? selectedValue;
  final bool isEditable;
  String? selectedItem;

  _GenderLine({
    Key? key,
    required this.selectedValue,
    required this.isEditable,
  }) : super(key: key) {
    if (selectedValue != null) {
      selectedItem = genderItems[selectedValue! - 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Text('Gender: ',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          Expanded(
            flex: 2,
            child: DropdownButtonFormField2(
              isDense: true,
              isExpanded: true,
              hint: Text(
                'Select Your Gender',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              items: genderItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select gender.';
                }
                return null;
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                labelText: "Gender",
              ),
              value: selectedItem,
              onChanged: isEditable
                  ? (value) {
                      final str = value as String;
                      context.read<EmployeeDetailCubit>().employeeGender =
                          str.startsWith('M')
                              ? SqliteService.male
                              : SqliteService.female;
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
