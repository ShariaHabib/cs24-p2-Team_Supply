import 'package:ecosync/features/manage_sts/controller/delete_sts_controller.dart';
import 'package:ecosync/features/manage_sts/widget/edit_sts_popup.dart';
import 'package:ecosync/features/manage_users/controller/user_controller.dart';
import 'package:ecosync/features/manage_users/widget/edit_user_popup.dart';
import 'package:ecosync/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_delete_dialog.dart';
import '../../../common/custom_dropdown_button.dart';
import '../../../common/custom_response_dialog.dart';
import '../../../models/sts_model.dart';
import '../controller/get_sts_controller.dart';

class STSTableView extends StatefulWidget {
  STSTableView({super.key, required this.sts});
  final List<STS> sts;
  @override
  State<STSTableView> createState() => _STSTableViewState();
}

class _STSTableViewState extends State<STSTableView> {
  int? sortColumnIndex;
  bool isAscending = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetSTScontroller>().getData(context);
    context.read<GetUsersController>().getData(context);
  }

  final columns = [
    'Ward No',
    'STS ID',
    'latitude',
    'longitude',
    'Capacity',
    'Manager',
    '',
  ];

  Map<String, String> convert(List<STS> x) {
    Map<String, String> out = {};
    for (var i in x) {
      out[i.manager] = i.manager;
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    DeleteSTSController ctr = context.watch<DeleteSTSController>();
    GetSTScontroller ctr2 = context.watch<GetSTScontroller>();

    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 0,
        border: TableBorder.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        dividerThickness: 0.5,
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        headingRowHeight: 40,
        headingRowColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.surfaceVariant),
        columns: getColumns(columns),
        rows: getRows(widget.sts, ctr, ctr2),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(
          List<STS> sts, DeleteSTSController ctr, GetSTScontroller ctr2) =>
      sts.map((STS sts) {
        final cells = [
          DataCell(
            Text(sts.ward_no.toString(), style: const TextStyle(fontSize: 10)),
          ),
          DataCell(
            Text(sts.sts_id.toString()),
          ),
          DataCell(
            Text(sts.latitude.toString()),
          ),
          DataCell(
            Text(sts.longitude.toString()),
          ),
          DataCell(
            Text(sts.capacity.toString()),
          ),
          DataCell(ctr2.loading
              ? const CircularProgressIndicator()
              : CustomDropDownButton(
                  controller: controller,
                  data: convert(ctr2.data),
                  initialentry: convert(ctr2.data)
                      .entries
                      .firstWhere((element) => element.value == sts.manager)
                      .key,
                  onChange: (userId) async {
                    print(userId);
                  },
                )),
          DataCell(
            _buildActionButtons(sts, ctr),
          ),
        ];

        return DataRow(cells: cells);
      }).toList();
  Widget _buildActionButtons(STS sts, DeleteSTSController ctr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return EditSTS(
                    ward_no: sts.ward_no,
                    stsId: sts.sts_id,
                    latitude: sts.latitude,
                    longitude: sts.longitude,
                    manager: sts.manager,
                    capacity: sts.capacity,
                  );
                });
          },
          icon: const Icon(Icons.edit),
          color: Theme.of(context).colorScheme.primary,
        ),
        IconButton(
          onPressed: () {
            customDeleteDialog(context, () async {
              await context
                  .read<DeleteSTSController>()
                  .deleteData(context, sts.ward_no);

              if (!ctr.loading && ctr.success && context.mounted) {
                customResponseDialog(context, "STS Deleted Successfully", "")
                    .then((value) =>
                        context.read<GetSTScontroller>().getData(context));
              }
            });
          },
          icon: const Icon(Icons.delete_forever),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      widget.sts.sort((sts1, sts2) => compareString(
          ascending, sts1.ward_no.toString(), sts2.ward_no.toString()));
    } else if (columnIndex == 1) {
      widget.sts.sort((sts1, sts2) => compareString(
          ascending, sts1.sts_id.toString(), sts2.sts_id.toString()));
    } else if (columnIndex == 2) {
      widget.sts.sort((sts1, sts2) => compareString(
          ascending, sts1.capacity.toString(), sts2.capacity.toString()));
    } else if (columnIndex == 3) {
      widget.sts.sort((sts1, sts2) => compareString(
          ascending, sts1.latitude.toString(), sts2.latitude.toString()));
    } else if (columnIndex == 4) {
      widget.sts.sort((sts1, sts2) => compareString(
          ascending, sts1.longitude.toString(), sts2.longitude.toString()));
    } else if (columnIndex == 5) {
      widget.sts.sort(
          (sts1, sts2) => compareString(ascending, sts1.manager, sts2.manager));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
