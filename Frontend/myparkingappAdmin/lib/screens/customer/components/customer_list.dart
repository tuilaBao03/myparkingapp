// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, non_constant_identifier_names

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/customer/customer_bloc.dart';
import 'package:myparkingappadmin/bloc/customer/customer_event.dart';
import 'package:myparkingappadmin/bloc/customer/customer_state.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';
import 'package:myparkingappadmin/screens/general/search.dart';
import 'package:myparkingappadmin/screens/myprofile/components/customer_detail.dart';
import 'package:myparkingappadmin/screens/wallet/wallet_list.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class CustomerList extends StatefulWidget {
  const CustomerList({
    super.key,
  });

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  List<UserResponse> customers = [];
  bool isDetail = false;
  UserResponse user = UserResponse.empty();
  final HashSet<String> objectColumnNameOfCustomer =
      HashSet.from(["FullName", "Detail", "Wallets"]);
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCustomer(String value ){
    value = value.trim();
    setState(() {
      customers = customers.where((c)=>c.firstName.contains(value) || c.lastName.contains(value) || c.homeAddress.contains(value)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(LoadedCustomerScreenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, UserState>(builder: (context, state) {
      if (state is CustomerLoadingState) {
        Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CustomerLoadedState) {
        customers = state.customerList;
        return Scaffold(
          appBar: AppBar(
              toolbarHeight: 100,
              title: Row(
<<<<<<< HEAD
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  AppLocalizations.of(context).translate("customer").toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                flex: 5,
                child: Search(onSearch: (value) {
                  _filterCustomer(value);
                }),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        context.read<CustomerBloc>().add(LoadedCustomerScreenEvent());
                      },
=======
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      AppLocalizations.of(context).translate("CUSTOMER"),
                      style: Theme.of(context).textTheme.titleMedium,
>>>>>>> main
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Search(onSearch: (value) {
                      context
                          .read<CustomerBloc>()
                          .add(LoadedCustomerScreenEvent(value));
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            context
                                .read<CustomerBloc>()
                                .add(LoadedCustomerScreenEvent(""));
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
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: defaultPadding),
                        Container(
                          child: customers.isEmpty
                              ? Center(
                                  child: Text(
                                    AppLocalizations.of(context).translate(
                                        "There is no matching information"),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  isDetail
                      ? Expanded(
                          child: UserDetail(
                            user: user,
                          ),
                        )
                      : SizedBox(
                          width: 0,
                        )
                ],
              )),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    }, listener: (context, state) {
      if (state is CustomerErrorState) {
<<<<<<< HEAD
        AppDialog.showErrorEvent(context, state.mess,
        onPress:()=> {
          context.read<CustomerBloc>().add(LoadedCustomerScreenEvent()),
          Navigator.pop(context)
        },
        );
      } else if (state is CustomerSuccessState) {
        AppDialog.showSuccessEvent(context, state.mess,onPress:()=> {
          context.read<CustomerBloc>().add(LoadedCustomerScreenEvent()),
          Navigator.pop(context)
        },
        
        );
=======
        AppDialog.showErrorEvent(context, state.mess);
      } else if (state is CustomerErrorState) {
        AppDialog.showErrorEvent(context, state.mess);
      } else if (state is OwnerSuccessState) {
        AppDialog.showSuccessEvent(context, state.mess);
>>>>>>> main
      }
    });
  }

  DataRow _buildDataRow(UserResponse user, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text("${user.lastName} ${user.firstName} ")),
        DataCell(
          IconButton(
              icon: const Icon(Icons.details, color: Colors.green),
              onPressed: () => {
                    isDetail = true,
                    setState(() {
                      this.user = user;
                    })
                  }),
        ),
        DataCell(
          IconButton(
              icon: const Icon(Icons.content_paste_search_outlined,
                  color: Colors.blueAccent),
              onPressed: () => {
                    isDetail = true,
                    setState(() {
                      this.user = user;
                    }),
                    _showWalletDialog(context, user),
                  }),
        ),
      ],
    );
  }

  void _showWalletDialog(BuildContext context, UserResponse user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: Get.height / 1.2,
            width: Get.width / 1.2,
            child: WalletList(
              customerId: user.userId,
            ),
          ),
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
}
