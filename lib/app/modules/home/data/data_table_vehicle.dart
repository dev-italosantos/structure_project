import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:structure_project/app/modules/home/forms/forms_controller.dart';
import 'package:structure_project/app/shared/models/vehicle_model.dart';

class DataTableVehicle extends StatefulWidget {
  @override
  _DataTableVehicleState createState() => _DataTableVehicleState();
}

class _DataTableVehicleState extends State<DataTableVehicle> {
  final formsController = Modular.get<FormsController>();
  
  List<VehicleModel> selectedVehicle;
  
  @override
  void initState() {
    selectedVehicle = [];
    super.initState();
  }

  onSelectRow(bool selected, VehicleModel data) async {
    setState(() {
      if (selected) {
        selectedVehicle.add(data);
      } else {
        selectedVehicle.remove(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (BuildContext context) {
          if (formsController.vehicle.error != null) {
            return Center(
              child: RaisedButton(
                child: Text('Pressuice Novamente'),
                onPressed: () {
                  formsController.fatchVehicle();
                },
              ),
            );
          }
          if (formsController.vehicle.value == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var list = formsController.vehicle.value;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: DataTable(
                  decoration: BoxDecoration(),
                  columns: [
                    DataColumn(
                      label: Text('Code'),
                    ),
                    DataColumn(
                      label: Text('Nome'),
                    ),
                    DataColumn(
                      label: Text('Modelo'),
                    ),
                    DataColumn(
                      label: Text('Tipo'),
                    ),
                    DataColumn(
                      label: Text('Motivo da baixa'),
                    ),
                    DataColumn(
                      label: Text('Placa'),
                    ),
                    DataColumn(
                      label: Text('Ano'),
                    ),
                    DataColumn(
                      label: Text('Chassi'),
                    ),
                    DataColumn(
                      label: Text('Data da Baixa'),
                    ),
                    DataColumn(
                      label: Text('Centro de Custo'),
                    ),
                  ],
                  rows: list
                      .map((data) => DataRow(
                            selected: selectedVehicle.contains(data),
                            onSelectChanged: (b) {
                              print("Onselect");
                              onSelectRow(b, data).toString();
                            },
                            cells: [
                              DataCell(Text(data.code), onTap: () {
                                print('Select ${data.code}');
                              }),
                              DataCell(Text(data.name)),
                              DataCell(Text(data.modelo)),
                              DataCell(Text(data.tipo)),
                              DataCell(Text(data.motivo_baixa)),
                              DataCell(Text(data.placa)),
                              DataCell(Text(data.ano)),
                              DataCell(Text(data.chassi)),
                              DataCell(Text(data.data_baixa)),
                              DataCell(Text(data.centro_custo)),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
