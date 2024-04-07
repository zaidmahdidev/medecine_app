import 'package:detection_of_smuggled_medication/shard/bloc_cubit/home/home_cubit.dart';
import 'package:detection_of_smuggled_medication/shard/components/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../shard/bloc_cubit/home/home_state.dart';

class MedicineDetails extends StatefulWidget {
  MedicineDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  TextEditingController notesController = TextEditingController();

  double? ratingValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {
        if(state is RatingSuccessDataState){
          Navigator.pop(context);
          ToastManager.showToast('شكرا على وضع اقتراحق', ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        if(state is RatingLoadingDataState){
          return CustomLoading();
        }
        return Scaffold(
          appBar: AppBar(


            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:  Icon(
                Icons.arrow_back_ios_sharp,
                // color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .33,
                padding: const EdgeInsets.only(bottom: 20),
                width: double.infinity,
                // child: Image.asset(
                //   'assets/image/logo.png',
                // ),
                child: Image.network(
                  fit: BoxFit.cover,
                    '${HomeCubit.get(context).checkModel!.imagePath}'
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 40, right: 14, left: 14 ),
                      decoration:  BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${HomeCubit.get(context).checkModel!.name}',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  '  الصنف : ',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  '${HomeCubit.get(context).checkModel!.category}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  '  الحالة : ',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  '${HomeCubit.get(context).checkModel!.message}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'يسعدنا أن تضع اقتراحك',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 15),
                            RatingBar.builder(
                              initialRating: 0,
                              itemSize: 35,
                              minRating: 0,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  ratingValue = rating;
                                });

                                print(rating);
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: notesController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                hintText: 'تعليق...',
                                hintStyle: TextStyle(fontSize: 13),
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 5,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
              height: 70,
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 15),
              child: defaultButton(
                  background:   Theme.of(context).secondaryHeaderColor,
                  fun: () {
                HomeCubit.get(context).addRating(stars: ratingValue!.round(), comment: notesController.text);
              }, text: 'موافق', radius: 10)),
        );
      },
    );

  }
}


