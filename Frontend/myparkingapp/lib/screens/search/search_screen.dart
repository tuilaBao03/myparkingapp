import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/main_screen.dart';

import '../../bloc/search/search_bloc.dart';
import '../../bloc/search/search_event.dart';
import '../../bloc/search/search_state.dart';
import '../../components/cards/big/parkingLot_info_big_card.dart';
import '../../components/pagination_button.dart';
import '../../constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ParkingLotResponse> lots = [];
  int page = 1;
  int pageAmount = 1;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(
      SearchScreenSearchAndChosenPageEvent(searchText, page),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserResponse user = demoUser;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Chiều cao mong muốn
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          backgroundColor: Colors.black.withOpacity(0.5),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.close, color: Colors.white),
                        onPressed:
                            () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              ),
                            },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 6,
                      child: Text(
                        AppLocalizations.of(context).translate('Search'),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: defaultPadding / 2),
                SearchForm(page: page),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchScreenLoading) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.greenAccent,
                size: 25,
              ),
            );
          } else if (state is SearchScreenLoaded) {
            user = state.user;
            lots = state.lotOnPage.lots;
            page = state.lotOnPage.page;
            pageAmount = state.lotOnPage.pageAmount;
            searchText = state.searchText;
            return lots.isNotEmpty ? 
              SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: ListView(
                  children: [
                    const SizedBox(height: defaultPadding),

                    const SizedBox(height: defaultPadding),
                    ParkingLotList(lots: lots, user: user),
                    const SizedBox(height: defaultPadding),

                    PaginationButtons(
                      page: page,
                      pageTotal: pageAmount,
                      onPageChanged: (newPage) {
                        setState(() {
                          page = newPage;
                          context.read<SearchBloc>().add(
                            SearchScreenSearchAndChosenPageEvent(
                              searchText,
                              page,
                            ),
                          ); // Gọi hàm search
                        });
                        // Gọi API hoặc cập nhật dữ liệu cho trang mới
                      },
                    ), // Không cần SingleChildScrollView nữa
                  ],
                ),
              ),
            ) : 
            Center(
              child: Text(AppLocalizations.of(context).translate("Don't have suitable parking lot")),
            );
          }
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.greenAccent,
              size: 25,
            ),
          );
        },
        listener: (context, state) {
          if (state is SearchScreenError) {
            return AppDialog.showErrorEvent(
              context,
              AppLocalizations.of(context).translate(state.mess),
              onPress: () {},
            );
          }
        },
      ),
    );
  }
}

class SearchForm extends StatefulWidget {
  final int page;

  const SearchForm({super.key, required this.page});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        onFieldSubmitted: (value) {
          if (_formKey.currentState!.validate()) {
            context.read<SearchBloc>().add(
              SearchScreenSearchAndChosenPageEvent(
                _controller.text,
                widget.page,
              ),
            ); // Gọi hàm search
          }
        },
        validator: requiredValidator.call,
        style: Theme.of(context).textTheme.labelLarge,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Search parking...",
          contentPadding: kTextFieldPadding,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              colorFilter: const ColorFilter.mode(
                bodyTextColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
