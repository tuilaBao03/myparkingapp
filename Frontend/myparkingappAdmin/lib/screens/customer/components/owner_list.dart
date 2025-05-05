// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, non_constant_identifier_names

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/customer/customer_bloc.dart';
import 'package:myparkingappadmin/bloc/customer/customer_event.dart';
import 'package:myparkingappadmin/bloc/customer/customer_state.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/customer/components/add_owner.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';
import 'package:myparkingappadmin/screens/general/search.dart';
import 'package:myparkingappadmin/screens/myprofile/components/customer_detail.dart';
import 'package:myparkingappadmin/screens/parkingLot/parkingLotList.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class OwnerList extends StatefulWidget {
  final UserResponse user;
  const OwnerList({
    super.key, required this.user,
  });

  @override
  _OwnerListState createState() => _OwnerListState();
}

class _OwnerListState extends State<OwnerList> {
  bool isDetail = false;
  List<UserResponse> customers = [];
  List<UserResponse> _allCustomers = [];
  UserResponse? user;
  final HashSet<String> objectColumnNameOfCustomer =
      HashSet.from(["FullName", "Actions"]);
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCustomer(String value) {
    value = value.trim().toLowerCase();
    setState(() {
      customers = _allCustomers.where((c) =>
      c.firstName.toLowerCase().contains(value) ||
          c.lastName.toLowerCase().contains(value) ||
          c.homeAddress.toLowerCase().contains(value)
      ).toList();
      print(customers.length);
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(LoadedOwnerScreenEvent(widget.user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, UserState>(builder: (context, state) {
      if (state is CustomerLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CustomerLoadedState) {
        _allCustomers = state.customerList;
        customers = List.from(_allCustomers); // Gán bản sao
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
              title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  AppLocalizations.of(context).translate("owner").toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                flex: 5,
                child: Search(onSearch: (value) {
                  print(value);
                  _filterCustomer(value);
                }),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh,size: 30,),
                      onPressed: () {
                        context
                            .read<CustomerBloc>()
                            .add(LoadedOwnerScreenEvent(widget.user));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 30),
                      onPressed: () {
                        _showAddOwnerDialog(context);
                      },
                    ),
                    
                  ],
                ),
              ),
            ],
          )),
          body: Container(
            height: Get.height,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: customers.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context).translate(
                                    "There is no matching information"),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          : SizedBox(

                              width: double.infinity,
                              child: DataTable(
                                columnSpacing: defaultPadding,
                                columns: objectColumnNameOfCustomer
                                    .map(
                                      (name) => DataColumn(
                                        label: Text(
                                          AppLocalizations.of(context)
                                              .translate(name),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                rows: customers.map((lotOwner) {
                                  return _buildDataRow(lotOwner, context);
                                }).toList(),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  isDetail
                      ? Expanded(
                          child: UserDetail(
                            user: user!,
                          ),
                        )
                      : SizedBox(
                          width: 0,
                        )
                ],
              ),
  
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    }, listener: (context, state) {
      if (state is OwnerErrorState) {
        AppDialog.showErrorEvent(context, state.mess,onPress: (){
          context.read<CustomerBloc>().add(LoadedOwnerScreenEvent(widget.user));
        });
      } else if (state is OwnerSuccessState) {
        AppDialog.showSuccessEvent(context, state.mess, onPress: (){
          context.read<CustomerBloc>().add(LoadedOwnerScreenEvent(widget.user));
        }
        );
      }
    });
  }

  DataRow _buildDataRow(UserResponse user, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text("${user.lastName} ${user.firstName} ")),
        DataCell(
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.details, color: Colors.green),
                  onPressed: () => {
                        setState(() {
                          this.user = user;
                          isDetail = true;
                          print(user.userId);
                        })
                      }),
              IconButton(
                icon: const Icon(Icons.content_paste_search_outlined,
                    color: Colors.blueAccent),
                onPressed: () => {
                  setState(() {
                    this.user = user;
                    isDetail = false;
                    print(user.userId);
                  }),
                  _showParkingLotDialog(context, user),
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showParkingLotDialog(BuildContext context, UserResponse user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: Get.height / 1.2,
              width: Get.width / 1.2,
              child: ParkingLotList(user: user)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
  void _showAddOwnerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: Get.height / 1.2,
              width: Get.width / 1.2,
              child: AddOwner()),
          actions: [
            TextButton(
              onPressed: () => {
                context.read<CustomerBloc>().add(LoadedOwnerScreenEvent(widget.user)),
                Navigator.of(context).pop(),},
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}


